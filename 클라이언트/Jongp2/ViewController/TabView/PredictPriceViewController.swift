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

class PredictPriceViewController : UIViewController{
    
    var SettingView : UIView!
    
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

    let SearchBtn = UIButton()
    
    var selectFood = "오이"
    var selectKind = "가시계통(1kg)"
    var selectRank = "중품"
    var selectElement = "평균 기온"
    
    var FoodList : [String] = ["오이" , "양파", "파", "쌀", "호박"]
    var KindList : [String] = ["취청50개", "가시계통(1kg)", "다다기계통(100개"]
    var RankList : [String] = ["중품", "상품"]
    var ElementList : [String]!
    
    let food_dict : [String:Int] = ["오이":0, "양파": 1, "파":2, "호박":3, "쌀":4]
    let kind_dict : [String:Int] = ["취청(50개)":0, "가시계통(1kg)":1, "다다기계통(100개)":2, "햇양파(1kg)":3, "양파(1kg)":4, "수입(1kg)":5, "대파(1kg)":6, "쪽파(1kg)":7, "애호박(20개)":8, "쥬키니(1kg)":9, "일반계(1kg)":10, "햇일반계(1kg)":11]
    let rank_dict: [String:Int] = ["중품":0, "상품":1]
        
    let titleLabel = UILabel()
    let contentTitle = UILabel()
    let contentLabel = UILabel()
    var PredictPrice : Double = 34251
    
    let borderWidth : CGFloat = 0.2
    let borderColor : CGColor = UIColor.lightGray.cgColor
    
    
    override func viewDidLoad() {
        super.viewDidLayoutSubviews()
        InitUI()
        addView()
        addPickerViewType(type: 0)
        makeConstraintsType(type : 0)
        
        InitFoodPicker()
        InitKindPicker()
        InitRankPicker()
    }
    
    func addView(){
        
        self.view.isUserInteractionEnabled = true
        self.view.addSubview(SearchBtn)
        self.view.addSubview(contentTitle)
        self.view.addSubview(titleLabel)
        self.view.addSubview(contentLabel)
    }
    
    func addPickerViewType(type : Int){
        
        self.view.addSubview(SettingView)
        
        SettingView.addSubview(FoodTitleLabel)
        SettingView.addSubview(FoodEditText)
        
        SettingView.addSubview(KindTitleLabel)
        SettingView.addSubview(KindEditText)
        
        SettingView.addSubview(RankTitleLabel)
        SettingView.addSubview(RankEditText)
        
    }
    
    func InitUI(){
        SettingView = UIView()
        SettingView.isUserInteractionEnabled = true
        SettingView.layer.borderWidth = 1
        SettingView.layer.borderColor = UIColor.lightGray.cgColor
        
        FoodTitleLabel.text = "품목"
        FoodTitleLabel.textAlignment = .center
        FoodTitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        KindTitleLabel.text = "종류"
        KindTitleLabel.textAlignment = .center
        KindTitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        RankTitleLabel.text = "등급"
        RankTitleLabel.textAlignment = .center
        RankTitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        SearchBtn.setTitle("예측하기", for: .normal)
        SearchBtn.setTitleColor(ColorSetting.btnTextColor, for: .normal)
        SearchBtn.backgroundColor = UIColor(rgb: ColorSetting.backgroundColor).withAlphaComponent(1).withAlphaComponent(ColorSetting.btnAlpha)
        SearchBtn.isUserInteractionEnabled = true
        SearchBtn.addTarget(self, action: #selector(self.onPress), for: .touchUpInside)
        
        titleLabel.text = "품목,종류,등급을 설정 후\n예측하기 버튼을 눌러주세요"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        titleLabel.numberOfLines = 2
        
        contentTitle.text = "예측가"
        contentTitle.textAlignment = .center
        contentTitle.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        
        contentLabel.text = ""
        contentLabel.textAlignment = .center
        contentTitle.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        contentLabel.layer.borderWidth = 0.5
        contentLabel.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    @objc func onPress() {
        print("Search click")
        
        getBeforePrice(item : food_dict[selectFood]!, kind : kind_dict[selectKind]!, rank : rank_dict[selectRank]!)
    }
    
    func makeConstraintsType(type : Int){
        let settingViewHeight = 0.06
        
        SettingView.snp.makeConstraints{ make in
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(settingViewHeight)
            make.left.right.equalTo(0)
            make.top.equalToSuperview()
        }
        
        var Cellheight : Double = 1
        if type == 0 {
            Cellheight = 1
        }
        
        FoodTitleLabel.layer.borderWidth = borderWidth
        FoodTitleLabel.layer.borderColor = borderColor
        FoodTitleLabel.snp.makeConstraints{ make in
            make.width.equalToSuperview().multipliedBy(0.15)
            make.height.equalToSuperview().multipliedBy(Cellheight)
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        FoodEditText.layer.borderWidth = borderWidth
        FoodEditText.layer.borderColor = borderColor
        FoodEditText.snp.makeConstraints{ make in
            make.width.equalToSuperview().multipliedBy(0.10)
            make.height.equalToSuperview().multipliedBy(Cellheight)
            make.leading.equalTo(FoodTitleLabel.snp.trailing)
            make.top.equalToSuperview()
        }
        
        KindTitleLabel.layer.borderWidth = borderWidth
        KindTitleLabel.layer.borderColor = borderColor
        KindTitleLabel.snp.makeConstraints{ make in
            make.width.equalToSuperview().multipliedBy(0.15)
            make.height.equalToSuperview().multipliedBy(Cellheight)
            make.leading.equalTo(FoodEditText.snp.trailing)
            make.top.equalToSuperview()
        }
        
        KindEditText.layer.borderWidth = borderWidth
        KindEditText.layer.borderColor = borderColor
        KindEditText.snp.makeConstraints{ make in
            make.width.equalToSuperview().multipliedBy(0.30)
            make.height.equalToSuperview().multipliedBy(Cellheight)
            make.leading.equalTo(KindTitleLabel.snp.trailing)
            make.top.equalToSuperview()
        }
        
        RankTitleLabel.layer.borderWidth = borderWidth
        RankTitleLabel.layer.borderColor = borderColor
        RankTitleLabel.snp.makeConstraints{ make in
            make.width.equalToSuperview().multipliedBy(0.15)
            make.height.equalToSuperview().multipliedBy(Cellheight)
            make.leading.equalTo(KindEditText.snp.trailing)
            make.top.equalToSuperview()
        }
        
        RankEditText.layer.borderWidth = borderWidth
        RankEditText.layer.borderColor = borderColor
        RankEditText.snp.makeConstraints{ make in
            make.width.equalToSuperview().multipliedBy(0.15)
            make.height.equalToSuperview().multipliedBy(Cellheight)
            make.leading.equalTo(RankTitleLabel.snp.trailing)
            make.top.equalToSuperview()
        }
        
        SearchBtn.snp.makeConstraints{ make in
            make.width.equalToSuperview().multipliedBy(1)
            make.height.equalTo(FoodTitleLabel.snp.height).multipliedBy(0.7)
            make.leading.equalToSuperview()
            make.top.equalTo(SettingView.snp.bottom)
        }
        
        titleLabel.snp.makeConstraints{ make in
            make.width.equalToSuperview().multipliedBy(1)
            make.height.equalToSuperview().multipliedBy(0.15)
            make.centerX.equalToSuperview()
            make.top.equalTo(SearchBtn.snp.bottom)
        }
        
        contentTitle.snp.makeConstraints{ make in
            make.width.equalToSuperview().multipliedBy(0.25)
            make.height.equalToSuperview().multipliedBy(0.04)
            make.top.equalTo(titleLabel.snp.bottom)
            make.leading.equalToSuperview()
        }
        
        contentLabel.snp.makeConstraints{ make in
            make.width.equalToSuperview().multipliedBy(0.7)
            make.height.equalToSuperview().multipliedBy(0.04)
            make.top.equalTo(titleLabel.snp.bottom)
            make.leading.equalTo(contentTitle.snp.trailing)
        }
    }
    
}


extension PredictPriceViewController : UIPickerViewDelegate , UIPickerViewDataSource {
    
    
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
        if (pickerView == FoodPicker){
            return FoodList.count
        } else if (pickerView == KindPicker){
            return KindList.count
        } else if (pickerView == RankPicker){
            return RankList.count
        }
        return 0
    }

    // 피커뷰에 보여줄 값 전달
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView == FoodPicker){
            selectFood = FoodList[row]
            return FoodList[row]
        } else if (pickerView == KindPicker){
            selectKind = KindList[row]
            return KindList[row]
        } else if (pickerView == RankPicker){
            selectRank = RankList[row]
            return RankList[row]
        }
        return ""
    }

    // 피커뷰에서 선택시 호출
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (pickerView == FoodPicker){
            selectFood = FoodList[row]
        } else if (pickerView == KindPicker){
            selectKind = KindList[row]
        } else if (pickerView == RankPicker){
            selectRank = RankList[row]
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
        FoodEditText.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
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
        KindEditText.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
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
        
        RankEditText.inputView = RankPicker
        RankEditText.inputAccessoryView = RankToolbar
        RankEditText.borderRect(forBounds: CGRect(x: 0, y: 0, width: 100, height: 30))
        RankEditText.textAlignment = .center
        RankEditText.text = RankList[0]
        RankEditText.textColor = UIColor(rgb: ColorSetting.textColor).withAlphaComponent(1)
        RankEditText.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
    }
    
    @objc func onRankPickDone() {
        RankEditText.text = selectRank
        RankEditText.resignFirstResponder()
    }

    // 피커뷰 > 취소 클릭
    @objc func onRankPickCancel() {
        RankEditText.resignFirstResponder() // 피커뷰를 내림 (텍스트필드가 responder 상태를 읽음)
    }
    
}

extension PredictPriceViewController{
    
    func getBeforePrice(item : Int, kind : Int, rank : Int){
        print("\(WasURL.getURL(url:requestURL.price_predict))?item=\(item)&kind=\(kind)&rank=\(rank)")
        getPredictPrice(url : "\(WasURL.getURL(url:requestURL.price_predict))?item=\(item)&kind=\(kind)&rank=\(rank)"){ [weak self] result in
            
            self?.PredictPrice = result.predict_price
            DispatchQueue.main.async {
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                self?.contentLabel.text = numberFormatter.string(for: result.predict_price)! + "(원)"
            }
        }
    }
    
}

struct PredictFood : Codable {
    let predict_price : Double
}
