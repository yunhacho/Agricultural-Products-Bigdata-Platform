//
//  FoodCompare.swift
//  Jongp2
//
//  Created by junseok on 2021/05/30.
//

import Foundation
import UIKit
import SnapKit

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
    
    let ItemNames = ["양파" , "오이", "파", "쌀", "호박"]
    var Item = "양파"
    
    var selectItem = ""
    var selectStartDate = ""
    var selectEndDate = ""
    
    let SearchBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLayoutSubviews()
        InitUI()
        addView()
        makeConstraints()
        InitItemPicker()
        InitStartDatePicker()
        InitEndDatePicker()
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
    }
    
    func InitUI(){
        SettingView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 200))
        SettingView.isUserInteractionEnabled = true
        SettingView.layer.borderWidth = 1
        SettingView.layer.borderColor = UIColor.lightGray.cgColor
        
        DateTitleLabel.text = "기간"
        DateTitleLabel.textAlignment = .center
        
        ItemTitleLabel.text = "품목"
        ItemTitleLabel.textAlignment = .center
        
        SlashUILabel.text = "-"
        SlashUILabel.textAlignment = .center
        
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
            make.left.right.bottom.top.equalTo(0)
        }
        
        let Cellheight : Double = 1
        
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
        
        ItemTitleLabel.snp.makeConstraints{ make in
            make.width.equalToSuperview().multipliedBy(0.15)
            make.height.equalToSuperview().multipliedBy(Cellheight)
            make.leading.equalTo(EndDateEditText.snp.trailing)
            make.top.equalTo(DateTitleLabel.snp.top)
        }
        
        ItemEditText.snp.makeConstraints{ make in
            make.width.equalToSuperview().multipliedBy(0.15)
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

extension DateSearchViewController : UIPickerViewDelegate , UIPickerViewDataSource {
    
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
    
    func InitStartDatePicker(){

        let btnDone = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(self.onStartDatePickDone))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let btnCancel = UIBarButtonItem(title: "취소", style: .done, target: self, action: #selector(self.onStartDatePickCancel))
        
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
        StartDatePicker.maximumDate = Date()
        
        
        //TimeEditText.frame = CGRect(x: 0, y: 0, width:100, height: 30)
        StartDateEditText.inputView = StartDatePicker
        StartDateEditText.inputAccessoryView = StartDateToolbar
        StartDateEditText.textAlignment = .center
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy/MM/dd"
        let date = dateformatter.string(from: StartDatePicker.date)
        
        StartDateEditText.text = date
        StartDateEditText.textColor = .systemBlue
        
    }
    
    func InitEndDatePicker(){

        let btnDone = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(self.onEndDatePickDone))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let btnCancel = UIBarButtonItem(title: "취소", style: .done, target: self, action: #selector(self.onEndDatePickCancel))
        
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
        EndDatePicker.maximumDate = Date()
        
        
        //TimeEditText.frame = CGRect(x: 0, y: 0, width:100, height: 30)
        EndDateEditText.inputView = EndDatePicker
        EndDateEditText.inputAccessoryView = EndDateToolbar
        EndDateEditText.textAlignment = .center
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy/MM/dd"
        let date = dateformatter.string(from: EndDatePicker.date)
        
        EndDateEditText.text = date
        EndDateEditText.textColor = .systemBlue
        
    }
    
    @objc func changed(){
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .none
        dateformatter.timeStyle = .short
    }
    
    @objc func onStartDatePickDone() {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy/MM/dd"
        selectStartDate = dateformatter.string(from: StartDatePicker.date)
        StartDateEditText.text = selectStartDate
        StartDateEditText.resignFirstResponder()
    }

    @objc func onStartDatePickCancel() {
        StartDateEditText.resignFirstResponder() // 피커뷰를 내림 (텍스트필드가 responder 상태를 읽음)
    }
    
    @objc func onEndDatePickDone() {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy/MM/dd"
        selectEndDate = dateformatter.string(from: EndDatePicker.date)
        EndDateEditText.text = selectEndDate
        EndDateEditText.resignFirstResponder()
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

