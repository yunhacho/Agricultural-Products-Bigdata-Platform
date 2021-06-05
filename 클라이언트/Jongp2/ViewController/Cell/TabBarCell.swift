//
//  TabBarCollectionView.swift
//  Jongp2
//
//  Created by junseok on 2021/05/30.
//
import UIKit
import SnapKit

class TabBarCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "TabBarCell"
    
    var titleLabel = UILabel()
    func setTitle(title: String) {
        titleLabel.text = title
        titleLabel.textAlignment = .center
        self.contentView.addSubview(titleLabel)
        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        titleLabel.backgroundColor = UIColor(rgb: ColorSetting.backgroundColor ).withAlphaComponent(0.2)
        
        contentView.layer.borderWidth = 0.3
        contentView.layer.borderColor = UIColor.white.cgColor
        
        contentView.snp.makeConstraints{ make in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
        titleLabel.snp.makeConstraints{ make in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
    }
    
    override var isSelected: Bool {
        willSet {
            if newValue {
                titleLabel.backgroundColor = UIColor(rgb: ColorSetting.backgroundColor).withAlphaComponent(1)
                titleLabel.textColor = .white
                titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
            } else {
                //titleLabel.backgroundColor = UIColor(red: 255, green: 153, blue: 102, alpha: 1)
                titleLabel.backgroundColor = UIColor(rgb: ColorSetting.backgroundColor).withAlphaComponent(0.2)
                titleLabel.textColor = .black
                titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
            }
        }
    }
    override func prepareForReuse() {
        isSelected = false
    }

}

