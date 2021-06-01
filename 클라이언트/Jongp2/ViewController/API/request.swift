//
//  request.swift
//  Jongp2
//
//  Created by junseok on 2021/06/02.
//

import Foundation
import Alamofire

func getBeforeFood(url : String, completion: @escaping([FoodContent]) -> Void){
    let request =  AF.request(url).validate()
    request.responseJSON(queue : DispatchQueue.global(qos: .default)) { response in
        switch response.result {
            case .success:
                do {
                    
                    guard let result = response.data else {
                        return
                    }
                    let FoodContents = try JSONDecoder().decode(FoodContentList.self, from: result)
                    completion(FoodContents.contents)
                }catch{
                    print("parsing error")
                }
            case .failure(_):
                print("Data loading Error")
                break
        }
    }
}

func getPredictPrice(url : String, completion: @escaping(PredictFood) -> Void){
    let request =  AF.request(url).validate()
    request.responseJSON(queue : DispatchQueue.global(qos: .default)) { response in
        switch response.result {
            case .success:
                do {
                    
                    guard let result = response.data else {
                        return
                    }
                    let PredictPrice = try JSONDecoder().decode(PredictFood.self, from: result)
                    completion(PredictPrice)
                }catch{
                    print("parsing error")
                }
            case .failure(_):
                print("Data loading Error")
                break
        }
    }
}
