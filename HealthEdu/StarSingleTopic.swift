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
    var TopicMainPhotoString = ""
    var TopicMainTitleString = ""
    //佑儒，上面這個 TopicMainString變可能要跟資料庫連動，因為選擇不同的topic，要載入不同的tablearray
    
    // 上半部固定的圖文區塊~~End
    
    // TableView的變數們:
    
    @IBOutlet weak var ArticleInTopicTableView: UITableView!
    var articleArray:[article] = [article]() //跟在分科一樣
    // TableView的變數們~End
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TopicMainPhoto.image = UIImage(named: TopicMainPhotoString)
        TopicMainTitle.text = TopicMainTitleString
        
        // 下面是暫時建立的 array 假如topic名稱不一樣，要載入不同的array
        let article1 = article(title: "標題測試一", photo: "Diagnosis", author: "林協霆yeeee", body: "長長的內文長長的內文長長的內文長長的內文", time: "2016-09-13", division: "內科")
        let article2 = article(title: "標題測試二", photo:  "StemCell", author: "林協霆yeeee", body: "長長的內文長長的內文長長的內文長長的內文", time: "2016-09-13", division: "內科")
        let article3 = article(title: "標題測試三", photo: "Surgery", author: "林協霆yeeee", body: "長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文",time: "2016-09-13", division: "內科")
        articleArray.append(article1)
        articleArray.append(article2)
        articleArray.append(article3)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("articleCellinTopic", forIndexPath: indexPath) as! mySingleTopicCell
        // cell id 要換
        
        
        let articleItem = articleArray[indexPath.row]
        cell.singleTopicCellPhoto.image = UIImage(named: articleItem.photo)
        cell.singleTopicCellTitle.text = articleItem.title
        cell.singleTopicCellAuthor.text = articleItem.author
        cell.singleTopicCellBody.text = articleItem.body
        // cell 後面的屬性要看 mySingleTopicCell.swift這個文件
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let articleDetail = segue.destinationViewController as! ArticleViewController
        if let indexPath = ArticleInTopicTableView.indexPathForSelectedRow {
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
