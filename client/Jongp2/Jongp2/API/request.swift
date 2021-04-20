//
//  request.swift
//  Jongp2
//
//  Created by junseok on 2021/04/11.
import UIKit

struct Response: Codable {
    let success: Bool
    let result: String
    let message: String
}

struct Profile : Codable {
    let name: String
    let part: String
}

struct Foods : Codable{
    let contents : [Food]
}

struct Food : Codable{
    let name : String?
    let category : String?
    let price_1day : String?
    let price_1week : String?
    let price_1month : String?
    let price_1year : String?
}

func requestGet(url: String, completionHandler: @escaping (Bool, [Food]) -> Void) {
    guard let url = URL(string: url) else {
        print("Error: cannot create URL")
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    
    let semaphore = DispatchSemaphore(value: 0)
    
    URLSession.shared.dataTask(with: request) { data, response, error in
        
        guard error == nil else {
            print("Error: error calling GET")
            print(error!)
            return
        }
        
        guard let data = data else {
            print("Error: Did not receive data")
            return
        }
        
        guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
            print("Error: HTTP request failed")
            return
        }
        
        
        guard let output = try? JSONDecoder().decode(Foods.self, from: data) else {
            print("Error: JSON Data Parsing failed")
            return
        }
        print(type(of: output.contents))
        let val = output.contents
        completionHandler(true, val)
        
        semaphore.signal()
    }.resume()
    
    semaphore.wait()
}

func requestPost(url: String, method: String, param: [String: Any], completionHandler: @escaping (Bool, [Food]) -> Void) {
    let sendData = try! JSONSerialization.data(withJSONObject: param, options: [])
    
    guard let url = URL(string: url) else {
        print("Error: cannot create URL")
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = method
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = sendData
    
    URLSession.shared.dataTask(with: request) { (data, response, error) in
        guard error == nil else {
            print("Error: error calling GET")
            print(error!)
            return
        }
        guard let data = data else {
            print("Error: Did not receive data")
            return
        }
        guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
            print("Error: HTTP request failed")
            return
        }
        
        
        
        guard let output = try? JSONDecoder().decode(Foods.self, from: data) else {
            print("Error: JSON Data Parsing failed")
            return
        }
        
        completionHandler(true, output.contents)
    }.resume()
}


func request(_ url: String, _ method: String, _ param: [String: Any]? = nil, completionHandler: @escaping (Bool, [Food]) -> Void) {
    if method == "GET" {
        requestGet(url: url) { (success, data) in
            completionHandler(success, data)
        }
    }
    else {
        requestPost(url: url, method: method, param: param!) { (success, data) in
            completionHandler(success, data)
        }
    }
}
