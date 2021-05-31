//
//  FoodCompare.swift
//  Jongp2
//
//  Created by junseok on 2021/05/30.
//

import Foundation
import UIKit
import SnapKit

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
    
    let ItemNames = ["양파" , "오이", "파", "쌀", "호박"]
    var Item = "양파"
    
    var selectItem = ""
    var selectDate = ""
    
    override func viewDidLoad() {
        super.viewDidLayoutSubviews()
        InitUI()
        addView()
        makeConstraints()
        InitItemPicker()
        InitDatePicker()
    }
    
    func addView(){
        self.view.addSubview(SettingView)
        self.view.isUserInteractionEnabled = true
        
        SettingView.addSubview(DateTitleLabel)
        SettingView.addSubview(DateEditText)
        
        SettingView.addSubview(ItemTitleLabel)
        SettingView.addSubview(ItemEditText)
        
        self.view.addSubview(SearchBtn)
    }
    
    func InitUI(){
        SettingView = UIView()
        SettingView.isUserInteractionEnabled = true
        SettingView.layer.borderWidth = 1
        SettingView.layer.borderColor = UIColor.lightGray.cgColor
        
        DateTitleLabel.text = "날짜"
        DateTitleLabel.textAlignment = .center
        
        ItemTitleLabel.text = "품목"
        ItemTitleLabel.textAlignment = .center
        
//        let config = UIImage.SymbolConfiguration(pointSize: 28, weight: .medium, scale: .default)
//        let systemImage = UIImage(systemName: "magnifyingglass", withConfiguration: config )
//
        SearchBtn.setTitle("검색하기", for: .normal)
        SearchBtn.setTitleColor(UIColor.white, for: .normal)
        SearchBtn.backgroundColor = .systemBlue
        SearchBtn.isUserInteractionEnabled = true
        SearchBtn.addTarget(self, action: #selector(self.onPress), for: .touchUpInside)
    }
    
    @objc func onPress() {
        print("Search click")
    }

    func makeConstraints(){

        SettingView.snp.makeConstraints{ make in
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.075)
            make.left.right.top.equalTo(0)
        }
        
        let Cellheight : Double = 1
        
        DateTitleLabel.snp.makeConstraints{ make in
            make.width.equalToSuperview().multipliedBy(0.2)
            make.height.equalToSuperview().multipliedBy(Cellheight)
            make.leading.equalToSuperview()
            make.top.equalTo(self.view).offset(0)
        }
        
        DateEditText.snp.makeConstraints{ make in
            make.width.equalToSuperview().multipliedBy(0.25)
            make.height.equalToSuperview().multipliedBy(Cellheight)
            make.leading.equalTo(DateTitleLabel.snp.trailing)
            make.top.equalTo(DateTitleLabel.snp.top)
        }
        
        ItemTitleLabel.snp.makeConstraints{ make in
            make.width.equalToSuperview().multipliedBy(0.3)
            make.height.equalToSuperview().multipliedBy(Cellheight)
            make.leading.equalTo(DateEditText.snp.trailing)
            make.top.equalTo(DateTitleLabel.snp.top)
        }
        
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
    }
    

    
}

extension FoodCompareViewController : UIPickerViewDelegate , UIPickerViewDataSource {
    
    func InitItemPicker(){
        let btnDone = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(self.onItemPickDone))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let btnCancel = UIBarButtonItem(title: "취소", style: .done, target: self, action: #selector(self.onItemPickCancel))
        
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
        ItemEditText.textColor = .systemBlue
    }
    
    @objc func onItemPickDone() {
        ItemEditText.text = selectItem
        ItemEditText.resignFirstResponder()
    }

    // 피커뷰 > 취소 클릭
    @objc func onItemPickCancel() {
        ItemEditText.resignFirstResponder() // 피커뷰를 내림 (텍스트필드가 responder 상태를 읽음)
    }
    
    func InitDatePicker(){

        let btnDone = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(self.onDatePickDone))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let btnCancel = UIBarButtonItem(title: "취소", style: .done, target: self, action: #selector(self.onDatePickCancel))
        
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
        DatePicker.maximumDate = Date()
        
        
        //TimeEditText.frame = CGRect(x: 0, y: 0, width:100, height: 30)
        DateEditText.inputView = DatePicker
        DateEditText.inputAccessoryView = DateToolbar
        DateEditText.textAlignment = .center
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy/MM/dd"
        let date = dateformatter.string(from: DatePicker.date)
        
        DateEditText.text = date
        DateEditText.textColor = .systemBlue
        
    }
    
    @objc func changed(){
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .none
        dateformatter.timeStyle = .short
    }
    
    @objc func onDatePickDone() {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy/MM/dd"
        selectDate = dateformatter.string(from: DatePicker.date)
        DateEditText.text = selectDate
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

