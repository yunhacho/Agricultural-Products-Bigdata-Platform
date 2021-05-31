//
//  Jongp_URL.swift
//  Jongp2
//
//  Created by junseok on 2021/04/11.
//

import Foundation

struct WasURL  {
    
    static let ip = "39.112.118.107"
    static let port = "5222"
    static let WebSocketPort = "8088"
    static let RadisIP = "34.64.88.129"
    static let RadisPort = 6379
    
    static func getsignInURL()->String{
        let signInURL = "http://39.112.118.107:5222//signIn"
        return signInURL
    }
    
    static func getsignUpURL()->String{
        let signUpURL =  "http://39.112.118.107:5222/signUp"
        return signUpURL
    }

    static func raceRecordURL()->String{
        let signInURL = "http://39.112.118.107:5222/raceRecord"
        return signInURL
    }

    static func startRaceURL()->String{
        let signInURL = "http://39.112.118.107:5222/startRace"
        return signInURL
    }
    
    static func makeRoomURL()->String{
        let signInURL = "http://39.112.118.107:5222/makeRoom"
        return signInURL
        
    }
    
    static func getURL(url : requestURL)->String{
        switch url{
        case .signIn:
            return "http://\(ip):\(port)/\(requestURL.signIn.rawValue)"
        case .signUp :
            return "http://\(ip):\(port)/\(requestURL.signUp.rawValue)"
        case .signUpDuplicateCheck :
            return "http://\(ip):\(port)/\(requestURL.signUpDuplicateCheck.rawValue)"
        case .makeRoom :
            return "http://\(ip):\(port)/\(requestURL.makeRoom.rawValue)"
        case .enterRoom :
            return "http://\(ip):\(port)/\(requestURL.enterRoom.rawValue)"
        case .refreshRoom :
            return "http://\(ip):\(port)/\(requestURL.refreshRoom.rawValue)"
        case .startRace :
            return "http://\(ip):\(port)/\(requestURL.startRace.rawValue)"
        case .coordinateRecord :
            return "http://\(ip):\(port)/\(requestURL.coordinateRecord.rawValue)"
        case .distanceRecord :
            return "http://\(ip):\(port)/\(requestURL.distanceRecord.rawValue)"
        case .raceRecord :
            return "http://\(ip):\(port)/\(requestURL.raceRecord.rawValue)"
        case .history :
            return "http://\(ip):\(port)/\(requestURL.history.rawValue)"
        case .historyAll :
            return "http://\(ip):\(port)/\(requestURL.historyAll.rawValue)"
        }
    }
}

enum requestURL : String{
    case signIn = "signIn"
    case signUp = "signUp"
    case signUpDuplicateCheck = "signUp/duplicateCheck"
    case makeRoom = "makeRoom"
    case enterRoom = "enterRoom"
    case refreshRoom = "refreshRoom"
    case startRace = "startRace"
    case coordinateRecord = "coordinateRecord"
    case distanceRecord = "distanceRecord"
    case raceRecord = "raceRecord"
    case history = "history"
    case historyAll = "historyAll"
}
