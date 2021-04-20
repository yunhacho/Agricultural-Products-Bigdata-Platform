//
//  Menu1.swift
//  Jongp2
//
//  Created by junseok on 2021/04/07.
//

import SwiftUI

struct Menu1: View {
    
    
    @ObservedObject var FoodClass = FoodContents()

    var body: some View {
            VStack{
                Text("menu1")
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
                List(self.FoodClass.FoodContents, id: \.name){ Food in
                    Cell(foodContent: Food)
                }
            }
        
        
    }
}

struct Cell : View {
    var foodContent : FoodContent
    
    var body: some View {
        HStack(spacing: 5){
            Text(foodContent.name).frame(width:50)
            Text(foodContent.price_1day).frame(width:70)
            Text(foodContent.price_1week).frame(width:70)
            Text(foodContent.price_1month).frame(width:70)
            Text(foodContent.price_1year).frame(width:70)
            
        }.frame(height: 60, alignment: .center)
    }
}

struct Menu1_Previews: PreviewProvider {
    static var previews: some View {
        Menu1()
    }
}
