//
//  DevisionOnlyVC.swift
//  HealthEdu
//
//  Created by Mac on 2016/9/11.
//  Copyright © 2016年 NCKU_hospital. All rights reserved.
//

import UIKit

class DevisionOnlyVC: UITableViewController {
    
    
    @IBOutlet var DivisionOnlyVCTableView: UITableView!
    
    
    // MARK:- Variable Declaration
    var articleArray: [article] = []

    // contain division specific id selected from DevisionOnlyVC
    var divisionIdSelected: String?
    
    // contain already download articles' ids
    var excludeIdsArray: [String] = []
    
    // init activityindicator
    var activityIndicator = UIActivityIndicatorView()
    
    // MARK:- Basic Func
    override func viewDidLoad() {

        super.viewDidLoad()
        print("Division Id Selected：\(divisionIdSelected)")
    
        
        // build activityIndicator as WhiteLarge(change to blue later)
        self.activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        
        // change activityIndicator color to blue (default iOS blue)
        self.activityIndicator.color = UIColor.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0)
        
        // init activityIndicator Animating
        self.activityIndicator.startAnimating()
        
        // not to display UITableView separator style
        self.DivisionOnlyVCTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        // set activityIndicator as StarTableViewIDB's backgrousView
        self.DivisionOnlyVCTableView.backgroundView = self.activityIndicator
        
        
        // TODO: 未來新增不要一次下載全部文章的 excludeIdsArray 功能
        self.excludeIdsArray = []
        
        ListArticle.byDivisionId(divisionIdSelected!, excludeIds: self.excludeIdsArray, completionHandler: {
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
                    self.DivisionOnlyVCTableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
                    
                    // reload StarTableViewIBO in animating style
                    UIView.transitionWithView(self.DivisionOnlyVCTableView, duration: 1.0, options: .TransitionCrossDissolve, animations: {self.DivisionOnlyVCTableView.reloadData()}, completion: nil)
                    
                    
                }
                
                
                
                
            })

            
            
        })

        
    }



    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleArray.count
    }
    
    
    
    // TODO: 要把 image 功能調整一下 不然每次都要執行下載
    // 已經可以做到部會每次下載，請把它改好看，並且加到 StarMany StarSingleTopic那邊
    // 不是！ 看這個 http://stackoverflow.com/a/39803061
    // 已知 tableView 每次碰到畫面會執行一次該 cell 的程式碼
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("articleCell", forIndexPath: indexPath) as! myArticleCell
        
        
        let articleItem = articleArray[indexPath.row]
        
        
        if articleItem.photoUIImage.size.width == 0.0 {
            // prove that photoUIImage has not been downloaded t
            cell.myPhoto.imageFromServerURL(cell.myPhoto, urlString: articleItem.photo, completionHandler: {
                    (imageFromNet) in
            
                // here insert image From Net to topicArray.topicPhotoUIImage
                self.articleArray[indexPath.row].photoUIImage = imageFromNet
            
            })

        }else{
            cell.myPhoto.image = self.articleArray[indexPath.row].photoUIImage
        }

        cell.title.text = articleItem.title
        cell.author.text = articleItem.author
        cell.body.text = articleItem.body.noHTMLtag
        
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
