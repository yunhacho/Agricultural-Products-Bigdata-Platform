//
//  Jongp_URL.swift
//  Jongp2
//
//  Created by junseok on 2021/04/11.
//

import Foundation

struct Jong_URL {
    
    static func getFoodURL()->String{
        let Food_url = "http://127.0.0.1:5000/getFood"
        return Food_url
    }
    
    static func getAuctionURL()->String{
        let Auction_url = "http://127.0.0.1:5000/getAuction"
        return Auction_url
    }
    
}
