//
//  Connection.swift
//  HealthEdu
//
//  Created by Yu-Ju Lin on 2016/9/30.
//  Copyright © 2016年 NCKU_hospital. All rights reserved.
//

import Foundation


class Connection: NSObject, NSURLSessionDelegate{
    
    
    // postRequest - for all http request
    static func postRequest(requestUrl: String, postString: String, completionHandler: NSData -> Void){
        
        // variable for store temporary json data
        var jsonData: NSData?
        
        let request = NSMutableURLRequest(URL: NSURL(string: requestUrl)!)
        
        request.HTTPMethod = "POST"
        
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            (data, response, error) in
            
            // be sure that ther is no error
            // TODO: 需要做 throw exception!! 跳出視窗
            guard error == nil && data != nil else {
                // check for fundamental networking error
                print("error=\(error)")
                return
                
            }
            
            // if statusCode is not 200 OK, throw error
            // TODO: 需要做 throw exception!! 跳出視窗
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {
                // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
                
            } else {
                
                jsonData = data
                
                completionHandler(jsonData!)
                // 不能用 return 的方式回傳，因為 這是 Async 方式讀取資料
            }
            

            
        }
        task.resume()
    }
    
    
    
    
    // 這個 func 負責跟去 requestUrl 取得 json 資料回傳
    static func GetJson(requestUrl: String, completionHandler: NSData -> Void)
    {
        var jsonData: NSData?
        
        let path: String = requestUrl
        let url: NSURL = NSURL(string: path)!
        let request = NSMutableURLRequest(URL: url)
        let session: NSURLSession = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request, completionHandler: {
            (data, response, error) in
            
            let httpResponse = response as? NSHTTPURLResponse
            
            
            if httpResponse?.statusCode == 200 {
                
                jsonData = data
                
            }
            
            completionHandler(jsonData!)
            // 不能用 return 的方式回傳，因為 這是 Async 方式讀取資料
        })
        
        task.resume()
        
        
    }
    
    
    // 負責去下載 Image
    static func GetImage(requestUrl: String, completionHandler: NSData -> Void)
    {
        var imageData: NSData?
        
        let path: String = requestUrl
        let url: NSURL = NSURL(string: path)!
        let request = NSMutableURLRequest(URL: url)
        let session: NSURLSession = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request, completionHandler: {
            (data, response, error) in
            
            let httpResponse = response as? NSHTTPURLResponse
            
            if httpResponse?.statusCode == 200 {
                
                imageData = data
                
            }
            
            completionHandler(imageData!)
            // 不能用 return 的方式回傳，因為 這是 Async 方式讀取資料
        })
        
        task.resume()
        
    }
    
    // HTTPS
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didReceiveChallenge challenge: NSURLAuthenticationChallenge, completionHandler: (NSURLSessionAuthChallengeDisposition, NSURLCredential?) -> Void) {
        completionHandler(NSURLSessionAuthChallengeDisposition.UseCredential, NSURLCredential(forTrust: challenge.protectionSpace.serverTrust!))
    }
    
    
}

