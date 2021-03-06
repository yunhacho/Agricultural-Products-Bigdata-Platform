//
//  FoodCompare.swift
//  Jongp2
//
//  Created by junseok on 2021/05/30.
//

import Foundation
import UIKit
import SnapKit
import NVActivityIndicatorView

class DateSearchViewController : UIViewController{
    
    var SettingView : UIView!
    
    
    let ItemTitleLabel = UILabel()
    let ItemEditText = UITextField()
    let ItemPicker = UIPickerView()
    let ItemToolbar = UIToolbar()
    
    let DateTitleLabel = UILabel()
    
    let StartDateEditText = UITextField()
    let EndDateEditText = UITextField()
    
    let SlashUILabel = UILabel()
    
    let StartDatePicker = UIDatePicker()
    let StartDateToolbar = UIToolbar()
    
    let EndDatePicker = UIDatePicker()
    let EndDateToolbar = UIToolbar()
    
    let ItemNames = ["오이" , "양파", "파", "호박", "쌀"]
    let ItemDict : [String : Int] = ["오이" : 0, "양파" : 1, "파" : 2, "호박" : 3, "쌀" : 4]
    var Item = "오이"
    
    var selectItem = "오이"
    var selectStartDate = ""
    var selectEndDate = ""
    
    let SearchBtn = UIButton()
    
    let FoodTitleLabel = UIView()
    let FoodTableView = UITableView()
    var FoodContents : [FoodContent] = []

    let borderWidth : CGFloat = 0.2
    let borderColor : CGColor = UIColor.lightGray.cgColor
    
    let indicator = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 75, height: 75),
                                            type: .ballSpinFadeLoader,
                                            color: .black,
                                            padding: 0)
    let loadingView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLayoutSubviews()
        self.InitUI()
        self.addView()
        self.makeConstraints()
        
        self.InitItemPicker()
        
        self.InitDate()
        self.InitStartDatePicker()
        self.InitEndDatePicker()
        
        self.InitTitle()
        getFoodTable(item: ItemDict[selectItem]!, startDate: selectStartDate, endDate: selectEndDate)
    }
    
    func addView(){
        self.view.addSubview(SettingView)
    
        SettingView.addSubview(DateTitleLabel)
        SettingView.addSubview(StartDateEditText)
        SettingView.addSubview(SlashUILabel)
        SettingView.addSubview(EndDateEditText)
        
        SettingView.addSubview(ItemTitleLabel)
        SettingView.addSubview(ItemEditText)
        
        self.view.addSubview(SearchBtn)
        self.view.addSubview(FoodTitleLabel)
        self.view.addSubview(FoodTableView)
    }
     
    func InitUI(){
        SettingView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 200))
        SettingView.isUserInteractionEnabled = true
        SettingView.layer.borderWidth = 1
        SettingView.layer.borderColor = UIColor.lightGray.cgColor
        
        DateTitleLabel.text = "기간"
        DateTitleLabel.textAlignment = .center
        DateTitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        ItemTitleLabel.text = "품목"
        ItemTitleLabel.textAlignment = .center
        ItemTitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        SlashUILabel.text = "-"
        SlashUILabel.textAlignment = .center
        
        SearchBtn.setTitle("검색하기", for: .normal)
        SearchBtn.setTitleColor(ColorSetting.btnTextColor, for: .normal)
        SearchBtn.backgroundColor = UIColor(rgb: ColorSetting.backgroundColor).withAlphaComponent(1).withAlphaComponent(ColorSetting.btnAlpha)
        SearchBtn.isUserInteractionEnabled = true
        SearchBtn.addTarget(self, action: #selector(self.onPress), for: .touchUpInside)
    }

    @objc func onPress() {
        print("Search click")
        getFoodTable(item: ItemDict[selectItem]!, startDate: selectStartDate, endDate: selectEndDate)
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
            make.left.right.bottom.top.equalTo(0)
        }
        
        let Cellheight : Double = 1
        
        DateTitleLabel.layer.borderWidth = borderWidth * 2
        DateTitleLabel.layer.borderColor = borderColor
        DateTitleLabel.snp.makeConstraints{ make in
            make.width.equalToSuperview().multipliedBy(0.15)
            make.height.equalToSuperview().multipliedBy(Cellheight)
            make.leading.equalToSuperview()
            make.top.equalTo(self.view).offset(0)
        }
        
        StartDateEditText.snp.makeConstraints{ make in
            make.width.equalToSuperview().multipliedBy(0.25)
            make.height.equalToSuperview().multipliedBy(Cellheight)
            make.leading.equalTo(DateTitleLabel.snp.trailing)
            make.top.equalTo(DateTitleLabel.snp.top)
        }
        
        SlashUILabel.snp.makeConstraints{ make in
            make.width.equalToSuperview().multipliedBy(0.02)
            make.height.equalToSuperview().multipliedBy(Cellheight)
            make.leading.equalTo(StartDateEditText.snp.trailing)
            make.top.equalTo(DateTitleLabel.snp.top)
        }
        
        EndDateEditText.snp.makeConstraints{ make in
            make.width.equalToSuperview().multipliedBy(0.25)
            make.height.equalToSuperview().multipliedBy(Cellheight)
            make.leading.equalTo(SlashUILabel.snp.trailing)
            make.top.equalTo(DateTitleLabel.snp.top)
        }
        
        ItemTitleLabel.layer.borderWidth = borderWidth * 2
        ItemTitleLabel.layer.borderColor = borderColor
        ItemTitleLabel.snp.makeConstraints{ make in
            make.width.equalToSuperview().multipliedBy(0.15)
            make.height.equalToSuperview().multipliedBy(Cellheight)
            make.leading.equalTo(EndDateEditText.snp.trailing)
            make.top.equalTo(DateTitleLabel.snp.top)
        }
        
        ItemEditText.snp.makeConstraints{ make in
            make.width.equalToSuperview().multipliedBy(0.18)
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
            make.height.equalToSuperview().multipliedBy(0.73)
            make.top.equalTo(FoodTitleLabel.snp.bottom)
        }
    }
    
    func tableViewSetting(width : CGFloat, height : CGFloat){
        FoodTableView.translatesAutoresizingMaskIntoConstraints = false
        FoodTableView.register(FoodCell.self, forCellReuseIdentifier: FoodCell.identifier)
        FoodTableView.dataSource = self
        FoodTableView.rowHeight = height * 0.25
    }
    
    func initFoodContents(){
        for _ in 0..<10{
            FoodContents.append(FoodContent(item_name: "오이", kind_name: "다다기계통(100개)", rank: "상품", price: 123450, unit: "10Kg", timestamp: "2019-04-19"))
        }
    }
    
}

extension DateSearchViewController : UITableViewDataSource{
    
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
            
            if indexPath.row % 2 == 1 {
                cell.backgroundColor = UIColor(argb: ColorSetting.backgroundColor).withAlphaComponent(0.15)
            }else {
                cell.backgroundColor = .clear
            }
            
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

extension DateSearchViewController : UIPickerViewDelegate , UIPickerViewDataSource {
    
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
    
    func InitStartDatePicker(){

        let btnDone = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(self.onStartDatePickDone))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let btnCancel = UIBarButtonItem(title: "취소", style: .done, target: self, action: #selector(self.onStartDatePickCancel))
        btnDone.tintColor = UIColor(rgb: ColorSetting.backgroundColor)
        btnCancel.tintColor = UIColor(rgb: ColorSetting.backgroundColor)
        
        self.StartDateToolbar.barStyle = .default
        self.StartDateToolbar.isTranslucent = true  // 툴바가 반투명인지 여부 (true-반투명, false-투명)
        self.StartDateToolbar.backgroundColor = .lightGray
        self.StartDateToolbar.sizeToFit()   // 서브뷰만큼 툴바 크기를 맞춤
        self.StartDateToolbar.setItems([btnCancel , space , btnDone], animated: true)   // 버튼추가
        self.StartDateToolbar.isUserInteractionEnabled = true   // 사용자 클릭 이벤트 전달
        
        StartDatePicker.preferredDatePickerStyle = .wheels
        StartDatePicker.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 200)
        StartDatePicker.datePickerMode = .date
        StartDatePicker.timeZone = NSTimeZone.local
       
        StartDatePicker.minimumDate = Calendar.current.date(byAdding: .year, value: -10, to: Date())
        StartDatePicker.maximumDate = Calendar.current.date(byAdding: .day, value: -3, to: Date())
        StartDatePicker.setValue(UIColor.white, forKey: "backgroundColor")
        
        
        //TimeEditText.frame = CGRect(x: 0, y: 0, width:100, height: 30)
        StartDateEditText.inputView = StartDatePicker
        StartDateEditText.inputAccessoryView = StartDateToolbar
        StartDateEditText.textAlignment = .center
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy/MM/dd"
        let date = dateformatter.string(from: StartDatePicker.date)
        
        StartDateEditText.text = date
        StartDateEditText.textColor = UIColor(rgb: ColorSetting.textColor).withAlphaComponent(1)
        StartDateEditText.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    }
    
    func InitEndDatePicker(){

        let btnDone = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(self.onEndDatePickDone))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let btnCancel = UIBarButtonItem(title: "취소", style: .done, target: self, action: #selector(self.onEndDatePickCancel))
        btnDone.tintColor = UIColor(rgb: ColorSetting.backgroundColor)
        btnCancel.tintColor = UIColor(rgb: ColorSetting.backgroundColor)
        
        self.EndDateToolbar.barStyle = .default
        self.EndDateToolbar.isTranslucent = true  // 툴바가 반투명인지 여부 (true-반투명, false-투명)
        self.EndDateToolbar.backgroundColor = .lightGray
        self.EndDateToolbar.sizeToFit()   // 서브뷰만큼 툴바 크기를 맞춤
        self.EndDateToolbar.setItems([btnCancel , space , btnDone], animated: true)   // 버튼추가
        self.EndDateToolbar.isUserInteractionEnabled = true   // 사용자 클릭 이벤트 전달
        
        EndDatePicker.preferredDatePickerStyle = .wheels
        EndDatePicker.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 200)
        EndDatePicker.datePickerMode = .date
        EndDatePicker.timeZone = NSTimeZone.local
       
        EndDatePicker.minimumDate = Calendar.current.date(byAdding: .year, value: -10, to: Date())
        EndDatePicker.maximumDate = Calendar.current.date(byAdding: .day, value: -3, to: Date())
        EndDatePicker.setValue(UIColor.white, forKey: "backgroundColor")
        
        //TimeEditText.frame = CGRect(x: 0, y: 0, width:100, height: 30)
        EndDateEditText.inputView = EndDatePicker
        EndDateEditText.inputAccessoryView = EndDateToolbar
        EndDateEditText.textAlignment = .center
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy/MM/dd"
        let date = dateformatter.string(from: EndDatePicker.date)
        
        EndDateEditText.text = date
        EndDateEditText.textColor = UIColor(rgb: ColorSetting.textColor).withAlphaComponent(1)
        EndDateEditText.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    }
    
    @objc func changed(){
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .none
        dateformatter.timeStyle = .short
    }
    
    @objc func onStartDatePickDone() {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy/MM/dd"
        StartDateEditText.text = dateformatter.string(from: StartDatePicker.date)
        
        dateformatter.dateFormat = "yyyyMMdd"
        selectStartDate = dateformatter.string(from: StartDatePicker.date)
        
        StartDateEditText.resignFirstResponder()
    }

    @objc func onStartDatePickCancel() {
        StartDateEditText.resignFirstResponder() // 피커뷰를 내림 (텍스트필드가 responder 상태를 읽음)
    }
    
    @objc func onEndDatePickDone() {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy/MM/dd"
        EndDateEditText.text = dateformatter.string(from: EndDatePicker.date)
        
        dateformatter.dateFormat = "yyyyMMdd"
        selectEndDate = dateformatter.string(from: EndDatePicker.date)
        
        EndDateEditText.resignFirstResponder()
    }

    func InitDate(){
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyyMMdd"
        
        let date = dateformatter.string(from: Calendar.current.date(byAdding: .day, value: -3, to: Date())!)
        selectStartDate = date
        selectEndDate = date
    }
    
    @objc func onEndDatePickCancel() {
        StartDateEditText.resignFirstResponder() // 피커뷰를 내림 (텍스트필드가 responder 상태를 읽음)
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

extension DateSearchViewController{
    func getFoodTable(item : Int, startDate : String, endDate : String){
        var url : String!
        
        self.makeIndicatorView()
        
        
        if selectStartDate == selectEndDate{
            url = "\(WasURL.getURL(url:requestURL.this_day))?item=\(item)&date=\(selectStartDate)"
        } else{
            url = "\(WasURL.getURL(url:requestURL.period))?item=\(item)&date1=\(selectStartDate)&date2=\(selectEndDate)"
        }
        
        
        getBeforeFood(url : url ){ [weak self] result in
            self?.FoodContents.removeAll()
            for i in 0..<result.count{
                self?.FoodContents.append(FoodContent(item_name: result[i].item_name, kind_name: result[i].kind_name, rank: result[i].rank, price: result[i].price, unit: result[i].unit, timestamp: result[i].timestamp))
            }
            
            DispatchQueue.main.async {
                self?.tableViewSetting(width: (self?.view.frame.width)!, height: (self?.view.frame.height)! * 0.3)
                self?.FoodTableView.reloadData()
                if((self?.indicator.isAnimating) != nil){
                    self?.indicator.stopAnimating()
                    self?.loadingView.removeFromSuperview()
                    self?.indicator.removeFromSuperview()
                }
            }
        }
    }
    
    func makeIndicatorView(){
        self.view.addSubview(loadingView)
        self.view.addSubview(indicator)
        loadingView.backgroundColor = UIColor.init(cgColor: CGColor(red: 220, green: 220, blue: 220, alpha: 0.9))
        loadingView.snp.makeConstraints{ make in
            make.top.left.right.bottom.equalTo(self.view).offset(0)
        }
        indicator.snp.makeConstraints{ make in
            make.width.equalToSuperview().multipliedBy(0.15)
            make.height.equalToSuperview().multipliedBy(0.15)
            make.centerX.equalTo(self.view)
            make.centerY.equalTo(300)
        }
        indicator.startAnimating()
    }
    
}
