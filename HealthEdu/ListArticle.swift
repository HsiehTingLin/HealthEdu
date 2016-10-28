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
    static func byDivisionId(divisionId: String, excludeIds: Array<String>, completionHandler: Array<article> -> Void){
        
        // TODO: excludeIds 在此轉成字串
        
        
        // pass rowSelected to Connection Post
        Connection.postRequest("http://ncku.medcode.in/json/listByDivisionId", postString: "", completionHandler: {
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
    static func byStarTopic(starTopicId: String, completionHandler: Array<article> -> Void){
        
        let strToPost = "StarTopicId=\(starTopicId)"
        
        
        
        
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
    
    
    /*
    func OperateJson_And_AddToarticleArray(jsonData: NSData)
    {
        
        if let jsonArray = Parse.parseJSONdata(jsonData) {
            
            
            for a_article in jsonArray {
                
                ////////////////////////////////////////////////////////////
                /////////這裡應該要判斷是否該文章有image，若無，則採用預設/////////
                ////////////////////////////////////////////////////////////
                let photoUrl: String = "http://webpage.hosp.ncku.edu.tw/Portals/0/Issue14/6.jpg"
                
                
                // 取得圖片
                
                
                // 現在用假圖片，到時候要用類似下面這種方式 但是還要加上判斷
                // let photoUrl: String = "http://webpage.hosp.ncku.edu.tw"+(a_article["img_src"]!![0] as! String)
                
                
                Connection.GetImage(photoUrl, completionHandler: {
                    (Imagedata) in
                    
                    
                    self.image = UIImage(data: Imagedata)!
                    // 把 data 轉換成 UIImage
                    
                    let new_article = Article(title: a_article["title"] as! String, photo: self.image!, author: a_article["author"] as! String , body: a_article["content"] as! String)
                    
                    self.articleArray.append(new_article)
                    
                    
                    
                    // 以下為把資料貼到 view 上
                    dispatch_async(dispatch_get_main_queue(), {
                        
                        self.tableView.reloadData()
                        
                        // 一定要在這個 dispatch_async() 裡面change UI
                        // Do not change UI from anything but the main thread, it is bound to make your application unstable, and crash unpredictably.
                    })
                    
                })
                
                
                
            }
            
            
        }
        
    }*/
}
