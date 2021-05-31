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
        //self.contentView.layer.borderWidth = 1
        //self.contentView.layer.borderColor = UIColor.gray.cgColor
        self.backgroundColor = .systemBlue
        
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
                titleLabel.textColor = .black
                titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
            } else {
                titleLabel.textColor = .white
            }
        }
    }
    override func prepareForReuse() {
        isSelected = false
    }

}

class TabPageCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "TabPageCell"
    lazy var backColor: [UIColor] = [.lightGray, .purple, .orange, .cyan, .magenta]
    
    func setColor(index: Int){
        self.backgroundColor = backColor[index]
    }
    
}


