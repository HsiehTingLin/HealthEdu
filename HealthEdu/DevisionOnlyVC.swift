//
//  DevisionOnlyVC.swift
//  HealthEdu
//
//  Created by Mac on 2016/9/11.
//  Copyright © 2016年 NCKU_hospital. All rights reserved.
//

import UIKit

class DevisionOnlyVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var articleArray: [Article] = []
    
    @IBOutlet var tableView: UITableView!
    
    var selected_division_id: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Connection.GetJson("https://ncku.myelin.tk/json/division/"+selected_division_id!, completionHandler: self.OperateJson_And_AddToarticleArray)
    
        for a in self.articleArray{
            print(a.title)
        }
        
    }
    
    func OperateJson_And_AddToarticleArray(jsonData: NSData)
    {
        
        if let jsonArray = Parse.parseJSONdata(jsonData) {
            
            for a_article in jsonArray {
                
                let photoUrl: String = "http://webpage.hosp.ncku.edu.tw"+(a_article["img_src"]!![0] as! String)
                
                let new_article = Article(title: a_article["title"] as! String, photo: photoUrl, author: a_article["author"] as! String , body: a_article["content"] as! String)
                
                self.articleArray.append(new_article)

                
                
            }
            // 以下為把資料貼到 view 上
            dispatch_async(dispatch_get_main_queue(), {
                
                self.tableView.reloadData()
                // 一定要在這個 dispatch_async() 裡面change UI
                // Do not change UI from anything but the main thread, it is bound to make your application unstable, and crash unpredictably.
            })
            
            
        }
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articleArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("articleCell", forIndexPath: indexPath) as! myArticleCell
        
        print(self.articleArray[indexPath.row].title)
        //cell.myPhoto.image = UIImage(named: self.articleArray[indexPath.row].photo)
        cell.title.text = self.articleArray[indexPath.row].title
        cell.author.text = self.articleArray[indexPath.row].author
        cell.body.text = self.articleArray[indexPath.row].body
        
        return cell
    }

}
