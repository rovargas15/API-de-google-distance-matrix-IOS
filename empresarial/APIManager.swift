//  ViewController.swift
//  empresarial
//
//  Created by Rafael Vargas on 31/05/18.
//  Copyright © 2018 Rafael vargas. All rights reserved.
//

import UIKit
import SwiftyJSON

class APIManager: NSObject {
    let baseURL = "https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial"
    static let sharedInstance = APIManager()
  
    func get(endpoint:String,onSuccess: @escaping([String: Any]) -> Void, onFailure: @escaping(Error) -> Void){
        let url : String = baseURL + endpoint
        var request = URLRequest(url: URL(string:url )!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            if(error != nil){
                onFailure(error!)
            } else{
                do {
                    let json = try JSONSerialization.jsonObject(with: data!) as! [String: Any]
                    
                    onSuccess(json)
                } catch {
                   
                }
            }
        })
        task.resume()
    }
    
    func getArray(endpoint:String,onSuccess: @escaping(Dictionary<String, Any>) -> Void, onFailure: @escaping(Error) -> Void){
        let url : String = baseURL + endpoint
        var request = URLRequest(url: URL(string:url )!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            if(error != nil){
                onFailure(error!)
            } else{
                do {
                    let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, Any>
                    onSuccess(json)
                } catch let error {
                    print(error)
                }
            }
        })
        task.resume()
    }
    
}
