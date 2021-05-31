//
//  FirstTabController.swift
//  Jongp2
//
//  Created by junseok on 2021/05/30.
//


import UIKit
import SnapKit

class FirstTabController: UIViewController {
    let SettingView = UIView()
    
    var itemName : String!
    var timestamp1 : String!
    var timestamp2 : String!
    
    let list = ["가격 비교", "기간 검색", "그래프", "가격 예측"]
    var tabCollectionView : UICollectionView!
    
    var TabCellWidth : CGFloat!
    var TabCellHeight : CGFloat!
    var contentView : UIView!
    
    var selectStoryBoard : UIStoryboard!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initValue()
        InitTabview()
        addView()
        makeConstraints()
    }
    
    func addView(){
        //self.view.addSubview(SettingView)
        self.view.backgroundColor = .white
        self.view.addSubview(tabCollectionView)
        self.view.addSubview(contentView)
    }
    
    func initValue(){
        selectStoryBoard = UIStoryboard(name: "FirstTab", bundle: nil)
        contentView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height * 0.78))
        contentView.isUserInteractionEnabled = true
      
    }
    
    func InitTabview(){
        
        TabCellWidth = self.view.frame.width * 0.25
        TabCellHeight = TabCellWidth * 0.6
        
        let layout = UICollectionViewFlowLayout()
        
        tabCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: TabCellHeight), collectionViewLayout: layout)
        
        tabCollectionView.register(TabBarCollectionViewCell.self, forCellWithReuseIdentifier: TabBarCollectionViewCell.reuseIdentifier)
        tabCollectionView.delegate = self
        tabCollectionView.dataSource = self
        
        //첫번째를 선택하게 둠
        let firstIndexPath = IndexPath(item: 0, section: 0)
        collectionView(tabCollectionView, didSelectItemAt: firstIndexPath)
    }
    
    func makeConstraints(){
        
        //white로 무조건 넣어주기
        tabCollectionView.backgroundColor = .white
        tabCollectionView.snp.makeConstraints{ make in
            make.top.equalTo(self.view).offset(50)
            make.width.equalToSuperview()
            make.height.equalTo(TabCellHeight)
        }
        
        contentView.snp.makeConstraints{ make in
            make.top.equalTo(tabCollectionView.snp.bottom).offset(0)
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.78)
            
        }
    }
    
    
}

extension FirstTabController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == tabCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TabBarCell", for: indexPath) as! TabBarCollectionViewCell
            cell.setTitle(title: list[indexPath.row])
            if indexPath.row == 0 {
                cell.isSelected = true
            }else {
                cell.isSelected = false
            }
            
            return cell
        }
        else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == tabCollectionView {
            
            for view in self.contentView.subviews {
                print(view)
                view.removeFromSuperview()
            }
            
            if indexPath.row == 0{
                let Controller = selectStoryBoard.instantiateViewController(withIdentifier: "FoodCompareView") as! FoodCompareViewController
                self.contentView.addSubview(Controller.view)
                addChild(Controller)
                didMove(toParent: self)
            }
            else if indexPath.row == 1{
                let Controller = selectStoryBoard.instantiateViewController(withIdentifier: "DateSearchView") as! DateSearchViewController
                self.contentView.addSubview(Controller.view)
                addChild(Controller)
                
                //self.addChildViewController(newsPageVC)
                didMove(toParent: self)
                
            }
            else if indexPath.row == 2{
                let Controller = selectStoryBoard.instantiateViewController(withIdentifier: "GraphView") as! GraphViewController
                self.contentView.addSubview(Controller.view)
                addChild(Controller)
                didMove(toParent: self)
            }
            else if indexPath.row == 3{
                let Controller = selectStoryBoard.instantiateViewController(withIdentifier: "PredictPriceView") as! PredictPriceViewController
                self.contentView.addSubview(Controller.view)
                addChild(Controller)
                didMove(toParent: self)
            }
            else{
                self.contentView.backgroundColor = .red
            }
            
        }
    }

    // 위 아래 간격
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
   }

   // 옆 간격
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.3
   }

    
    // cell 사이즈( 옆 라인을 고려하여 설정 )
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
                            UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: TabCellWidth - 0.3, height: TabCellHeight)
    }

}

extension FirstTabController{
   
}
