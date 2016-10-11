//
//  Parse.swift
//  HealthEdu
//
//  Created by Yu-Ju Lin on 2016/9/30.
//  Copyright © 2016年 NCKU_hospital. All rights reserved.
//

import Foundation

// Custom Error
enum ParseError: ErrorType {
    case CanNotParseJSONfile
}

// Parse Main Class
class Parse{
    
    static func fromJSONfile(filename: String?) throws -> NSArray {
        
        var jsonArray = NSArray()
        
        if let path = NSBundle.mainBundle().pathForResource(filename, ofType: "json")
        {
            if let jsonData = NSData(contentsOfFile: path)
            {
                if let result = Parse.parseJSONdata(jsonData){
                    
                    // put the result into jsonArray
                    jsonArray = result

                }else{
                    
                    throw ParseError.CanNotParseJSONfile
                    
                }
                
            }else{
                
                throw ParseError.CanNotParseJSONfile
                
            }
            
        }else{
            throw ParseError.CanNotParseJSONfile
        }
 
        return jsonArray
        
    }
    
    
    
    static func parseJSONdata(jsonData: NSData?) -> NSArray? {
        
        do {
            let jsonArray = try NSJSONSerialization.JSONObjectWithData(jsonData!, options: NSJSONReadingOptions.MutableContainers) as? NSArray
            // 暫時先把東西轉換成 array 以後應該是要用 Dictionary
            
            return jsonArray
            
        } catch let error as NSError {
            print("error processing json data: \(error.localizedDescription)")
        }
        
        return nil
        
    }
    
}