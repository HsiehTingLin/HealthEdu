//
//  DevisionOnlyVC.swift
//  HealthEdu
//
//  Created by Mac on 2016/9/11.
//  Copyright © 2016年 NCKU_hospital. All rights reserved.
//

import UIKit

class DevisionOnlyVC: UITableViewController {
    
    var articleArray:[article] = [article]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let article1 = article(title: "標題測試一", photo: "Diagnosis.jpg", author: "林協霆yeeee", body: "長長的內文長長的內文長長的內文長長的內文", time: "2016-09-13", division: "內科")
        let article2 = article(title: "標題測試二", photo:  "Diagnosis", author: "林協霆yeeee", body: "長長的內文長長的內文長長的內文長長的內文", time: "2016-09-13", division: "內科")
        let article3 = article(title: "標題測試三", photo: "Surgery", author: "林協霆yeeee", body: "長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文",time: "2016-09-13", division: "內科")
        articleArray.append(article1)
        articleArray.append(article2)
        articleArray.append(article3)
        
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleArray.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("articleCell", forIndexPath: indexPath) as! myArticleCell
        
        
        let articleItem = articleArray[indexPath.row]
        cell.myPhoto.image = UIImage(named: articleItem.photo)
        cell.title.text = articleItem.title
        cell.author.text = articleItem.author
        cell.body.text = articleItem.body
        
        return cell
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var articleDetail = segue.destinationViewController as! ArticleViewController
        if let indexPath = self.tableView.indexPathForSelectedRow {
            let articleSelected = articleArray[indexPath.row]
            articleDetail.currentTitleString = articleSelected.title
            articleDetail.currentBodyString = articleSelected.body
            articleDetail.currentAuthorString = articleSelected.author
            articleDetail.currentDivisionString = articleSelected.division
            articleDetail.currentPhotoString = articleSelected.photo
            articleDetail.currentTimeString = articleSelected.time
            
            
        // 這個func的作用:先把 articleArray中，被選中的資料，指定為 articleSelected這個變數(class是article )，然後將來自"ArticleViewController"的變數指定為articleDetail這個var(class 是ArticleViewController)，接著把articleSelected的每個變數都指定為articleDetail的各個對應的變數，類型都是String 
            
            // git version check again and again
            
            
        }
    }
    
 
    
    

  

}
