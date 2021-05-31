//
//  FoodCell.swift
//  Jongp2
//
//  Created by junseok on 2021/05/31.
//

import UIKit
import SnapKit

class FoodCell: UITableViewCell {

    static let identifier = "Foodcell"
    
    let itemNameLabel = UILabel()
    let timestampLabel = UILabel()
    let kindLabel = UILabel()
    let priceLabel = UILabel()
    let rankLabel = UILabel()
    let unitLabel = UILabel()
    
    override
    init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addView()
        LabelInit()
        
        contentView.snp.makeConstraints{ make in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        itemNameLabel.snp.makeConstraints{ make in
            make.width.equalToSuperview().multipliedBy(0.25)
            make.height.equalToSuperview().multipliedBy(0.4)
            make.leading.equalToSuperview()
            make.top.equalToSuperview().offset(5)
        }
        
        timestampLabel.snp.makeConstraints{ make in
            make.width.equalToSuperview().multipliedBy(0.25)
            make.height.equalToSuperview().multipliedBy(0.4)
            make.top.equalTo(itemNameLabel.snp.bottom).offset(0)
            make.leading.equalToSuperview()
        }

        kindLabel.snp.makeConstraints{ make in
            make.width.equalToSuperview().multipliedBy(0.35)
            make.height.equalToSuperview()
            make.leading.equalTo(timestampLabel.snp.trailing)
        }

        priceLabel.snp.makeConstraints{ make in
            make.width.equalToSuperview().multipliedBy(0.2)
            make.height.equalToSuperview()
            make.leading.equalTo(kindLabel.snp.trailing)
        }
        
        unitLabel.snp.makeConstraints{ make in
            make.width.equalToSuperview().multipliedBy(0.2)
            make.height.equalToSuperview()
            make.leading.equalTo(priceLabel.snp.trailing)
        }
        
    }
    
    func addView(){
        contentView.addSubview(itemNameLabel)
        contentView.addSubview(timestampLabel)
        contentView.addSubview(kindLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(rankLabel)
        contentView.addSubview(unitLabel)
    }
    
    func LabelInit(){
        
        itemNameLabel.textColor = .black
        itemNameLabel.textAlignment = .center
        itemNameLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        
        timestampLabel.textColor = .black
        timestampLabel.textAlignment = .center
        timestampLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        
        kindLabel.textColor = .black
        kindLabel.textAlignment = .center
        kindLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        
        priceLabel.textColor = .black
        priceLabel.textAlignment = .center
        priceLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        
        rankLabel.textColor = .black
        rankLabel.textAlignment = .center
        rankLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        
        unitLabel.textColor = .black
        unitLabel.textAlignment = .center
        unitLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
    }
    
    required init?(coder aDecoder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
    }

}
