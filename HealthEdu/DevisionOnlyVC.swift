//
//  DevisionOnlyVC.swift
//  HealthEdu
//
//  Created by Mac on 2016/9/11.
//  Copyright © 2016年 NCKU_hospital. All rights reserved.
//

import UIKit

class DevisionOnlyVC: UITableViewController {
    
    // MARK:- 變數宣告
    
    var articleArray:[article] = [article]()
    var sectionSelected: Int?
    var rowSelected: Int?
    
    // MARK:- 基本func
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.articleArray = DevisionOnlyVCArticle.getArticleArray(sectionSelected!,rowSelected: rowSelected!)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
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
        cell.body.text = articleItem.body.stringByReplacingOccurrencesOfString("<[^>]+>", withString: "", options: .RegularExpressionSearch, range: nil)
        
        return cell
    }
    
    // MARK:- prepareForSegue 的 func

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let articleDetail = segue.destinationViewController as! ArticleViewController
        if let indexPath = self.tableView.indexPathForSelectedRow {
            let articleSelected = articleArray[indexPath.row]
            
            articleDetail.currentIdString = articleSelected.id
            articleDetail.currentTitleString = articleSelected.title
            articleDetail.currentBodyString = articleSelected.body
            articleDetail.currentAuthorString = articleSelected.author
            articleDetail.currentDivisionString = articleSelected.division
            articleDetail.currentPhotoString = articleSelected.photo
            articleDetail.currentTimeString = articleSelected.time
            
            
        // 這個func的作用:先把 articleArray中，被選中的資料，指定為 articleSelected這個變數(class是article )，然後將來自"ArticleViewController"的變數指定為articleDetail這個var(class 是ArticleViewController)，接著把articleSelected的每個變數都指定為articleDetail的各個對應的變數，類型都是String
            
            
        }
    }
    
 
    
    

  

}
