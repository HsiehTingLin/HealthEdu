//
//  Connection.swift
//  HealthEdu
//
//  Created by Yu-Ju Lin on 2016/9/16.
//  Copyright © 2016年 NCKU_hospital. All rights reserved.
//

import Foundation

//
//  HttpConnection.swift
//  NCKU_APP_TEST
//
//  Created by Yu-Ju Lin on 2016/8/7.
//  Copyright © 2016年 Yu-Ju Lin. All rights reserved.
//

import Foundation

class Connection: NSObject, NSURLSessionDelegate{
    

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
    
    // HTTPS
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didReceiveChallenge challenge: NSURLAuthenticationChallenge, completionHandler: (NSURLSessionAuthChallengeDisposition, NSURLCredential?) -> Void) {
        completionHandler(NSURLSessionAuthChallengeDisposition.UseCredential, NSURLCredential(forTrust: challenge.protectionSpace.serverTrust!))
    }
    
    
}

