//
//  Proxy.swift
//  quazzApp
//
//  Created by Milica Ignjatovic on 8/30/16.
//  Copyright © 2016 Milica Ignjatović. All rights reserved.
//

import UIKit
let LOCAL_IP = "192.168.0.10"
enum typeOfAction {
    case login
    case register
    case retQue
    case postQue
    case score
}
typealias RequestLoaderCompletion = (_ data: Data?, _ error: Error?) -> Void
typealias RequestLoaderJsonCompletion = (_ json: AnyObject?, _ error: Error?) -> Void


class Proxy: NSObject, URLSessionDataDelegate {
    var questions : [StructQuestion] = Array()

    func  authorize() {

    }
    
    var isAcepted = false;
    var ret = ("", NSDictionary())
    
    func postToServerData(_ localIpGetScenario:String,params:NSDictionary, method: String, typeOfAct:typeOfAction)-> (String, NSDictionary){

        let url = URL(string:localIpGetScenario);
        let request = NSMutableURLRequest (url:url!);
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = method

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions.prettyPrinted)
        }
        catch {
            
        }
        
        _ = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: nil)
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            if let httpResponse = response as? HTTPURLResponse {
                if (httpResponse.statusCode > 199 && httpResponse.statusCode < 300 ){
                    self.ret = self.processDataFromServer(data!, typeOfAct:typeOfAct)
                }
                else{
                    print ("status code is:", httpResponse.statusCode)
                }
            }
        }
        
        task.resume()
        return ret
    }
    
    func processDataFromServer(_ data:Data, typeOfAct:typeOfAction) -> (String, NSDictionary){
        let type = typeOfAct
        switch type {
        case .login, .register, .score:
            
            do{
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                let responseFromServer: String = (json as AnyObject).object(forKey: "val") as! String
                return (responseFromServer, [:])
            }
            catch{
                
            }
            
        case .postQue:
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                let responseFromServer: String = (json as AnyObject).object(forKey: "val") as! String
                return (responseFromServer, [:])
            }
            catch{
            
            }
        default:
            break
        }
        return ("", [:])
    }
    
    func retQuestionFunc(_ data:Data) -> (Bool, NSArray) {
        do{
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            return (false, json as! NSArray)
        }
        catch{
          
        }
        return (false, [])
    }
    
    func loginFunc(_ username: String, password: String) -> String {
        let localIpGetScenario = String (format:"http://%@:8888/login/",LOCAL_IP);
        let params = ["username": username, "password": password]
        let method = "POST"
        let ret = postToServerData(localIpGetScenario, params: params as NSDictionary, method: method, typeOfAct: .login)
        return ret.0
    }
    
    func registerFunc(_ username: String, password: String, email : String) -> String {
        let localIpGetScenario = String (format:"http://%@:8888/registre/",LOCAL_IP);
        let params = ["username": username, "password": password, "email": email]
        let method = "POST"
        let ret =  postToServerData(localIpGetScenario, params: params as NSDictionary, method: method, typeOfAct: .register)
        return ret.0
    }
    
    func returnQuestions()-> NSDictionary {
        let localIpGetScenario = String (format:"http://%@:8888/getQuestions/",LOCAL_IP);
        let params = ["username": ""]
        let method = "POST"
        let ret =  postToServerData(localIpGetScenario, params: params as NSDictionary, method: method, typeOfAct: .retQue)
        return ret.1
    }
    
    func postQuestion(_ queston: NSString, answers: String, corectAnswer:NSString, typeOfQuestion:NSInteger) -> String {
        let localIpGetScenario = String (format:"http://%@:8888/questions/",LOCAL_IP);
        let params = ["queston":queston, "answers": answers, "corectAnswer":corectAnswer, "typeOfQuestion": typeOfQuestion] as [String : Any]
        let method = "POST"
        let ret = postToServerData(localIpGetScenario, params: params as NSDictionary, method: method, typeOfAct: .postQue)
        return ret.0
    }
    
    func scoreFunc(_ username: String, password: String) -> String {
        let localIpGetScenario = String (format:"http://%@:8888/score/",LOCAL_IP);
        let params = ["username": username, "password": password]
        let method = "GET"
        let ret =  postToServerData(localIpGetScenario, params: params as NSDictionary, method: method, typeOfAct: .score)
        return ret.0
    }

    func postScoreFunc(_ username: String, score: String) -> String {
        let localIpGetScenario = String (format:"http://%@:8888/score/",LOCAL_IP);
        let params = ["username": username, "score": score]
        let method = "POST"
        let ret =  postToServerData(localIpGetScenario, params: params as NSDictionary, method: method, typeOfAct: .score)
        return ret.0
    }

}
