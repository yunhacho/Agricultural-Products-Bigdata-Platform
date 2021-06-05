//
//  webSocketWithStomp.swift
//  Jongp2
//
//  Created by junseok on 2021/06/05.
//
//

import Foundation

import StompClientLib

class webSocketWithStomp: StompClientLibDelegate{
    
    var socketClient = StompClientLib()
    var topic = "/sub/user"
    var app = "/pub/test" // 데이터 보낼때
    var url : NSURL!
    var type = "distance"
    //let baseURL = "39.112.118.107:8088/ws/websocket/"
    let baseURL = WasURL.ip+":"+WasURL.WebSocketPort+"/ws/websocket"
    var secondTabController : SecondTabController!
    
    init(){
        
    }
    
    // /topic을 구독하고, 해당 topic에 data가 들어오면 받아옴
    //data를 보낼때는 /app에 전송
    func registerSocket(viewcontroller : SecondTabController){
        //웹소켓 서버 주소, end point 주소
        if socketClient.isConnected(){
            socketClient.subscribe(destination: topic)
            print("다시 구독")
            return
        }else{
            print("재연결")
        }
        
        self.secondTabController = viewcontroller
        
        let completedWSURL = "ws://\(baseURL)"
        print(completedWSURL)
        url = NSURL(string: completedWSURL)!
        socketClient.openSocketWithURLRequest(request: NSURLRequest(url: url as URL) , delegate: self as StompClientLibDelegate)
        print("socket open request")
        
        
    }
    
    func sendData(data : String){
        
    let testData = "{\"mclassname\":\"새송이\",\"sclassname\":\"새송이 새송이 (일반)\",\"bidtime\":\"2021-06-05T08:02:00\",\"price\":4800,\"gradename\":\"특\",\"marketname\":\"부산엄궁도매\",\"coname\":\"항도청과\",\"sanji\":\"경남 진주시\",\"tradeamt\":24,\"unitname\":\"2kg 봉지 11개\"}"

        socketClient.sendMessage(message: testData, toDestination: app, withHeaders: nil, withReceipt: nil)
    }
    
    func disconnect(){
        socketClient.disconnect()
    }
    //연결 됐을 경우
    func stompClientDidConnect(client: StompClientLib!) {
        print("Socket is Connected : \(topic)")
        socketClient.subscribe(destination: topic)
        sendData(data : "")
    }
    
    func stompClientDidDisconnect(client: StompClientLib!) {
        print("Socket is Disconnected")
    }
    
    //jsonBody로 받음
    func stompClient(client: StompClientLib!, didReceiveMessageWithJSONBody jsonBody: AnyObject?, akaStringBody stringBody: String?, withHeader header: [String : String]?, withDestination destination: String) {
        print("DESTIONATION : \(destination)")
        print("JSON BODY : \(String(describing: jsonBody))")
        print("STRING BODY : \(stringBody ?? "nil")")
        parseBody(jsonBody: (String(describing: stringBody!)))
        
    }
    
    //받은 message를 string으로
    func stompClientJSONBody(client: StompClientLib!, didReceiveMessageWithJSONBody jsonBody: String?, withHeader header: [String : String]?, withDestination destination: String) {
        print("DESTIONATION : \(destination)")
        print("String JSON BODY : \(String(describing: jsonBody))")
    }
    
    func serverDidSendReceipt(client: StompClientLib!, withReceiptId receiptId: String) {
        print("Receipt : \(receiptId)")
    }
    
    func serverDidSendError(client: StompClientLib!, withErrorMessage description: String, detailedErrorMessage message: String?) {
        print("Error from Server : \(String(describing: message))")
        if(!socketClient.isConnected()){
            socketClient.reconnect(request: NSURLRequest(url: url as URL), delegate: self as StompClientLibDelegate)
        }
    }
    
    func serverDidSendPing() {
        print("Server Ping")
    }
    
    func unsubscribe(){
        print("Server unsubscribe")
        self.socketClient.unsubscribe(destination: topic)
    }
    
    func parseBody(jsonBody : String){
        do {
//            guard let data = jsonBody else{
//                print("No any Data")
//                return
//            }
//            print("tqtqtqtqtqtqtqtq")
            let test = "{ \"content\" : {\"mclassname\":\"테스트\",\"sclassname\":\"새송이 새송이 (일반)\",\"bidtime\":\"2021-06-05T08:02:00\",\"price\":4800,\"gradename\":\"특\",\"marketname\":\"부산엄궁도매\",\"coname\":\"항도청과\",\"sanji\":\"경남 진주시\",\"tradeamt\":24,\"unitname\":\"2kg 봉지 11개\"}}".data(using: .utf8)!
            let parsedData = try JSONDecoder().decode(StompAuctionFormat.self, from: test)
            print(parsedData)
            self.secondTabController.AuctionList.append(parsedData.content)
            self.secondTabController.FoodTableView.reloadData()
            let indexPath = IndexPath(row: self.secondTabController.AuctionList.count-1, section: 0)
            self.secondTabController.FoodTableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
        }catch{
            print("parsing error")
        }
        
    }
}
