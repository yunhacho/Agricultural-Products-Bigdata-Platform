//
//  FoodCompare.swift
//  Jongp2
//
//  Created by junseok on 2021/05/30.
//

import Foundation
import UIKit
import SnapKit
import Alamofire


class FoodCompareViewController : UIViewController{
    
    var SettingView : UIView!
    

    let ItemTitleLabel = UILabel()
    let ItemEditText = UITextField()
    let ItemPicker = UIPickerView()
    let ItemToolbar = UIToolbar()
    
    let DateTitleLabel = UILabel()
    let DateEditText = UITextField()
    let DatePicker = UIDatePicker()
    let DateToolbar = UIToolbar()
    
    let SearchBtn = UIButton()
    
    let ItemNames = ["오이" , "양파", "파", "호박", "쌀"]
    let ItemDict : [String : Int] = ["오이" : 0, "양파" : 1, "파" : 2, "호박" : 3, "쌀" : 4]
    var Item = "옹"
    
    var selectItem = "오이"
    var selectDate = "20210602"
    var currentDate : Date!
    
    let FoodTitleLabel = UIView()
    let FoodTableView = UITableView()
    var FoodContents : [FoodContent] = []
    
    let borderWidth : CGFloat = 0.2
    let borderColor : CGColor = UIColor.lightGray.cgColor
    
    override func viewDidLoad() {
        super.viewDidLayoutSubviews()
        self.InitUI()
        self.addView()
        self.makeConstraints()
        self.InitItemPicker()
        self.InitDate()
        self.InitDatePicker()
        self.InitTitle()
        
        getBeforePrice(item : ItemDict[selectItem]!, date : selectDate)
    }
    
    func addView(){
        self.view.addSubview(SettingView)
        self.view.isUserInteractionEnabled = true
        
        SettingView.addSubview(DateTitleLabel)
        SettingView.addSubview(DateEditText)
        
        SettingView.addSubview(ItemTitleLabel)
        SettingView.addSubview(ItemEditText)
        
        self.view.addSubview(SearchBtn)
        
        self.view.addSubview(FoodTitleLabel)
        self.view.addSubview(FoodTableView)
    }
    
    func InitUI(){
        SettingView = UIView()
        SettingView.isUserInteractionEnabled = true
        SettingView.layer.borderWidth = 1
        SettingView.layer.borderColor = UIColor.lightGray.cgColor
        
        DateTitleLabel.text = "날짜"
        DateTitleLabel.textAlignment = .center
        DateTitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        ItemTitleLabel.text = "품목"
        ItemTitleLabel.textAlignment = .center
        ItemTitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
//        let config = UIImage.SymbolConfiguration(pointSize: 28, weight: .medium, scale: .default)
//        let systemImage = UIImage(systemName: "magnifyingglass", withConfiguration: config )
//
        SearchBtn.setTitle("검색하기", for: .normal)
        SearchBtn.setTitleColor(ColorSetting.btnTextColor, for: .normal)
        SearchBtn.backgroundColor = UIColor(rgb: ColorSetting.backgroundColor).withAlphaComponent(1).withAlphaComponent(ColorSetting.btnAlpha)
        SearchBtn.isUserInteractionEnabled = true
        SearchBtn.addTarget(self, action: #selector(self.onPress), for: .touchUpInside)
    }
    
    @objc func onPress() {
        print("Search click")
        getBeforePrice(item : ItemDict[selectItem]!, date : selectDate)
    }
    
    func InitTitle(){
        FoodTitleLabel.layer.borderWidth = 0.5
        
        
        let nameLabel = UILabel()
        let kindLabel = UILabel()
        let priceLabel = UILabel()
        let unitLabel = UILabel()
        
        nameLabel.text = "품목명(등급)"
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        kindLabel.text = "종류"
        kindLabel.textAlignment = .center
        kindLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        priceLabel.text = "가격"
        priceLabel.textAlignment = .center
        priceLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        unitLabel.text = "무게/개수"
        unitLabel.textAlignment = .center
        unitLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        FoodTitleLabel.addSubview(nameLabel)
        FoodTitleLabel.addSubview(kindLabel)
        FoodTitleLabel.addSubview(priceLabel)
        FoodTitleLabel.addSubview(unitLabel)
        
        nameLabel.layer.borderWidth = borderWidth
        nameLabel.layer.borderColor = borderColor
        nameLabel.snp.makeConstraints{ make in
            make.width.equalToSuperview().multipliedBy(0.25)
            make.height.equalToSuperview()
            make.leading.equalToSuperview()
        }
        
        kindLabel.layer.borderWidth = borderWidth
        kindLabel.layer.borderColor = borderColor
        kindLabel.snp.makeConstraints{ make in
            make.width.equalToSuperview().multipliedBy(0.35)
            make.height.equalToSuperview()
            make.leading.equalTo(nameLabel.snp.trailing)
        }
        
        priceLabel.layer.borderWidth = borderWidth
        priceLabel.layer.borderColor = borderColor
        priceLabel.snp.makeConstraints{ make in
            make.width.equalToSuperview().multipliedBy(0.2)
            make.height.equalToSuperview()
            make.leading.equalTo(kindLabel.snp.trailing)
        }
        
        unitLabel.layer.borderWidth = borderWidth
        unitLabel.layer.borderColor = borderColor
        unitLabel.snp.makeConstraints{ make in
            make.width.equalToSuperview().multipliedBy(0.2)
            make.height.equalToSuperview()
            make.leading.equalTo(priceLabel.snp.trailing)
        }
    }
    
    func makeConstraints(){

        SettingView.snp.makeConstraints{ make in
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.06)
            make.left.right.top.equalTo(0)
        }
        
        let Cellheight : Double = 1
        
        DateTitleLabel.layer.borderWidth = borderWidth
        DateTitleLabel.layer.borderColor = borderColor
        DateTitleLabel.snp.makeConstraints{ make in
            make.width.equalToSuperview().multipliedBy(0.2)
            make.height.equalToSuperview().multipliedBy(Cellheight)
            make.leading.equalToSuperview()
            make.top.equalTo(self.view).offset(0)
        }
        
        DateEditText.layer.borderWidth = borderWidth
        DateEditText.layer.borderColor = borderColor
        DateEditText.snp.makeConstraints{ make in
            make.width.equalToSuperview().multipliedBy(0.35)
            make.height.equalToSuperview().multipliedBy(Cellheight)
            make.leading.equalTo(DateTitleLabel.snp.trailing)
            make.top.equalTo(DateTitleLabel.snp.top)
        }
        
        ItemTitleLabel.layer.borderWidth = borderWidth
        ItemTitleLabel.layer.borderColor = borderColor
        ItemTitleLabel.snp.makeConstraints{ make in
            make.width.equalToSuperview().multipliedBy(0.2)
            make.height.equalToSuperview().multipliedBy(Cellheight)
            make.leading.equalTo(DateEditText.snp.trailing)
            make.top.equalTo(DateTitleLabel.snp.top)
        }
        
        ItemEditText.layer.borderWidth = borderWidth
        ItemEditText.layer.borderColor = borderColor
        ItemEditText.snp.makeConstraints{ make in
            make.width.equalToSuperview().multipliedBy(0.25)
            make.height.equalToSuperview().multipliedBy(Cellheight)
            make.leading.equalTo(ItemTitleLabel.snp.trailing)
            make.top.equalTo(DateTitleLabel.snp.top)
        }
        
        SearchBtn.snp.makeConstraints{ make in
            make.width.equalToSuperview().multipliedBy(1)
            make.height.equalTo(ItemEditText.snp.height).multipliedBy(0.7)
            make.leading.equalToSuperview()
            make.top.equalTo(SettingView.snp.bottom)
        }
        
        FoodTitleLabel.snp.makeConstraints{ make in
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.06)
            make.top.equalTo(SearchBtn.snp.bottom)
        }
        
        FoodTableView.snp.makeConstraints{ make in
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.9)
            make.top.equalTo(FoodTitleLabel.snp.bottom)
        }
    }
    
    func tableViewSetting(width : CGFloat, height : CGFloat){
        FoodTableView.translatesAutoresizingMaskIntoConstraints = false
        FoodTableView.register(FoodCell.self, forCellReuseIdentifier: FoodCell.identifier)
        FoodTableView.dataSource = self
        FoodTableView.rowHeight = height * 0.3
    }
    
//    func initFoodContents(){
//        for _ in 0..<10{
//            FoodContents.append(FoodContent(item_name: "오이", kind_name: "다다기계통(100개)", rank: "상품", price: 123450, unit: "10Kg", timeStamp: "2019-04-19"))
//        }
//    }
    
}

extension FoodCompareViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return FoodContents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FoodCell.identifier, for: indexPath) as! FoodCell
        cell.selectionStyle = .none
        
        if FoodContents.count > 0{
            cell.itemNameLabel.text = FoodContents[indexPath.row].item_name + "(\(FoodContents[indexPath.row].rank))"
            cell.kindLabel.text = FoodContents[indexPath.row].kind_name
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            cell.priceLabel.text = numberFormatter.string(for: FoodContents[indexPath.row].price)!
            cell.unitLabel.text = FoodContents[indexPath.row].unit
            cell.timestampLabel.text = FoodContents[indexPath.row].timestamp
            
            return cell
        }
        else {
            cell.itemNameLabel.text = "Not exist Any record"
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
}

extension FoodCompareViewController : UIPickerViewDelegate , UIPickerViewDataSource {
    
    func InitItemPicker(){
        let btnDone = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(self.onItemPickDone))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let btnCancel = UIBarButtonItem(title: "취소", style: .done, target: self, action: #selector(self.onItemPickCancel))
        btnDone.tintColor = UIColor(rgb: ColorSetting.backgroundColor)
        btnCancel.tintColor = UIColor(rgb: ColorSetting.backgroundColor)
        
        self.ItemPicker.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 220)
        self.ItemPicker.delegate = self
        self.ItemPicker.dataSource = self
        self.ItemPicker.backgroundColor = .white
        
        self.ItemToolbar.barStyle = .default
        self.ItemToolbar.isTranslucent = true  // 툴바가 반투명인지 여부 (true-반투명, false-투명)
        self.ItemToolbar.backgroundColor = .lightGray
        self.ItemToolbar.sizeToFit()   // 서브뷰만큼 툴바 크기를 맞춤
        self.ItemToolbar.setItems([btnCancel , space , btnDone], animated: true)   // 버튼추가
        self.ItemToolbar.isUserInteractionEnabled = true   // 사용자 클릭 이벤트 전달
        
        //RaceEditText.frame = CGRect(x: 0, y: 0, width:100, height: 30)
        ItemEditText.inputView = ItemPicker
        ItemEditText.inputAccessoryView = ItemToolbar
        ItemEditText.borderRect(forBounds: CGRect(x: 0, y: 0, width: 100, height: 30))
        ItemEditText.textAlignment = .center
        ItemEditText.text = ItemNames[0]
        ItemEditText.textColor = UIColor(rgb: ColorSetting.textColor).withAlphaComponent(1)
        ItemEditText.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    }
    
    @objc func onItemPickDone() {
        ItemEditText.text = selectItem
        ItemEditText.resignFirstResponder()
    }

    // 피커뷰 > 취소 클릭
    @objc func onItemPickCancel() {
        ItemEditText.resignFirstResponder() // 피커뷰를 내림 (텍스트필드가 responder 상태를 읽음)
    }
    
    func InitDate(){
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyyMMdd"
        let date = dateformatter.string(from: Calendar.current.date(byAdding: .day, value: -2, to: Date())!)
        selectDate = date
        currentDate = Calendar.current.date(byAdding: .day, value: -2, to: Date())!
    }
    
    func InitDatePicker(){
        let btnDone = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(self.onDatePickDone))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let btnCancel = UIBarButtonItem(title: "취소", style: .done, target: self, action: #selector(self.onDatePickCancel))
        btnDone.tintColor = UIColor(rgb: ColorSetting.backgroundColor)
        btnCancel.tintColor = UIColor(rgb: ColorSetting.backgroundColor)
        
        self.DateToolbar.barStyle = .default
        self.DateToolbar.isTranslucent = true  // 툴바가 반투명인지 여부 (true-반투명, false-투명)
        self.DateToolbar.backgroundColor = .lightGray
        self.DateToolbar.sizeToFit()   // 서브뷰만큼 툴바 크기를 맞춤
        self.DateToolbar.setItems([btnCancel , space , btnDone], animated: true)   // 버튼추가
        self.DateToolbar.isUserInteractionEnabled = true   // 사용자 클릭 이벤트 전달
        
        DatePicker.preferredDatePickerStyle = .wheels
        DatePicker.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 200)
        DatePicker.datePickerMode = .date
        DatePicker.timeZone = NSTimeZone.local
       
        DatePicker.minimumDate = Calendar.current.date(byAdding: .year, value: -10, to: Date())
        DatePicker.maximumDate = Calendar.current.date(byAdding: .day, value: -2, to: Date())
        DatePicker.setValue(UIColor.white, forKey: "backgroundColor")
        //TimeEditText.frame = CGRect(x: 0, y: 0, width:100, height: 30)
        DateEditText.inputView = DatePicker
        DateEditText.inputAccessoryView = DateToolbar
        DateEditText.textAlignment = .center
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy/MM/dd"
        let date = dateformatter.string(from: DatePicker.date)
        
        DateEditText.text = date
        DateEditText.textColor = UIColor(rgb: ColorSetting.textColor).withAlphaComponent(1)
        DateEditText.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
    }
    
    @objc func changed(){
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .none
        dateformatter.timeStyle = .short
    }
    
    @objc func onDatePickDone() {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy/MM/dd"
        DateEditText.text = dateformatter.string(from: DatePicker.date)
        currentDate = DatePicker.date
        
        dateformatter.dateFormat = "yyyyMMdd"
        selectDate = dateformatter.string(from: DatePicker.date)
        DateEditText.resignFirstResponder()
    }

    @objc func onDatePickCancel() {
        DateEditText.resignFirstResponder() // 피커뷰를 내림 (텍스트필드가 responder 상태를 읽음)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
   
    // 구성요소(컬럼)의 행수
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView == ItemPicker){
            return ItemNames.count
        }
        return 0
    }

    // 피커뷰에 보여줄 값 전달
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView == ItemPicker){
            selectItem = ItemNames[row]
            return ItemNames[row]
        } else {
            pickerView.subviews.forEach {
                $0.backgroundColor = .clear
            }
        }
        return ""
    }

    // 피커뷰에서 선택시 호출
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (pickerView == ItemPicker){
            selectItem = ItemNames[row]
        }
    }
    
}

extension FoodCompareViewController{
    
    func getBeforePrice(item : Int, date : String){
        
        print("\(WasURL.getURL(url:requestURL.days_before))?item=\(item)&date=\(date)")
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.year, .month, .weekOfMonth, .day]
        formatter.unitsStyle = .full
        
        getBeforeFood(url : "\(WasURL.getURL(url:requestURL.days_before))?item=\(item)&date=\(date)"){ [weak self] result in
            print(result)
            self?.FoodContents.removeAll()
            
            for i in 0..<result.count{
                let beforeDate : Date = dateFormatter.date(from: result[i].timestamp)!
                    
                let diffVal = formatter.string(from: beforeDate, to: (self?.currentDate)!)!
                let diffDate = diffVal.split(separator: " ")
                print(diffDate)
                self?.FoodContents.append(FoodContent(item_name: result[i].item_name, kind_name: result[i].kind_name, rank: result[i].rank, price: result[i].price, unit: result[i].unit, timestamp: String(diffDate[0]) +
                                                      "전"))
            }
            
            DispatchQueue.main.async {
                self?.tableViewSetting(width: (self?.view.frame.width)!, height: (self?.view.frame.height)! * 0.3)
                self?.FoodTableView.reloadData()
            }
        }
    }
}

struct FoodContentList : Codable{
    let contents : [FoodContent]
}

struct FoodContent : Codable{
    let item_name : String
    let kind_name : String
    let rank : String
    let price : Int
    let unit : String
    let timestamp : String
}
