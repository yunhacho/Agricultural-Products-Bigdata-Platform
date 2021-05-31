//
//  FoodCompare.swift
//  Jongp2
//
//  Created by junseok on 2021/05/30.
//

import Foundation
import UIKit
import SnapKit
import DropDown

class GraphViewController : UIViewController{
    
    var SettingView : UIView!
    
    
    let ItemTitleLabel = UILabel()
    let ItemEditText = UITextField()
    let ItemPicker = UIPickerView()
    let ItemToolbar = UIToolbar()
    
    let FoodTitleLabel = UILabel()
    let FoodEditText = UITextField()
    let FoodPicker = UIPickerView()
    let FoodToolbar = UIToolbar()
    
    let KindTitleLabel = UILabel()
    let KindEditText = UITextField()
    let KindPicker = UIPickerView()
    let KindToolbar = UIToolbar()
    
    let RankTitleLabel = UILabel()
    let RankEditText = UITextField()
    let RankPicker = UIPickerView()
    let RankToolbar = UIToolbar()
    
    let ElementTitleLabel = UILabel()
    let ElementEditText = UITextField()
    let ElementPicker = UIPickerView()
    let ElementToolbar = UIToolbar()
    
    let SearchBtn = UIButton()
    
    let ItemNames = ["유가별 채소 가격 변동" , "연도별 채소 생산량", "기온 및 습도에 따른 채소 가격 변동", "곡물 및 식량물가에 따른 채소 가격 변동"]
    var Item = "유가별 채소 가격 변동"
    
    var selectItem = "유가별 채소 가격 변동"
    var selectFood = "오이"
    var selectKind = "가시계통(1kg)"
    var selectRank = "중품"
    var selectElement = "평균 기온"
    
    var FoodList : [String] = ["오이" , "양파", "파", "쌀", "호박"]
    var KindList : [String] = ["취청50개", "가시계통(1kg)", "다다기계통(100개"]
    var RankList : [String] = ["중품", "상품"]
    var ElementList : [String] = ["평균 기온", "평균 습도", "강수량", "평균 풍량", "일조량"]
    
    var type : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLayoutSubviews()
        InitUI()
        addView()
        addPickerViewType(type: 0)
        makeConstraintsType(type : 0)
        InitItemPicker()
        InitFoodPicker()
        InitKindPicker()
        InitRankPicker()
        InitElementPicker()
    }
    
    func addView(){
        
        self.view.isUserInteractionEnabled = true
        
        self.view.addSubview(SearchBtn)
    }
    
    func addPickerViewType(type : Int){
        
        self.view.addSubview(SettingView)
        
        SettingView.addSubview(ItemTitleLabel)
        SettingView.addSubview(ItemEditText)
        
        SettingView.addSubview(FoodTitleLabel)
        SettingView.addSubview(FoodEditText)
        
        SettingView.addSubview(KindTitleLabel)
        SettingView.addSubview(KindEditText)
        
        SettingView.addSubview(RankTitleLabel)
        SettingView.addSubview(RankEditText)
        
        if type == 1 {
            SettingView.addSubview(ElementTitleLabel)
            SettingView.addSubview(ElementEditText)
        }
    }
    
    func InitUI(){
        SettingView = UIView()
        SettingView.isUserInteractionEnabled = true
        SettingView.layer.borderWidth = 1
        SettingView.layer.borderColor = UIColor.lightGray.cgColor
        
        ItemTitleLabel.text = "그래프"
        ItemTitleLabel.textAlignment = .center
        ItemTitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        FoodTitleLabel.text = "품목"
        FoodTitleLabel.textAlignment = .center
        FoodTitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        KindTitleLabel.text = "종류"
        KindTitleLabel.textAlignment = .center
        KindTitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        RankTitleLabel.text = "등급"
        RankTitleLabel.textAlignment = .center
        RankTitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        ElementTitleLabel.text = "날씨 요소"
        ElementTitleLabel.textAlignment = .center
        ElementTitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        SearchBtn.setTitle("확인", for: .normal)
        SearchBtn.setTitleColor(UIColor.white, for: .normal)
        SearchBtn.backgroundColor = .systemBlue
        SearchBtn.isUserInteractionEnabled = true
        SearchBtn.addTarget(self, action: #selector(self.onPress), for: .touchUpInside)
    }
    
    @objc func onPress() {
        print("Search click")
    }
    
    func makeConstraintsType(type : Int){
        var settingViewHeight = 0.06
        
        if type == 0 {
            settingViewHeight = 0.12
        } else if type == 1 {
            settingViewHeight = 0.18
        }
        
        SettingView.snp.makeConstraints{ make in
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(settingViewHeight)
            make.left.right.equalTo(0)
            make.top.equalToSuperview()
        }
        
        var Cellheight : Double = 1
        if type == 0 {
            Cellheight = 0.5
        } else if type == 1 {
            Cellheight = 1 / 3
        }
        
        ItemTitleLabel.snp.makeConstraints{ make in
            make.width.equalToSuperview().multipliedBy(0.25)
            make.height.equalToSuperview().multipliedBy(Cellheight)
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        ItemEditText.snp.makeConstraints{ make in
            make.width.equalToSuperview().multipliedBy(0.7)
            make.height.equalToSuperview().multipliedBy(Cellheight)
            make.leading.equalTo(ItemTitleLabel.snp.trailing)
            make.top.equalTo(ItemTitleLabel.snp.top)
        }
        
        FoodTitleLabel.snp.makeConstraints{ make in
            make.width.equalToSuperview().multipliedBy(0.15)
            make.height.equalToSuperview().multipliedBy(Cellheight)
            make.leading.equalToSuperview()
            make.top.equalTo(ItemEditText.snp.bottom)
        }
        
        FoodEditText.snp.makeConstraints{ make in
            make.width.equalToSuperview().multipliedBy(0.10)
            make.height.equalToSuperview().multipliedBy(Cellheight)
            make.leading.equalTo(FoodTitleLabel.snp.trailing)
            make.top.equalTo(ItemEditText.snp.bottom)
        }
        
        KindTitleLabel.snp.makeConstraints{ make in
            make.width.equalToSuperview().multipliedBy(0.15)
            make.height.equalToSuperview().multipliedBy(Cellheight)
            make.leading.equalTo(FoodEditText.snp.trailing)
            make.top.equalTo(ItemEditText.snp.bottom)
        }
        
        KindEditText.snp.makeConstraints{ make in
            make.width.equalToSuperview().multipliedBy(0.30)
            make.height.equalToSuperview().multipliedBy(Cellheight)
            make.leading.equalTo(KindTitleLabel.snp.trailing)
            make.top.equalTo(ItemEditText.snp.bottom)
        }
        
        RankTitleLabel.snp.makeConstraints{ make in
            make.width.equalToSuperview().multipliedBy(0.15)
            make.height.equalToSuperview().multipliedBy(Cellheight)
            make.leading.equalTo(KindEditText.snp.trailing)
            make.top.equalTo(ItemEditText.snp.bottom)
        }
        
        RankEditText.snp.makeConstraints{ make in
            make.width.equalToSuperview().multipliedBy(0.15)
            make.height.equalToSuperview().multipliedBy(Cellheight)
            make.leading.equalTo(RankTitleLabel.snp.trailing)
            make.top.equalTo(ItemEditText.snp.bottom)
        }
        
        if type == 1{
            ElementTitleLabel.snp.makeConstraints{ make in
                make.width.equalToSuperview().multipliedBy(0.5)
                make.height.equalToSuperview().multipliedBy(Cellheight)
                make.leading.equalToSuperview()
                make.top.equalTo(RankEditText.snp.bottom)
            }
            
            ElementEditText.snp.makeConstraints{ make in
                make.width.equalToSuperview().multipliedBy(0.4)
                make.height.equalToSuperview().multipliedBy(Cellheight)
                make.leading.equalTo(ElementTitleLabel.snp.trailing)
                make.top.equalTo(RankEditText.snp.bottom)
            }
        }
        
        SearchBtn.snp.makeConstraints{ make in
            make.width.equalToSuperview().multipliedBy(1)
            make.height.equalTo(ItemEditText.snp.height).multipliedBy(0.7)
            make.leading.equalToSuperview()
            make.top.equalTo(SettingView.snp.bottom)
        }
    }
    
}


extension GraphViewController : UIPickerViewDelegate , UIPickerViewDataSource {
    
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
        
        SettingView.removeFromSuperview()
        
        if selectItem == "유가별 채소 가격 변동" || selectItem == "연도별 채소 생산량" || selectItem == "기온 및 습도에 따른 채소 가격 변동"{
            InitUI()
            addPickerViewType(type: 0)
            makeConstraintsType(type : 0)
        }
        else if selectItem == "곡물 및 식량물가에 따른 채소 가격 변동"{
            InitUI()
            addPickerViewType(type: 1)
            makeConstraintsType(type : 1)
        }
        
        ItemEditText.resignFirstResponder()
    }

    // 피커뷰 > 취소 클릭
    @objc func onItemPickCancel() {
        ItemEditText.resignFirstResponder() // 피커뷰를 내림 (텍스트필드가 responder 상태를 읽음)
    }
    
    @objc func changed(){
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .none
        dateformatter.timeStyle = .short
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
   
    // 구성요소(컬럼)의 행수
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView == ItemPicker){
            return ItemNames.count
        } else if (pickerView == FoodPicker){
            return FoodList.count
        } else if (pickerView == KindPicker){
            return KindList.count
        } else if (pickerView == RankPicker){
            return RankList.count
        } else if (pickerView == ElementPicker){
            return ElementList.count
        }
        return 0
    }

    // 피커뷰에 보여줄 값 전달
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView == ItemPicker){
            selectItem = ItemNames[row]
            return ItemNames[row]
        } else if (pickerView == FoodPicker){
            selectFood = FoodList[row]
            return FoodList[row]
        } else if (pickerView == KindPicker){
            selectKind = KindList[row]
            return KindList[row]
        } else if (pickerView == RankPicker){
            selectRank = RankList[row]
            return RankList[row]
        } else if (pickerView == ElementPicker){
            selectElement = ElementList[row]
            return ElementList[row]
        }
        return ""
    }

    // 피커뷰에서 선택시 호출
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (pickerView == ItemPicker){
            selectItem = ItemNames[row]
        } else if (pickerView == FoodPicker){
            selectFood = FoodList[row]
        } else if (pickerView == KindPicker){
            selectKind = KindList[row]
        } else if (pickerView == RankPicker){
            selectRank = RankList[row]
        } else if (pickerView == ElementPicker){
            selectElement = ElementList[row]
        }
    }
    
    func InitFoodPicker(){
        let btnDone = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(self.onFoodPickDone))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let btnCancel = UIBarButtonItem(title: "취소", style: .done, target: self, action: #selector(self.onFoodPickCancel))
        
        self.FoodPicker.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 220)
        self.FoodPicker.delegate = self
        self.FoodPicker.dataSource = self
        self.FoodPicker.backgroundColor = .white
        
        self.FoodToolbar.barStyle = .default
        self.FoodToolbar.isTranslucent = true  // 툴바가 반투명인지 여부 (true-반투명, false-투명)
        self.FoodToolbar.backgroundColor = .lightGray
        self.FoodToolbar.sizeToFit()   // 서브뷰만큼 툴바 크기를 맞춤
        self.FoodToolbar.setItems([btnCancel , space , btnDone], animated: true)   // 버튼추가
        self.FoodToolbar.isUserInteractionEnabled = true   // 사용자 클릭 이벤트 전달
        
        //RaceEditText.frame = CGRect(x: 0, y: 0, width:100, height: 30)
        FoodEditText.inputView = FoodPicker
        FoodEditText.inputAccessoryView = FoodToolbar
        FoodEditText.borderRect(forBounds: CGRect(x: 0, y: 0, width: 100, height: 30))
        FoodEditText.textAlignment = .center
        FoodEditText.text = FoodList[0]
        FoodEditText.textColor = .systemBlue
    }
    
    @objc func onFoodPickDone() {
        FoodEditText.text = selectFood
        
        if selectFood == "오이"{
            KindList = ["취청50개", "가시계통(1kg)", "다다기계통(100개)"]
            selectKind = KindList[0]
            KindEditText.text = KindList[0]
        } else if selectFood == "양파"{
            KindList = ["햇양파(1kg)", "양파(1kg)", "수입(1kg)"]
            selectKind = KindList[0]
            KindEditText.text = KindList[0]
        } else if selectFood == "파"{
            KindList = ["대파(1kg)", "쪽파(1kg)"]
            selectKind = KindList[0]
            KindEditText.text = KindList[0]
        } else if selectFood == "호박"{
            KindList = ["애호박(20개)", "쥬키니(1kg)"]
            selectKind = KindList[0]
            KindEditText.text = KindList[0]
        } else if selectFood == "쌀"{
            KindList = ["일반계(1kg)", "햇일반계(1kg)"]
            selectKind = KindList[0]
            KindEditText.text = KindList[0]
        }
        
        FoodEditText.resignFirstResponder()
    }

    // 피커뷰 > 취소 클릭
    @objc func onFoodPickCancel() {
        FoodEditText.resignFirstResponder() // 피커뷰를 내림 (텍스트필드가 responder 상태를 읽음)
    }
    
    func InitKindPicker(){
        let btnDone = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(self.onKindPickDone))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let btnCancel = UIBarButtonItem(title: "취소", style: .done, target: self, action: #selector(self.onKindPickCancel))
        
        self.KindPicker.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 220)
        self.KindPicker.delegate = self
        self.KindPicker.dataSource = self
        self.KindPicker.backgroundColor = .white
        
        self.KindToolbar.barStyle = .default
        self.KindToolbar.isTranslucent = true  // 툴바가 반투명인지 여부 (true-반투명, false-투명)
        self.KindToolbar.backgroundColor = .lightGray
        self.KindToolbar.sizeToFit()   // 서브뷰만큼 툴바 크기를 맞춤
        self.KindToolbar.setItems([btnCancel , space , btnDone], animated: true)   // 버튼추가
        self.KindToolbar.isUserInteractionEnabled = true   // 사용자 클릭 이벤트 전달
        
        //RaceEditText.frame = CGRect(x: 0, y: 0, width:100, height: 30)
        KindEditText.inputView = KindPicker
        KindEditText.inputAccessoryView = KindToolbar
        KindEditText.borderRect(forBounds: CGRect(x: 0, y: 0, width: 100, height: 30))
        KindEditText.textAlignment = .center
        KindEditText.text = KindList[0]
        KindEditText.textColor = .systemBlue
    }
    
    @objc func onKindPickDone() {
        KindEditText.text = selectKind
        KindEditText.resignFirstResponder()
    }

    // 피커뷰 > 취소 클릭
    @objc func onKindPickCancel() {
        KindEditText.resignFirstResponder() // 피커뷰를 내림 (텍스트필드가 responder 상태를 읽음)
    }
    
    func InitRankPicker(){
        let btnDone = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(self.onRankPickDone))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let btnCancel = UIBarButtonItem(title: "취소", style: .done, target: self, action: #selector(self.onRankPickCancel))
        
        self.RankPicker.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 220)
        self.RankPicker.delegate = self
        self.RankPicker.dataSource = self
        self.RankPicker.backgroundColor = .white
        
        self.RankToolbar.barStyle = .default
        self.RankToolbar.isTranslucent = true  // 툴바가 반투명인지 여부 (true-반투명, false-투명)
        self.RankToolbar.backgroundColor = .lightGray
        self.RankToolbar.sizeToFit()   // 서브뷰만큼 툴바 크기를 맞춤
        self.RankToolbar.setItems([btnCancel , space , btnDone], animated: true)   // 버튼추가
        self.RankToolbar.isUserInteractionEnabled = true   // 사용자 클릭 이벤트 전달
        
        //RaceEditText.frame = CGRect(x: 0, y: 0, width:100, height: 30)
        RankEditText.inputView = RankPicker
        RankEditText.inputAccessoryView = RankToolbar
        RankEditText.borderRect(forBounds: CGRect(x: 0, y: 0, width: 100, height: 30))
        RankEditText.textAlignment = .center
        RankEditText.text = RankList[0]
        RankEditText.textColor = .systemBlue
    }
    
    @objc func onRankPickDone() {
        RankEditText.text = selectRank
        RankEditText.resignFirstResponder()
    }

    // 피커뷰 > 취소 클릭
    @objc func onRankPickCancel() {
        RankEditText.resignFirstResponder() // 피커뷰를 내림 (텍스트필드가 responder 상태를 읽음)
    }
    
    func InitElementPicker(){
        let btnDone = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(self.onElementPickDone))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let btnCancel = UIBarButtonItem(title: "취소", style: .done, target: self, action: #selector(self.onElementPickCancel))
        
        self.ElementPicker.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 220)
        self.ElementPicker.delegate = self
        self.ElementPicker.dataSource = self
        self.RankPicker.backgroundColor = .white
        
        self.ElementToolbar.barStyle = .default
        self.ElementToolbar.isTranslucent = true  // 툴바가 반투명인지 여부 (true-반투명, false-투명)
        self.ElementToolbar.backgroundColor = .lightGray
        self.ElementToolbar.sizeToFit()   // 서브뷰만큼 툴바 크기를 맞춤
        self.ElementToolbar.setItems([btnCancel , space , btnDone], animated: true)   // 버튼추가
        self.ElementToolbar.isUserInteractionEnabled = true   // 사용자 클릭 이벤트 전달
        
        //RaceEditText.frame = CGRect(x: 0, y: 0, width:100, height: 30)
        ElementEditText.inputView = ElementPicker
        ElementEditText.inputAccessoryView = ElementToolbar
        ElementEditText.borderRect(forBounds: CGRect(x: 0, y: 0, width: 100, height: 30))
        ElementEditText.textAlignment = .center
        ElementEditText.text = ElementList[0]
        ElementEditText.textColor = .systemBlue
    }
    
    @objc func onElementPickDone() {
        ElementEditText.text = selectElement
        ElementEditText.resignFirstResponder()
    }

    // 피커뷰 > 취소 클릭
    @objc func onElementPickCancel() {
        ElementEditText.resignFirstResponder() // 피커뷰를 내림 (텍스트필드가 responder 상태를 읽음)
    }
}
