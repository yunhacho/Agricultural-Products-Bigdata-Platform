//
//  AuctionFood.swift
//  Jongp2
//
//  Created by junseok on 2021/04/12.
//

import Foundation

class AuctionFoods : ObservableObject{
    
    @Published var AuctionFoods : [AuctionFood] = []
    
    init(){
        //AuctionFoods = setAuctionFoods()
        
        let timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(UpdateFoods), userInfo: nil, repeats: true)
        timer.tolerance = 0.2
    }
    
    @objc func UpdateFoods(){
        
        var tempAuctionFoods : [AuctionFood] = []
        
        request(Jong_URL.getAuctionURL(), "GET"){ (success , data) in
            for i in 0..<data.count{
                let name : String! = data[i].name!
                let category : String! = data[i].category!
                let price_1day : String! = data[i].price_1day!
                let price_1week : String! = data[i].price_1week!
                let price_1month : String! = data[i].price_1month!
                let price_1year : String! = data[i].price_1year!
        
                tempAuctionFoods.append(AuctionFood(name: name, category: category, price_1day: price_1day, price_1week: price_1week, price_1month: price_1month, price_1year: price_1year))
            }
        }
        
        for i in 0..<tempAuctionFoods.count{
            AuctionFoods.append(tempAuctionFoods[i])
        }
    }
    
    func setAuctionFoods() -> [AuctionFood] {
        
        var tempAuctionFoods : [AuctionFood] = []
        
        request(Jong_URL.getAuctionURL(), "GET"){ (success , data) in
            for i in 0..<data.count{
                let name : String! = data[i].name!
                let category : String! = data[i].category!
                let price_1day : String! = data[i].price_1day!
                let price_1week : String! = data[i].price_1week!
                let price_1month : String! = data[i].price_1month!
                let price_1year : String! = data[i].price_1year!
        
                tempAuctionFoods.append(AuctionFood(name: name, category: category, price_1day: price_1day, price_1week: price_1week, price_1month: price_1month, price_1year: price_1year))
            }
        }
    
        for i in 0..<tempAuctionFoods.count{
            print(tempAuctionFoods[i].category!, tempAuctionFoods[i].name!, tempAuctionFoods[i].price_1day!, tempAuctionFoods[i].price_1month!)
        }
        
        return tempAuctionFoods
    }
}

struct AuctionFood{
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
