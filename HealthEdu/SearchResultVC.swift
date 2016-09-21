//
//  SearchResultVC.swift
//  HealthEdu
//
//  Created by Mac on 2016/9/18.
//  Copyright © 2016年 NCKU_hospital. All rights reserved.
// 搜尋結果的 vc

import UIKit

class SearchResultVC: UITableViewController {
    var articleArray:[article] = [article]()
    
    // 不知道有沒有辦法把搜尋結果的title顯示在navigation bar上，像在分科裡面做的那樣
    override func viewDidLoad() {
        super.viewDidLoad()
        
  
        articleArray = SearchResultVCArticle.getArticle()

        
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
        let cell = tableView.dequeueReusableCellWithIdentifier("searchResultCell", forIndexPath: indexPath) as! SearchResultCell
        
        let articleItem = articleArray[indexPath.row]
        cell.searchResultCellPhoto.image = UIImage(named: articleItem.photo)
        cell.searchResultCellTitle.text = articleItem.title
        cell.searchResultCellAuthor.text = articleItem.author
        cell.searchResultCellBody.text = articleItem.body.stringByReplacingOccurrencesOfString("<[^>]+>", withString: "", options: .RegularExpressionSearch, range: nil)
        
        // 這裡的cell 後面的屬性也要再修正
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let articleDetail = segue.destinationViewController as! ArticleViewController
        if let indexPath = self.tableView.indexPathForSelectedRow {
            let articleSelected = articleArray[indexPath.row]
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
