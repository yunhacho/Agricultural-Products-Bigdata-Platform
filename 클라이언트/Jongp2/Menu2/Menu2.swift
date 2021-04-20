//
//  Menu2.swift
//  Jongp2
//
//  Created by junseok on 2021/04/07.
//

import SwiftUI

struct Menu2: View {
    
    @ObservedObject var AuctionClass : AuctionFoods = AuctionFoods()
    
    init(){
        
    }
    
    var body: some View {
        VStack{
            Text("menu2")
            Spacer()
            Spacer()
            Spacer()
            HStack(spacing: 28){
                Text("구분")
                Text("1일전")
                Text("1주일전")
                Text("1개월전")
                Text("1년전")
            }
            List(self.AuctionClass.AuctionFoods, id: \.name){ AuctionFood in
                AuctionCell(auctionFood: AuctionFood)
            }
        }
    }
}

struct AuctionCell : View {
    
    var auctionFood : AuctionFood
    
    var body: some View {
        HStack(spacing: 5){
            Text(auctionFood.name).frame(width:50)
            Text(auctionFood.price_1day).frame(width:70)
            Text(auctionFood.price_1week).frame(width:70)
            Text(auctionFood.price_1month).frame(width:70)
            Text(auctionFood.price_1year).frame(width:70)
        }.frame(height: 60, alignment: .center)
    }
}

struct Menu2_Previews: PreviewProvider {
    static var previews: some View {
        Menu2()
    }
}

