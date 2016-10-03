//
//  DomainsDivisions.swift
//  HealthEdu
//
//  Created by Yu-Ju Lin on 2016/10/3.
//  Copyright © 2016年 NCKU_hospital. All rights reserved.
//

import Foundation

class DomainsDivisions {
    
    /**
     get static domains and division from json file
     - returns: [domains?]
     */
    
    static func getDomains() -> [domain?] {
        
        var domains_divisions_hierarchy = [domain?]()
        
        if let path = NSBundle.mainBundle().pathForResource("Domains", ofType: "json")
        {
            if let jsonData = NSData(contentsOfFile: path)
            {
                if let jsonArray = Parse.parseJSONdata(jsonData){
                    
                    // 以下把每一個 array 原本item 抓出來，轉換成 DivisionStruct的樣子
                    for jsonItem in jsonArray {
                        
                        let newJsonItem = domain(id: jsonItem["id"] as! String?, domain: jsonItem["domain"]  as! String?, division_data: [division?]() )
                        
                        domains_divisions_hierarchy.append(newJsonItem)
                        
                        
                    }
                    
                    
                }else{
                    print("無法 parse Json 檔案，請移除重裝 APP")
                }
                
            }else{
                print("無法 parse Json 檔案，請移除重裝 APP")
            }
            
        }else{
            print("無法 parse Json 檔案，請移除重裝 APP")
        }
        
        
        return domains_divisions_hierarchy
        
    }
    
    
}