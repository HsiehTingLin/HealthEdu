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
    var articleArray: [article] = []
    
    // contain the searchText
    var searchText: String?
    
    // activity indicator for loading search result from server
    var activityIndicator = UIActivityIndicatorView()
    
    
    // MARK:- Basic Func
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.title = "「\(searchText!)」"
        
        
        // build activityIndicator as WhiteLarge(change to blue later)
        self.activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        
        // change activityIndicator color to blue (default iOS blue)
        self.activityIndicator.color = UIColor.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0)
        
        // init activityIndicator Animating
        self.activityIndicator.startAnimating()
        
        
        // not to display UITableView separator style
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        // set activityIndicator as StarTableViewIDB's backgrousView
        self.tableView.backgroundView = self.activityIndicator
        
    
        // searchBar.text is the text user type in
        ListArticle.bySearchText(searchText!, completionHandler: {
            (articleArray) in

            
            // change UI inside main queue
            dispatch_async(dispatch_get_main_queue(), {
                
                // no matter how long it takes to download data from Server
                // the activityIndicator will animating from 3 seconds
                let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 3 * Int64(NSEC_PER_SEC))
                dispatch_after(time, dispatch_get_main_queue()) {
                    
                    // stop activity indicator animating
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.hidden = true
                    
                    // refer self.topicArray to starTopicArray (Array from Server)
                    self.articleArray = articleArray
                    
                    // show the line separator again
                    self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
                    
                    // reload StarTableViewIBO in animating style
                    UIView.transitionWithView(self.tableView, duration: 1.0, options: .TransitionCrossDissolve, animations: {self.tableView.reloadData()}, completion: nil)
                    
                    
                }
                
                
                
                
            })
            
            
            
        })
        
        


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
        
        // set each row's image the DefaultPhotoForArticle
        // prevent repeat image because of dequeueReusableCellWithIdentifire()
        cell.searchResultCellPhoto.image = nil
        
        // get article detail according to variable "indexPath.row"
        let articleItem = articleArray[indexPath.row]
        
        if articleItem.photoUIImage.size.width == 0.0 {
            
            // prove that photoUIImage has not been downloaded t
            cell.searchResultCellPhoto.imageFromServerURL(cell.searchResultCellPhoto, urlString: articleItem.photo, completionHandler: {
                (imageFromNet) in
                
                // here insert image From Net to topicArray.topicPhotoUIImage
                self.articleArray[indexPath.row].photoUIImage = imageFromNet
                
            })
            
        }else{
            
            cell.searchResultCellPhoto.image = self.articleArray[indexPath.row].photoUIImage
            
        }
        
        
        
        cell.searchResultCellTitle.text = articleItem.title
        
        cell.searchResultCellAuthor.text = articleItem.author
        
        cell.searchResultCellBody.text = articleItem.body.noHTMLtag
    
    
        
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
            articleDetail.currentPhotoUIImage = articleSelected.photoUIImage
            articleDetail.currentTimeString = articleSelected.time
            
            
            
        }
    }

}
