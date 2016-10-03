//
//  StarSingleTopic.swift
//  After user click single topic, it will seque to this view controller.
//  HealthEdu
//
//  Created by Yu-Ju Lin, Hsieh-Ting Lin.
//  Copyright © 2016年 衛教成大. All rights reserved.

import UIKit

class StarSingleTopic: UIViewController, UITableViewDataSource {

    // the fix part at top
    @IBOutlet weak var TopicMainPhoto: UIImageView!
    @IBOutlet weak var TopicMainTitle: UILabel!

    // 這裡新增這個 TopciMainIdString 為了接受來自 StarMany 的資訊告訴我是哪一個topic selected
    var TopicMainIdString = Int()
    var TopicMainPhotoString = ""
    var TopicMainTitleString = ""
    
    // The variable in Table view
    
    @IBOutlet weak var ArticleInTopicTableView: UITableView!
    
    // 這個 topic_and_article_Array 負責裝所有topic 加上 article
    var topic_and_article_Array = [[article]]()
    // TableView的變數們~End
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TopicMainPhoto.image = UIImage(named: TopicMainPhotoString)
        TopicMainTitle.text = TopicMainTitleString
        
        topic_and_article_Array = StarSingleTopicArticle.getArticle()
        // 取得文章資料

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
        // MARK: - Table view data source
    
    /**
     Define how many section in table view
     - returns: 1:Int
     */
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    /**
     Define numberOfRowsInSection
     - returns: count of topic_and_article_Array
     */

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.topic_and_article_Array[self.TopicMainIdString-1].count
    }
    
    /**
     Define the cell.
     The cell Identifier in Storyboard is called articleCellinTopic
     - returns: cell
     */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // define the cell in file mySingleTopicCell.swift,and  the cell ID is called "articleCellinTopic" in Storyboard
        let cell = tableView.dequeueReusableCellWithIdentifier("articleCellinTopic", forIndexPath: indexPath) as! mySingleTopicCell
        
        let articleItem = topic_and_article_Array[self.TopicMainIdString-1][indexPath.row]
        // 這是告訴標題每個 cell 要顯示什麼
        // self.TopicMainIdString-1 要減一的原因是因為主題是從 1 開始算，可是電腦array 從 0
        
        cell.singleTopicCellPhoto.image = UIImage(named: articleItem.photo)
        cell.singleTopicCellTitle.text = articleItem.title
        cell.singleTopicCellAuthor.text = articleItem.author
        cell.singleTopicCellBody.text = articleItem.body.noHTMLtag
        // cell 後面的屬性要看 mySingleTopicCell.swift這個文件
        
        return cell
    }
    /**
     Prepare for segue. When users tap one topic in this viewController, we must prepare the selected data and pass them to next viewcontroller
     - returns: no return just link the file
     */
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let articleDetail = segue.destinationViewController as! ArticleViewController
        if let indexPath = ArticleInTopicTableView.indexPathForSelectedRow {
            let articleSelected = topic_and_article_Array[self.TopicMainIdString-1][indexPath.row]
            // 這是從 indexPath.row 中 找到到底是哪一篇文章被選到 傳遞到下一頁去
            // self.TopicMainIdString-1 要減一的原因是因為主題是從 1 開始算，可是電腦array 從 0
            
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
