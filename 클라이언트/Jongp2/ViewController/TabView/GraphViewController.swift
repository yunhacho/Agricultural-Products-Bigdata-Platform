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
import Charts

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
    
    let ItemNames = ["유가별 채소 가격 변동" , "연도별 채소 생산량 및 평균가", "날씨 요인에 따른 채소 가격 변동", "기타 요인에 따른 채소 가격 변동"]
    var Item = "유가별 채소 가격 변동"
    
    var selectItem = "유가별 채소 가격 변동"
    var selectFood = "오이"
    var selectKind = "취청50개"
    var selectRank = "중품"
    var selectElement = "평균 기온"
    
    var FoodList : [String] = ["오이" , "양파", "파", "쌀", "호박"]
    var KindList : [String] = ["취청50개", "가시계통(1kg)", "다다기계통(100개)"]
    var RankList : [String] = ["중품", "상품"]
    
    let Item_dict : [String:Int] = ["유가별 채소 가격 변동" : 0, "연도별 채소 생산량 및 평균가" : 1, "날씨 요인에 따른 채소 가격 변동" : 2, "기타 요인에 따른 채소 가격 변동" : 3]
    let food_dict : [String:Int] = ["오이":0, "양파": 1, "파":2, "호박":3, "쌀":4]
    let kind_dict : [String:Int] = ["취청50개":0, "가시계통(1kg)":1, "다다기계통(100개)":2, "햇양파(1kg)":3, "양파(1kg)":4, "수입(1kg)":5, "대파(1kg)":6, "쪽파(1kg)":7, "애호박(20개)":8, "쥬키니(1kg)":9, "일반계(1kg)":10, "햇일반계(1kg)":11]
    let rank_dict: [String:Int] = ["중품":0, "상품":1]
    
    var element_dict : [String : Int] = ["평균 기온" : 0, "평균 습도" : 1, "강수량" : 2, "평균 풍량" : 3]
    
    var ElementList : [String]!
    
    var type : Int = 0
    
    var xData : [Double] = [1,2,3,4,5,6,7,8,9,10]
    var xData2 : [Int] = [1,2,3,4,5,6,7,8,9,10]
    
    var yData : [Double] = [12,43,21,24,53,63,14,23,45,36]
    var yData2 : [Double] = [7250, 6939,6886,3424,6053,7424,7245,2327,1346,4424]//면적
    var yData3 : [Double] = [1132,1235.8,1126, 1186, 1267, 1797, 1978, 2012, 2345]//평균가
    
    var xLabel : String = "평균 유가"
    var yLabel : String = "채소 평균가"
    
    var yLabel2 : String = "면적"
    var yLabel3 : String = "평균가"
    
    var LineGraph : LineChartView!
    var BarGraph : BarChartView!
    
    let borderWidth : CGFloat = 0.2
    let borderColor : CGColor = UIColor.lightGray.cgColor
    
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
        
        GraphDataRequest(selectItem : selectItem)
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
        ItemTitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        FoodTitleLabel.text = "품목"
        FoodTitleLabel.textAlignment = .center
        FoodTitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        KindTitleLabel.text = "종류"
        KindTitleLabel.textAlignment = .center
        KindTitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        RankTitleLabel.text = "등급"
        RankTitleLabel.textAlignment = .center
        RankTitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        if selectItem == "날씨 요인에 따른 채소 가격 변동"{
            ElementTitleLabel.text = "날씨 요소"
        } else if selectItem == "기타 요인에 따른 채소 가격 변동"{
            ElementTitleLabel.text = "기타 요인"
        }
        
        ElementTitleLabel.textAlignment = .center
        ElementTitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        SearchBtn.setTitle("확인", for: .normal)
        SearchBtn.setTitleColor(ColorSetting.btnTextColor, for: .normal)
        SearchBtn.backgroundColor = UIColor(rgb: ColorSetting.backgroundColor).withAlphaComponent(1).withAlphaComponent(ColorSetting.btnAlpha)
        SearchBtn.isUserInteractionEnabled = true
        SearchBtn.addTarget(self, action: #selector(self.onPress), for: .touchUpInside)
    }
    
    @objc func onPress() {
        print("Search click")
        if LineGraph != nil{
            LineGraph.removeFromSuperview()
        }
        
        GraphDataRequest(selectItem : selectItem)
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
        
        ItemTitleLabel.layer.borderWidth = borderWidth
        ItemTitleLabel.layer.borderColor = borderColor
        ItemTitleLabel.snp.makeConstraints{ make in
            make.width.equalToSuperview().multipliedBy(0.25)
            make.height.equalToSuperview().multipliedBy(Cellheight)
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        ItemEditText.layer.borderWidth = borderWidth
        ItemEditText.layer.borderColor = borderColor
        ItemEditText.snp.makeConstraints{ make in
            make.width.equalToSuperview().multipliedBy(0.75)
            make.height.equalToSuperview().multipliedBy(Cellheight)
            make.leading.equalTo(ItemTitleLabel.snp.trailing)
            make.top.equalTo(ItemTitleLabel.snp.top)
        }
        
        FoodTitleLabel.layer.borderWidth = borderWidth
        FoodTitleLabel.layer.borderColor = borderColor
        FoodTitleLabel.snp.makeConstraints{ make in
            make.width.equalToSuperview().multipliedBy(0.15)
            make.height.equalToSuperview().multipliedBy(Cellheight)
            make.leading.equalToSuperview()
            make.top.equalTo(ItemEditText.snp.bottom)
        }
        
        FoodEditText.layer.borderWidth = borderWidth
        FoodEditText.layer.borderColor = borderColor
        FoodEditText.snp.makeConstraints{ make in
            make.width.equalToSuperview().multipliedBy(0.10)
            make.height.equalToSuperview().multipliedBy(Cellheight)
            make.leading.equalTo(FoodTitleLabel.snp.trailing)
            make.top.equalTo(ItemEditText.snp.bottom)
        }
        
        KindTitleLabel.layer.borderWidth = borderWidth
        KindTitleLabel.layer.borderColor = borderColor
        KindTitleLabel.snp.makeConstraints{ make in
            make.width.equalToSuperview().multipliedBy(0.15)
            make.height.equalToSuperview().multipliedBy(Cellheight)
            make.leading.equalTo(FoodEditText.snp.trailing)
            make.top.equalTo(ItemEditText.snp.bottom)
        }
        
        KindEditText.layer.borderWidth = borderWidth
        KindEditText.layer.borderColor = borderColor
        KindEditText.snp.makeConstraints{ make in
            make.width.equalToSuperview().multipliedBy(0.30)
            make.height.equalToSuperview().multipliedBy(Cellheight)
            make.leading.equalTo(KindTitleLabel.snp.trailing)
            make.top.equalTo(ItemEditText.snp.bottom)
        }
        
        RankTitleLabel.layer.borderWidth = borderWidth
        RankTitleLabel.layer.borderColor = borderColor
        RankTitleLabel.snp.makeConstraints{ make in
            make.width.equalToSuperview().multipliedBy(0.15)
            make.height.equalToSuperview().multipliedBy(Cellheight)
            make.leading.equalTo(KindEditText.snp.trailing)
            make.top.equalTo(ItemEditText.snp.bottom)
        }
        
        RankEditText.layer.borderWidth = borderWidth
        RankEditText.layer.borderColor = borderColor
        RankEditText.snp.makeConstraints{ make in
            make.width.equalToSuperview().multipliedBy(0.15)
            make.height.equalToSuperview().multipliedBy(Cellheight)
            make.leading.equalTo(RankTitleLabel.snp.trailing)
            make.top.equalTo(ItemEditText.snp.bottom)
        }
        
        if type == 1{
            ElementTitleLabel.layer.borderWidth = borderWidth
            ElementTitleLabel.layer.borderColor = borderColor
            ElementTitleLabel.snp.makeConstraints{ make in
                make.width.equalToSuperview().multipliedBy(0.4)
                make.height.equalToSuperview().multipliedBy(Cellheight)
                make.leading.equalToSuperview()
                make.top.equalTo(RankEditText.snp.bottom)
            }
            
            ElementEditText.layer.borderWidth = borderWidth
            ElementEditText.layer.borderColor = borderColor
            ElementEditText.snp.makeConstraints{ make in
                make.width.equalToSuperview().multipliedBy(0.6)
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
        
        SettingView.removeFromSuperview()
        if LineGraph != nil {
            LineGraph.removeFromSuperview()
        }
        if selectItem == "유가별 채소 가격 변동" || selectItem == "연도별 채소 생산량 및 평균가" {
            InitUI()
            addPickerViewType(type: 0)
            makeConstraintsType(type : 0)
            
            if selectItem == "유가별 채소 가격 변동"{
                xLabel = "평균 유가"
                yLabel = "채소 평균가"
            } else if selectItem == "연도별 채소 생산량 및 평균가"{
                xLabel = "생산 연도"
                yLabel = "생산량"
            }
        }
        else if selectItem == "날씨 요인에 따른 채소 가격 변동" || selectItem == "기타 요인에 따른 채소 가격 변동" {
            InitUI()
            addPickerViewType(type: 1)
            makeConstraintsType(type : 1)
            if selectItem == "날씨 요인에 따른 채소 가격 변동"{
                ElementList = ["평균 기온", "평균 습도", "강수량", "평균 풍량"]
                xLabel = "평균 기온"
                yLabel = "\(ElementList[0])에 따른 채소 평균가"
            }else {
                ElementList = ["곡물 및 식량작물", "채소 및 과실", "식료품", "음료품", "비료 및 농약",
                               "농업 및 건설용 기계", "기타 운송 장비", "전력 가스 및 증기", "수도 폐기물 처리 및 재활용 서비스", "음식점 및 숙박 서비스", "장비 용품 및 지식 재산권 임대"]
                xLabel = "곡물 및 식량작물"
                yLabel = "\(ElementList[0])에 따른 채소 평균가"
            }
            ElementEditText.text = ElementList[0]
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
        btnDone.tintColor = UIColor(rgb: ColorSetting.backgroundColor)
        btnCancel.tintColor = UIColor(rgb: ColorSetting.backgroundColor)
        
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
        FoodEditText.textColor = UIColor(rgb: ColorSetting.textColor).withAlphaComponent(1)
        FoodEditText.font = UIFont.systemFont(ofSize: 16, weight: .bold)
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

    @objc func onFoodPickCancel() {
        FoodEditText.resignFirstResponder() // 피커뷰를 내림 (텍스트필드가 responder 상태를 읽음)
    }
    
    func InitKindPicker(){
        let btnDone = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(self.onKindPickDone))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let btnCancel = UIBarButtonItem(title: "취소", style: .done, target: self, action: #selector(self.onKindPickCancel))
        btnDone.tintColor = UIColor(rgb: ColorSetting.backgroundColor)
        btnCancel.tintColor = UIColor(rgb: ColorSetting.backgroundColor)
        
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
        KindEditText.textColor = UIColor(rgb: ColorSetting.textColor).withAlphaComponent(1)
        KindEditText.font = UIFont.systemFont(ofSize: 16, weight: .bold)
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
        btnDone.tintColor = UIColor(rgb: ColorSetting.backgroundColor)
        btnCancel.tintColor = UIColor(rgb: ColorSetting.backgroundColor)
        
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
        RankEditText.textColor = UIColor(rgb: ColorSetting.textColor).withAlphaComponent(1)
        RankEditText.font = UIFont.systemFont(ofSize: 16, weight: .bold)
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
        btnDone.tintColor = UIColor(rgb: ColorSetting.backgroundColor)
        btnCancel.tintColor = UIColor(rgb: ColorSetting.backgroundColor)
        
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
        ElementEditText.textColor = UIColor(rgb: ColorSetting.textColor).withAlphaComponent(1)
        ElementEditText.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    }
    
    @objc func onElementPickDone() {
        ElementEditText.text = selectElement
        ElementEditText.resignFirstResponder()
        yLabel = "\(selectElement)에 따른 채소 평균가"
        
        if selectItem == "날씨 요인에 따른 채소 가격 변동"{
            element_dict = ["평균 기온" : 0, "평균 습도" : 1, "강수량" : 2, "평균 풍량" : 3]
            
        } else if selectItem == "기타 요인에 따른 채소 가격 변동" {
            element_dict = ["곡물 및 식량작물" : 0, "채소 및 과실" : 1, "식료품" : 2, "음료품" : 3, "비료 및 농약" : 4, "농업 및 건설용 기계" : 5, "기타 운송 장비" : 6, "전력 가스 및 증기" : 7, "수도 폐기물 처리 및 재활용 서비스" : 8, "음식점 및 숙박 서비스" : 9, "장비 용품 및 지식 재산권 임대" : 10]
        }
    }

    // 피커뷰 > 취소 클릭
    @objc func onElementPickCancel() {
        ElementEditText.resignFirstResponder() // 피커뷰를 내림 (텍스트필드가 responder 상태를 읽음)
    }
}
