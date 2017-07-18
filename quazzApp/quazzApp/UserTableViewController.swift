//
//  UserTableViewController.swift
//  quazzApp
//
//  Created by Milica Ignjatovic on 9/3/16.
//  Copyright © 2016 Milica Ignjatović. All rights reserved.
//

import UIKit

struct StructQuestion{
    var type = 0.0
    var que = String()
    var offAnswer: [String] = Array()
    var correctAnsver = String ()
}


class UserTableViewController:UIViewController, UITableViewDelegate, UITableViewDataSource, URLSessionDataDelegate {

    var questions : [StructQuestion] = Array()
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Score.finalScore = 0
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.delegate = self
        tableView.dataSource = self
    }
    
     var username: String = ""
    
    func tableView (_ tableView:UITableView, heightForRowAt indexPath:IndexPath) -> CGFloat
    {
        
        return 200.0;
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.postToServerData()

    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func parsingQue (getQuestions:NSDictionary){
        var structQuestion : StructQuestion = StructQuestion()
        let dict = getQuestions.allValues
        let arrayQuestions = dict[0] as! NSDictionary
        for element in arrayQuestions {
            let unparsedValueArray = element.value as! NSArray
            let unparsedValue = unparsedValueArray[0] as! NSArray
           // let unparsedValue = unparsedValueDist.allValues
            structQuestion.type = (unparsedValue[4] as! NSString).doubleValue
            structQuestion.que = unparsedValue [1] as! String
            structQuestion.correctAnsver = unparsedValue [3] as! String
            let str = unparsedValue [2] as! String
            structQuestion.offAnswer = str.components(separatedBy: ",")
            self.questions.append(structQuestion)
        }
    }

    func postToServerData(){
        let localIpGetScenario = String (format:"http://192.168.0.10:8888/getQuestions/");
        let params = ["username": ""]
        let method = "POST"
        let url = NSURL(string:localIpGetScenario);
        let request = NSMutableURLRequest (url:url! as URL);
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = method
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions.prettyPrinted)
        }
        catch {
            
        }
        
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: nil)
        
       
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if let httpResponse = response as? HTTPURLResponse {
                if (httpResponse.statusCode > 199 && httpResponse.statusCode < 300 ){
                    if let data = data {
                        do {
                            let json = try JSONSerialization.jsonObject(with: data, options: [])
//                            let metVal = (json as AnyObject).object
//                            let responseFromServer: NSDictionary = (metVal as? NSDictionary)!
                            self.parsingQue (getQuestions: json as! NSDictionary)
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }


                        } catch let error as NSError {
                            print(error.localizedDescription)
                        }
                    }
                }
                else{
                    print ("status code is:", httpResponse.statusCode)
                }
            }
        })
        
        task.resume()
    }
    
    @IBAction func finishButton(_ sender: UIButton) {
          _ = ProxyInterface.sharedInstance.postScoreFunc(username, score: String( Score.finalScore))
    }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)-> UITableViewCell {
        if (self.questions.count > 0){
            if indexPath.row == 0  {
                switch self.questions[indexPath.row].type {
                case _ where self.questions[indexPath.row].type == 1.0 :
                    let cell = self.tableView.dequeueReusableCell(withIdentifier: "enterTableViewCell", for: indexPath as IndexPath) as! EnterTableViewCell
                    cell.title.text = self.questions[indexPath.row].que
                    cell.correctAns = self.questions[indexPath.row].correctAnsver
                    return cell
                case _ where self.questions[indexPath.row].type == 2.0:
                    let cell = self.tableView.dequeueReusableCell(withIdentifier: "checkTextCell", for: indexPath as IndexPath) as! CheckTableViewCell
                    cell.question.text = questions[indexPath.row].que
                    let oof = questions[indexPath.row]
                    cell.firstLabel.text = oof.offAnswer[0]
                    cell.secondLabel.text = oof.offAnswer[1]
                    cell.thirdLabel.text = oof.offAnswer[2]
                    cell.correctAns = questions[indexPath.row].correctAnsver
                    return cell
                case _ where self.questions[indexPath.row].type == 3.0:
                    let cell = self.tableView.dequeueReusableCell(withIdentifier: "dateTextCell", for: indexPath as IndexPath) as! dateCellTableViewCell
                    cell.question.text = self.questions[indexPath.row].que
                    cell.correctAns = self.questions[indexPath.row].correctAnsver
                    return cell
                default :
                    let cell = self.tableView.dequeueReusableCell(withIdentifier: "logFinish", for: indexPath as IndexPath)
                return cell
                }
            }
            else if indexPath.row == 1{
                switch self.questions[indexPath.row].type {
                case _ where self.questions[indexPath.row].type == 1.0 :
                    let cell = self.tableView.dequeueReusableCell(withIdentifier: "enterTableViewCell", for: indexPath as IndexPath) as! EnterTableViewCell
                    cell.title.text = self.questions[indexPath.row].que
                    cell.correctAns = self.questions[indexPath.row].correctAnsver
                    return cell
                case _ where self.questions[indexPath.row].type == 2.0:
                    let cell = self.tableView.dequeueReusableCell(withIdentifier: "checkTextCell", for: indexPath as IndexPath) as! CheckTableViewCell
                    cell.question.text = questions[indexPath.row].que
                    let oof = questions[indexPath.row]
                    cell.firstLabel.text = oof.offAnswer[0]
                    cell.secondLabel.text = oof.offAnswer[1]
                    cell.thirdLabel.text = oof.offAnswer[2]
                    cell.correctAns = questions[indexPath.row].correctAnsver
                    return cell
                case _ where self.questions[indexPath.row].type == 3.0:
                    let cell = self.tableView.dequeueReusableCell(withIdentifier: "dateTextCell", for: indexPath as IndexPath) as! dateCellTableViewCell
                    cell.question.text = self.questions[indexPath.row].que
                    cell.correctAns = self.questions[indexPath.row].correctAnsver
                    return cell
                default :
                    let cell = self.tableView.dequeueReusableCell(withIdentifier: "logFinish", for: indexPath as IndexPath)
                    return cell
                }
            }
            else if indexPath.row == 2{
                switch self.questions[indexPath.row].type {
                case _ where self.questions[indexPath.row].type == 1.0 :
                    let cell = self.tableView.dequeueReusableCell(withIdentifier: "enterTableViewCell", for: indexPath as IndexPath) as! EnterTableViewCell
                    cell.title.text = self.questions[indexPath.row].que
                    cell.correctAns = self.questions[indexPath.row].correctAnsver
                    return cell
                case _ where self.questions[indexPath.row].type == 2.0:
                    let cell = self.tableView.dequeueReusableCell(withIdentifier: "checkTextCell", for: indexPath as IndexPath) as! CheckTableViewCell
                    cell.question.text = questions[indexPath.row].que
                    let oof = questions[indexPath.row]
                    cell.firstLabel.text = oof.offAnswer[0]
                    cell.secondLabel.text = oof.offAnswer[1]
                    cell.thirdLabel.text = oof.offAnswer[2]
                    cell.correctAns = questions[indexPath.row].correctAnsver
                    return cell
                case _ where self.questions[indexPath.row].type == 3.0:
                    let cell = self.tableView.dequeueReusableCell(withIdentifier: "dateTextCell", for: indexPath as IndexPath) as! dateCellTableViewCell
                    cell.question.text = self.questions[indexPath.row].que
                    cell.correctAns = self.questions[indexPath.row].correctAnsver
                    return cell
                default :
                    let cell = self.tableView.dequeueReusableCell(withIdentifier: "logFinish", for: indexPath as IndexPath)
                    return cell
                }
            }
            else{
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "logFinish", for: indexPath as IndexPath)
                return cell
            }
        }
        else{
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "logFinish", for: indexPath as IndexPath)
        return cell
        }
    }
    
    
    
}
