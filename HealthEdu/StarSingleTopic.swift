//
//  StarSingleTopic.swift
//  HealthEdu
//
//  Created by Mac on 2016/9/18.
//  Copyright © 2016年 NCKU_hospital. All rights reserved.
// 點下去第二層單一topic的vc

import UIKit

class StarSingleTopic: UIViewController, UITableViewDataSource {

    // 上半部固定的圖文區塊:
    @IBOutlet weak var TopicMainPhoto: UIImageView!
    @IBOutlet weak var TopicMainTitle: UILabel!
    //上面這些是從VC連過來的outlet，因為他們屬性不同，不能直接來使用
    

    // 這裡新增這個 TopciMainIdString 為了接受來自 StarMany 的資訊告訴我是哪一個topic selected
    var TopicMainIdString = Int()

    
    var TopicMainPhotoString = ""
    var TopicMainTitleString = ""
    //佑儒，上面這個 TopicMainString變可能要跟資料庫連動，因為選擇不同的topic，要載入不同的tablearray
    
    // 上半部固定的圖文區塊~~End
    
    // TableView的變數們:
    
    @IBOutlet weak var ArticleInTopicTableView: UITableView!
    

    // 這個 topic_and_article_Array 負責裝所有topic 加上 article
    var topic_and_article_Array = [[article]]()
    // TableView的變數們~End
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TopicMainPhoto.image = UIImage(named: TopicMainPhotoString)
        TopicMainTitle.text = TopicMainTitleString.stringByReplacingOccurrencesOfString("<[^>]+>", withString: "", options: .RegularExpressionSearch, range: nil)
        
        
        topic_and_article_Array = StarSingleTopicArticle.getArticle()
        // 取得文章資料

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.topic_and_article_Array[self.TopicMainIdString-1].count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("articleCellinTopic", forIndexPath: indexPath) as! mySingleTopicCell
        // cell id 要換
        
        
        let articleItem = topic_and_article_Array[self.TopicMainIdString-1][indexPath.row]
        // 這是告訴標題每個 cell 要顯示什麼
        // self.TopicMainIdString-1 要減一的原因是因為主題是從 1 開始算，可是電腦array 從 0
        
        cell.singleTopicCellPhoto.image = UIImage(named: articleItem.photo)
        cell.singleTopicCellTitle.text = articleItem.title
        cell.singleTopicCellAuthor.text = articleItem.author
        cell.singleTopicCellBody.text = articleItem.body.stringByReplacingOccurrencesOfString("<[^>]+>", withString: "", options: .RegularExpressionSearch, range: nil)
        // cell 後面的屬性要看 mySingleTopicCell.swift這個文件
        
        return cell
    }
    
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
            
            
            // 這個func的作用:先把 articleArray中，被選中的資料，指定為 articleSelected這個變數(class是article )，然後將來自"ArticleViewController"的變數指定為articleDetail這個var(class 是ArticleViewController)，接著把articleSelected的每個變數都指定為articleDetail的各個對應的變數，類型都是String
            
            
        }
    }


}
