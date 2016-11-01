//
//  listArticle.swift
//  HealthEdu
//
//  Created by Yu-Ju Lin on 2016/10/25.
//  Copyright © 2016年 NCKU_hospital. All rights reserved.
//

import Foundation

import UIKit


class ListArticle{
    
    /**
        this func is used by showing articles belong to specific division id
     
        - returns: no resturn
        - completionHandler(Array<article> -> Void) return article array here
     */
    static func byDivisionId(divisionId: String, limitCount: Int, excludeIds: [String], completionHandler: [article] -> Void){
        
        var excludeArray: [String]
        
        // joing all articles id which will be excluded
        // joinedExcludeIds will not be null
        if excludeIds != [] {
            
            // be sure that excludeIds is not []
            excludeArray = excludeIds
            
        }else{
            
            // if excludeIds is accidentally [], apply ["0"] to it for now
            excludeArray = ["0"]
            
        }

        let joinedExcludeIds: String = excludeArray.joinWithSeparator("_")
        
        // generate string to post
        let strToPost = "divisionId=\(divisionId)&limitCount=\(limitCount)&excludeIds=\(joinedExcludeIds)"
        
        // pass rowSelected to Connection Post
        Connection.postRequest("https://ncku.medcode.in/json/listByDivisionId", postString: strToPost, completionHandler: {
            (data) in
            
            
            if let jsonArray = Parse.parseJSONdata(data) {
                
                var articleArray: [article] = []
                
                for a_article in jsonArray {
    
                    let new_article = article(
                        id: a_article["id"] as! String,
                        title: a_article["title"] as! String,
                        photoUIImage: UIImage(),
                        photo: a_article["photo"] as! String,
                        author: a_article["author"] as! String,
                        body: a_article["content"] as! String,
                        time: a_article["update_time"] as! String,
                        division: a_article["division"] as! String)

                    articleArray.append(new_article)

                    
                }
                
                completionHandler(articleArray)
                
            }
            
                    
                    

        })
        
        

    }
    
    
    
    /**
     this func is used by showing articles belong to specific division id
     
     - returns: no resturn
     - completionHandler(Array<article> -> Void) return article array here
     */
    static func byStarTopic(starTopicId: String, completionHandler: Array<article> -> Void){
        
        let strToPost = "starTopicId=\(starTopicId)"
        
        
        
        
        // pass rowSelected to Connection Post
        Connection.postRequest("https://ncku.medcode.in/json/listByStarTopic", postString: strToPost, completionHandler: {
            (data) in
            
            
            if let jsonArray = Parse.parseJSONdata(data) {
                
                var articleArray: [article] = []
                
                for a_article in jsonArray {
                    
                    let new_article = article(id: a_article["id"] as! String, title: a_article["title"] as! String, photoUIImage: UIImage(), photo: a_article["photo"] as! String, author: a_article["author"] as! String, body: a_article["content"] as! String, time: a_article["update_time"] as! String, division: a_article["division"] as! String)
                    
                    articleArray.append(new_article)
                    
                    
                }
                
                completionHandler(articleArray)
                
            }
            
            
            
            
        })
        
        
        
    }
    
    /**
     this func is used by showing articles belong to specific division id
     
     - returns: no resturn
     - completionHandler(Array<article> -> Void) return article array here
     */
    static func bySearchText(searchText: String, completionHandler: [article] -> Void){
        
        let strToPost = "searchText=\(searchText)"
        

        // pass rowSelected to Connection Post
        Connection.postRequest("https://ncku.medcode.in/json/listBySearchText", postString: strToPost, completionHandler: {
            (data) in
            
            
            if let jsonArray = Parse.parseJSONdata(data) {
                
                var articleArray: [article] = []
                
                for a_article in jsonArray {
                    
                    let new_article = article(
                        id: a_article["id"] as! String,
                        title: a_article["title"] as! String,
                        photoUIImage: UIImage(),
                        photo: a_article["photo"] as! String,
                        author: a_article["author"] as! String,
                        body: a_article["content"] as! String,
                        time: a_article["update_time"] as! String,
                        division: a_article["division"] as! String)
                    
                    articleArray.append(new_article)
                    
                    
                }
                
                completionHandler(articleArray)
                
            }
            
            
            
            
        })
        
        
        
    }

    
 }