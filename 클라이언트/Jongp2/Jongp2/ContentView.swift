//
//  ContentView.swift
//  Jongp2
//
//  Created by junseok on 2021/04/07.
//

import SwiftUI

struct ContentView: View {
    
    var Tab1 : Menu1?
    init() {
        Tab1 = Menu1()
    }
    
    var body: some View {
        
        VStack{
            TabView{
                Tab1.tabItem {
                    Image(systemName: "multiply")
                    Text("menu1")
                }
                
                Menu2().tabItem {
                    Image(systemName: "cart")
                    Text("menu2")
                }

            }.navigationBarTitle("menu1", displayMode: .inline)
        }
        
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
