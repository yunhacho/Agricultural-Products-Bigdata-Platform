//
//  FoodContent.swift
//  Jongp2
//
//  Created by junseok on 2021/04/08.
//

import Foundation
//model 부분


class FoodContents : ObservableObject{
 
    @Published var FoodContents : [FoodContent] = []
    
    init() {
        //self.FoodContents = setFoodContents()
        self.FoodContents = setFoodcontents2()
        
    }
    
    func setFoodContents() -> [FoodContent]{
        var tempContents : [FoodContent] = []
        for _ in 1...15{
            tempContents.append(FoodContent(name: "쌀", category: "상품", price_1day: "58,440", price_1week: "58,440", price_1month: "57,905", price_1year: "47,100"))
        }
        return tempContents
    }
    
    @objc func tt(){
        FoodContents.append(FoodContent(name: "수박", category: "시발", price_1day: "77,440", price_1week: "77,440", price_1month: "57,905", price_1year: "47,100"))
    }
    
    func setFoodcontents2() -> [FoodContent]{
        
        var tempContents : [FoodContent] = []
        
        request(Jong_URL.getFoodURL(), "GET"){ (success , data) in
                for i in 0..<data.count{
                    let name : String! = data[i].name!
                    let category : String! = data[i].category!
                    let price_1day : String! = data[i].price_1day!
                    let price_1week : String! = data[i].price_1week!
                    let price_1month : String! = data[i].price_1month!
                    let price_1year : String! = data[i].price_1year!
                    
                    tempContents.append(FoodContent(name: name!, category: category!, price_1day: price_1day!, price_1week: price_1week!, price_1month: price_1month!, price_1year: price_1year!))
                }
            }
    
        for i in 0..<tempContents.count{
            print(tempContents[i].category!, tempContents[i].name!, tempContents[i].price_1day!, tempContents[i].price_1month!)
        }
        return tempContents
    }
}

struct FoodContent {
    
    let name : String!
    let category : String!
    let price_1day : String!
    let price_1week : String!
    let price_1month : String!
    let price_1year : String!
    
    init(name : String!, category : String!, price_1day : String!, price_1week : String!, price_1month : String!, price_1year : String!) {
        self.name = name
        self.category = category
        self.price_1day = price_1day
        self.price_1week = price_1week
        self.price_1month = price_1month
        self.price_1year = price_1year
    }
}
