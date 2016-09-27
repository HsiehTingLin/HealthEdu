//
//  SearchResultVC.swift
//  ViewController for showing search result
//
//  HealthEdu
//
//  Created by Mac on 2016/9/18.
//  Copyright © 2016年 NCKU_hospital. All rights reserved.
// 

import UIKit

class SearchResultVC: UITableViewController {
    
    // MARK:- Variable Declaration
    
    // the class of "article" is defined in file ArticleClass.swift
    var articleArray:[article] = [article]()
    
    
    // MARK:- Basic Func
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // get Articles Data from SearchResultVCArticle
        articleArray = SearchResultVCArticle.getArticle()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK:- Func for table view
    
    
    /**
     Define How many section in this table view
     - return: Int for number of section
    */
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    /**
     Define how many rows are there in each section
     since we have only one section in this table (offline data for now)
     there is no need to combine the variable "section" in this func
     
     - return: Int Simply return articleArray.count
     
     */
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleArray.count
    }
    
    
    /**
     Define what to show in each row
     
     - return: UITableViewCell (photo, title, author, body)
     
     */
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Define each structure as SearchResultCell
        let cell = tableView.dequeueReusableCellWithIdentifier("searchResultCell", forIndexPath: indexPath) as! SearchResultCell
        
        // get article detail according to variable "indexPath.row"
        let articleItem = articleArray[indexPath.row]
        
        // Put articleItem content into cell (photo, title, author, body)
        cell.searchResultCellPhoto.image = UIImage(named: articleItem.photo)
        
        cell.searchResultCellTitle.text = articleItem.title
        
        cell.searchResultCellAuthor.text = articleItem.author
        
        cell.searchResultCellBody.text = articleItem.body.stringByReplacingOccurrencesOfString("<[^>]+>", withString: "", options: .RegularExpressionSearch, range: nil)
        
        // "stringByReaplcingOccurencesOfString" is for delete html tag
        
        
    
        
        return cell
    }
    
    
    // MARK:- For change view to ArticleViewController (show each article in detail)
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // Define destination
        let articleDetail = segue.destinationViewController as! ArticleViewController
        
        // get the indexPath of Selected table row
        if let indexPath = self.tableView.indexPathForSelectedRow {
            
            // get article detail according to variable selected "indexPath.row"
            let articleSelected = articleArray[indexPath.row]
            
            // Put article content to variable at ArticleViewController
            articleDetail.currentIdString = articleSelected.id
            articleDetail.currentTitleString = articleSelected.title
            articleDetail.currentBodyString = articleSelected.body
            articleDetail.currentAuthorString = articleSelected.author
            articleDetail.currentDivisionString = articleSelected.division
            articleDetail.currentPhotoString = articleSelected.photo
            articleDetail.currentTimeString = articleSelected.time
            
            
            
        }
    }

}
