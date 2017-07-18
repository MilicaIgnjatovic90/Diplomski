//
//  Proxy.swift
//  quazzApp
//
//  Created by Milica Ignjatovic on 8/30/16.
//  Copyright © 2016 Milica Ignjatović. All rights reserved.
//

import UIKit
let LOCAL_IP = "192.168.0.16"
enum typeOfAction {
    case Login
    case Register
    case retQue
    case postQue
}
typealias RequestLoaderCompletion = (data: NSData?, error: ErrorType?) -> Void
typealias RequestLoaderJsonCompletion = (json: AnyObject?, error: ErrorType?) -> Void

class Proxy: NSObject, NSURLSessionDataDelegate {
    func  authorize() {

    }
    
    var isAcepted = false;
    var ret = (false, [])
    
    func postToServerData(localIpGetScenario:NSString,params:NSDictionary, method: String, typeOfAct:typeOfAction)-> (Bool, NSArray){

        let url = NSURL (fileURLWithPath:localIpGetScenario as String);
        let request = NSMutableURLRequest (URL:url);
        request.HTTPMethod = method
        do {
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: NSJSONWritingOptions.PrettyPrinted)
        }
        catch {
            
        }
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration(), delegate: self, delegateQueue: nil)
        
        let dataTask = session.dataTaskWithRequest(request) { [weak self] (data, response, error) -> Void in
            
            if let response = response as? NSHTTPURLResponse {
                if !(200...299 ~= response.statusCode) {
                    print (response.statusCode)
                    return
                }else{
                   self!.ret = self!.processDataFromServer(data!, typeOfAct:typeOfAct)
                }
            }
            
        }
        dataTask.resume()
        return ret
    }
    
    func processDataFromServer(data:NSData, typeOfAct:typeOfAction) -> (Bool, NSArray){
        let type = typeOfAct
        switch type {
        case .retQue:
            do{
                let json = try NSJSONSerialization.JSONObjectWithData(data, options: [])
                return (false, json as! NSArray)
            }
            catch{
                
            }
        case .Login, .Register:
            do{
                let json = try NSJSONSerialization.JSONObjectWithData(data, options: [])
                return (json as! Bool, [])
            }
            catch{
                
            }
        case .postQue:
            return (false, [])
        }
        return (false, [])
    }
    
    func retQuestionFunc(data:NSData) -> (Bool, NSArray) {
        do{
            let json = try NSJSONSerialization.JSONObjectWithData(data, options: [])
            return (false, json as! NSArray)
        }
        catch{
          
        }
        return (false, [])
    }
    
    func loginFunc(username: String, password: String) -> Bool {
        let localIpGetScenario = NSString (format:"http://%@:8888/login",LOCAL_IP);
        let params = ["username": username, "password": password]
        let method = "POST"
        let ret = postToServerData(localIpGetScenario, params: params, method: method, typeOfAct: .Login)
        return ret.0
    }
    
    func registerFunc(username: String, password: String, email : String) -> Bool {
        let localIpGetScenario = NSString (format:"http://%@:8888/register",LOCAL_IP);
        let params = ["username": username, "password": password, "email": email]
        let method = "POST"
        let ret =  postToServerData(localIpGetScenario, params: params, method: method, typeOfAct: .Register)
        return ret.0
    }
    
    func returnQuestions()-> NSArray {
        let localIpGetScenario = NSString (format:"http://%@:8888/questions",LOCAL_IP);
        let params = ["username": ""]
        let method = "POST"
        let ret =  postToServerData(localIpGetScenario, params: params, method: method, typeOfAct: .retQue)
        return ret.1
    }
    
    func postQuestion(queston: NSString, answers: NSArray, corectAnswer:NSString, typeOfQuestion:NSInteger) {
        let localIpGetScenario = NSString (format:"http://%@:8888/questions",LOCAL_IP);
        let params = ["queston":queston, "answers": answers, "corectAnswer":corectAnswer, "typeOfQuestion": typeOfQuestion]
        let method = "GET"
        let _ = postToServerData(localIpGetScenario, params: params, method: method, typeOfAct: .postQue)
        
    }

}
