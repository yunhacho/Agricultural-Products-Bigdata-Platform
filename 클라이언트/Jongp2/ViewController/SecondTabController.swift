//
//  SecondTabController.swift
//  Jongp2
//
//  Created by junseok on 2021/05/30.
//

import Foundation
import UIKit
import SnapKit

class SecondTabController : UIViewController{
    
    let TitleBar = UILabel()
    
    let FoodTitleLabel = UIView()
    let FoodTableView = UITableView()
    var FoodContents : [FoodContent] = []
    
    let borderWidth : CGFloat = 0.4
    let borderColor : CGColor = UIColor.black.cgColor
    
    var AuctionList : [Auction] = []
    
    override func viewDidLoad() {
        super.viewDidLayoutSubviews()
        InitUI()
        addView()
        makeConstraints()
        
        InitTitle()
        initFoodContents()
        tableViewSetting(width: self.view.frame.width, height: self.view.frame.height * 0.3)
    }
    
    func addView(){
        self.view.addSubview(TitleBar)
        self.view.addSubview(FoodTitleLabel)
        self.view.addSubview(FoodTableView)
    }
    
    func InitUI(){
        TitleBar.text = "실시간 경매 조회"
        TitleBar.textAlignment = .center
        TitleBar.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        FoodTitleLabel.backgroundColor = UIColor(rgb: ColorSetting.backgroundColor).withAlphaComponent(0.3)
        FoodTitleLabel.layer.borderWidth = 0.8
        FoodTitleLabel.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func makeConstraints(){
        TitleBar.snp.makeConstraints{ make in
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.06)
            make.top.equalTo(self.view).offset(40)
        }
        
        FoodTitleLabel.layer.borderWidth = 0.6
        FoodTitleLabel.layer.borderColor = borderColor
        FoodTitleLabel.snp.makeConstraints{ make in
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.075)
            make.top.equalTo(TitleBar.snp.bottom)
        }
        
        FoodTableView.snp.makeConstraints{ make in
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.8)
            make.top.equalTo(FoodTitleLabel.snp.bottom)
        }
    }
    
    func InitTitle(){
        
        let mclassLabel = UILabel()
        let unitLabel = UILabel()
        
        let sclassnameLabel = UILabel()
        
        let priceLabel = UILabel()
        let tradeamtLabel = UILabel()
        
        let sanjiLabel = UILabel()
        
        let bidtimeLabel = UILabel()
        
        let marketnameLabel = UILabel()
        let conameLabel = UILabel()
        
        let height = 0.5
        
        mclassLabel.text = "품목명(등급)"
        mclassLabel.textAlignment = .center
        mclassLabel.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        
        unitLabel.text = "규격"
        unitLabel.textAlignment = .center
        unitLabel.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        
        //
        sclassnameLabel.text = "품종"
        sclassnameLabel.textAlignment = .center
        sclassnameLabel.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        
        
        //
        priceLabel.text = "경락가"
        priceLabel.textAlignment = .center
        priceLabel.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        
        tradeamtLabel.text = "거래량"
        tradeamtLabel.textAlignment = .center
        tradeamtLabel.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        
        sanjiLabel.text = "산지"
        sanjiLabel.textAlignment = .center
        sanjiLabel.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        
        bidtimeLabel.text = "경매시간"
        bidtimeLabel.textAlignment = .center
        bidtimeLabel.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        
        marketnameLabel.text = "도매시장"
        marketnameLabel.textAlignment = .center
        marketnameLabel.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        
        conameLabel.text = "도매법인"
        conameLabel.textAlignment = .center
        conameLabel.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        
        FoodTitleLabel.addSubview(mclassLabel)
        FoodTitleLabel.addSubview(unitLabel)
        
        FoodTitleLabel.addSubview(sclassnameLabel)
        
        FoodTitleLabel.addSubview(priceLabel)
        FoodTitleLabel.addSubview(tradeamtLabel)
        
        FoodTitleLabel.addSubview(sanjiLabel)
        
        FoodTitleLabel.addSubview(bidtimeLabel)
        
        FoodTitleLabel.addSubview(marketnameLabel)
        FoodTitleLabel.addSubview(conameLabel)
        
        mclassLabel.layer.borderWidth = borderWidth
        mclassLabel.layer.borderColor = borderColor
        mclassLabel.snp.makeConstraints{ make in
            make.width.equalToSuperview().multipliedBy(0.25)
            make.height.equalToSuperview().multipliedBy(height)
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
        }
        
        unitLabel.layer.borderWidth = borderWidth
        unitLabel.layer.borderColor = borderColor
        unitLabel.snp.makeConstraints{ make in
            make.width.equalToSuperview().multipliedBy(0.25)
            make.height.equalToSuperview().multipliedBy(height)
            make.top.equalTo(mclassLabel.snp.bottom)
            make.leading.equalToSuperview()
        }
        
        //
        priceLabel.layer.borderWidth = borderWidth
        priceLabel.layer.borderColor = borderColor
        priceLabel.snp.makeConstraints{ make in
            make.width.equalToSuperview().multipliedBy(0.18)
            make.height.equalToSuperview().multipliedBy(height)
            make.top.equalToSuperview()
            make.leading.equalTo(mclassLabel.snp.trailing)
        }
        
        tradeamtLabel.layer.borderWidth = borderWidth
        tradeamtLabel.layer.borderColor = borderColor
        tradeamtLabel.snp.makeConstraints{ make in
            make.width.equalToSuperview().multipliedBy(0.18)
            make.height.equalToSuperview().multipliedBy(height)
            make.top.equalTo(priceLabel.snp.bottom)
            make.leading.equalTo(mclassLabel.snp.trailing)
        }
        
        //
        sclassnameLabel.layer.borderWidth = borderWidth
        sclassnameLabel.layer.borderColor = borderColor
        sclassnameLabel.snp.makeConstraints{ make in
            make.width.equalToSuperview().multipliedBy(0.22)
            make.height.equalToSuperview().multipliedBy(height)
            make.top.equalToSuperview()
            make.leading.equalTo(tradeamtLabel.snp.trailing)
        }
        
        sanjiLabel.layer.borderWidth = borderWidth
        sanjiLabel.layer.borderColor = borderColor
        sanjiLabel.snp.makeConstraints{ make in
            make.width.equalToSuperview().multipliedBy(0.22)
            make.height.equalToSuperview().multipliedBy(height)
            make.top.equalTo(sclassnameLabel.snp.bottom)
            make.leading.equalTo(tradeamtLabel.snp.trailing)
        }
        
        //
        marketnameLabel.layer.borderWidth = borderWidth
        marketnameLabel.layer.borderColor = borderColor
        marketnameLabel.snp.makeConstraints{ make in
            make.width.equalToSuperview().multipliedBy(0.2)
            make.height.equalToSuperview().multipliedBy(height)
            make.top.equalToSuperview()
            make.leading.equalTo(sanjiLabel.snp.trailing)
        }
        
        conameLabel.layer.borderWidth = borderWidth
        conameLabel.layer.borderColor = borderColor
        conameLabel.snp.makeConstraints{ make in
            make.width.equalToSuperview().multipliedBy(0.2)
            make.height.equalToSuperview().multipliedBy(height)
            make.top.equalTo(marketnameLabel.snp.bottom)
            make.leading.equalTo(sanjiLabel.snp.trailing)
        }
        
        //
        bidtimeLabel.layer.borderWidth = borderWidth
        bidtimeLabel.layer.borderColor = borderColor
        bidtimeLabel.snp.makeConstraints{ make in
            make.width.equalToSuperview().multipliedBy(0.15)
            make.height.equalToSuperview().multipliedBy(height * 2)
            make.top.equalToSuperview()
            make.leading.equalTo(marketnameLabel.snp.trailing)
        }
        
    }
    
    func tableViewSetting(width : CGFloat, height : CGFloat){
        FoodTableView.translatesAutoresizingMaskIntoConstraints = false
        FoodTableView.register(AuctionCell.self, forCellReuseIdentifier: AuctionCell.identifier)
        FoodTableView.dataSource = self
        FoodTableView.rowHeight = height * 0.275
    }
    
    func initFoodContents(){
        for _ in 0..<3{
            AuctionList.append(Auction(mclassname: "깻잎", sclassname: "깻잎 깻잎 (일반)", bidtime: "2021-06-02 13:23:32", price: 23500, gradename: "특", marketname: "광주각화도매", codname: "광주중앙청과", sanji: "충남 금산군", tradeamt: 21, unitname: "2kg 상자"))
            AuctionList.append(Auction(mclassname: "깻잎", sclassname: "깻잎 깻잎순", bidtime: "2021-06-02 13:23:32", price: 10200, gradename: "없음", marketname: "대전오정도매", codname: "농협대전(공)", sanji: "충남 금산군", tradeamt: 3, unitname: "4kg"))
            AuctionList.append(Auction(mclassname: "미나리", sclassname: "미나리 미나리(일반)", bidtime: "2021-06-02 13:23:32", price: 11300, gradename: "없음", marketname: "대전오정도매", codname: "대전청과", sanji: "충남 부여군", tradeamt: 34, unitname: "4kg 상자"))
            AuctionList.append(Auction(mclassname: "파프리카", sclassname: "파프리카 노랑파프리카", bidtime: "2021-06-02 13:23:32", price: 11300, gradename: "특", marketname: "대전오정도매", codname: "농협대전(공)", sanji: "전북 완주군", tradeamt: 32, unitname: "5kg"))
        }
    }
    
}

extension SecondTabController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return AuctionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AuctionCell.identifier, for: indexPath) as! AuctionCell
        cell.selectionStyle = .none
        
        if AuctionList.count > 0{
            cell.mclassLabel.text = AuctionList[indexPath.row].mclassname + "(\(String( AuctionList[indexPath.row].gradename)))"
            cell.unitnameLabel.text = AuctionList[indexPath.row].unitname
            
            
            
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            cell.priceLabel.text = numberFormatter.string(for: AuctionList[indexPath.row].price)!
            cell.tradeamtLabel.text = String(AuctionList[indexPath.row].tradeamt)
            
            cell.sclassnameLabel.text = AuctionList[indexPath.row].sclassname.components(separatedBy: " ").dropFirst().joined(separator: " ")//첫번째 단어 제거
            
            cell.sanjiLabel.text = AuctionList[indexPath.row].sanji
            
            let dateString:String = AuctionList[indexPath.row].bidtime
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            //dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
            
            let FinaldateFormatter = DateFormatter()
            FinaldateFormatter.dateFormat = "MM월dd일\n\nHH시mm분"
            
            cell.bidtimeLabel.text = FinaldateFormatter.string(from: dateFormatter.date(from: dateString)!)
            cell.bidtimeLabel.numberOfLines = 3
            
            
            cell.marketnameLabel.text = AuctionList[indexPath.row].marketname
            cell.conameLabel.text = AuctionList[indexPath.row].codname
            
            return cell
        }
        else {
            cell.gradenameLabel.text = "Not exist Any record"
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

struct Auction{
    let mclassname : String!
    let sclassname : String!
    let bidtime : String!
    let price : Int!
    let gradename : String!
    let marketname : String!
    let codname :  String!
    let sanji : String!
    let tradeamt : Int!
    let unitname : String!
}
