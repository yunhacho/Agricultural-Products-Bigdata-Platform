//
//  AuctionCell.swift
//  Jongp2
//
//  Created by junseok on 2021/06/01.
//

import UIKit
import SnapKit

class AuctionCell: UITableViewCell {

    static let identifier = "AuctionCell"
        
    let mclassLabel = UILabel()
    let unitnameLabel = UILabel()
    let gradenameLabel = UILabel()
    let sclassnameLabel = UILabel()
    let tradeamtLabel = UILabel()
    let priceLabel = UILabel()
    let sanjiLabel = UILabel()
    let bidtimeLabel = UILabel()
    let marketnameLabel = UILabel()
    let conameLabel = UILabel()
    
    let borderWidth : CGFloat = 0.2
    let borderColor : CGColor = UIColor.lightGray.cgColor
    
    override
    init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addView()
        LabelInit()
        makeConstraints()
    }
    
    func addView(){
        contentView.addSubview(mclassLabel)
        contentView.addSubview(unitnameLabel)
        contentView.addSubview(gradenameLabel)
        contentView.addSubview(sclassnameLabel)
        contentView.addSubview(tradeamtLabel)
        
        contentView.addSubview(priceLabel)
        contentView.addSubview(sanjiLabel)
        contentView.addSubview(bidtimeLabel)
        contentView.addSubview(marketnameLabel)
        contentView.addSubview(conameLabel)
    }
    
    func LabelInit(){
        mclassLabel.textColor = .black
        mclassLabel.textAlignment = .center
        mclassLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        
        unitnameLabel.textColor = .black
        unitnameLabel.textAlignment = .center
        unitnameLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        
        gradenameLabel.textColor = .black
        gradenameLabel.textAlignment = .center
        gradenameLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        
        sclassnameLabel.textColor = .black
        sclassnameLabel.textAlignment = .center
        sclassnameLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        
        tradeamtLabel.textColor = .black
        tradeamtLabel.textAlignment = .center
        tradeamtLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        
        priceLabel.textColor = .black
        priceLabel.textAlignment = .center
        priceLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        
        sanjiLabel.textColor = .black
        sanjiLabel.textAlignment = .center
        sanjiLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        
        bidtimeLabel.textColor = .black
        bidtimeLabel.textAlignment = .center
        bidtimeLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        
        marketnameLabel.textColor = .black
        marketnameLabel.textAlignment = .center
        marketnameLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        
        conameLabel.textColor = .black
        conameLabel.textAlignment = .center
        conameLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
    }
    
    func makeConstraints(){
        let height = 0.5
        
        contentView.layer.borderWidth = 0.7
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.snp.makeConstraints{ make in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
        //
        mclassLabel.layer.borderWidth = borderWidth
        mclassLabel.layer.borderColor = borderColor
        mclassLabel.snp.makeConstraints{ make in
            make.width.equalToSuperview().multipliedBy(0.25)
            make.height.equalToSuperview().multipliedBy(height)
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
        }
        
        unitnameLabel.layer.borderWidth = borderWidth
        unitnameLabel.layer.borderColor = borderColor
        unitnameLabel.snp.makeConstraints{ make in
            make.width.equalToSuperview().multipliedBy(0.25)
            make.height.equalToSuperview().multipliedBy(height)
            make.top.equalTo(mclassLabel.snp.bottom)
            make.leading.equalToSuperview()
        }
        //

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
    
    required init?(coder aDecoder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
    }

}

