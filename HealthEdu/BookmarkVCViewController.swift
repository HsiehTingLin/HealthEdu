//
//  BookmarkVCViewController.swift
//  HealthEdu
//
//  Created by Mac on 2016/9/17.
//  Copyright © 2016年 NCKU_hospital. All rights reserved.
//

import UIKit

class BookmarkVCViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    
    @IBOutlet weak var BookmarkSegControlIBO: UISegmentedControl!
    var articleArrayHistory:[article] = [article]()
    var articleArrayBookmark:[article] = [article]()

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 建立articleArrayHistory
        let articleHistory1 = article(title: "標題測試一紀錄喔", photo: "Diagnosis.jpg", author: "林協霆yeeee", body: "長長的內文長長的內文長長的內文長長的內文", time: "2016-09-13", division: "內科")
        let articleHistory2 = article(title: "標題測試二紀錄喔", photo:  "Diagnosis", author: "林協霆yeeee", body: "長長的內文長長的內文長長的內文長長的內文", time: "2016-09-13", division: "內科")
        let articleHistory3 = article(title: "標題測試三紀錄喔", photo: "Surgery", author: "林協霆yeeee", body: "長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文",time: "2016-09-13", division: "內科")
        articleArrayHistory.append(articleHistory1)
        articleArrayHistory.append(articleHistory2)
        articleArrayHistory.append(articleHistory3)
        
        // 建立 articleArrayBookmark
        let articleBookmark1 = article(title: "標題測試一收藏喔", photo: "Diagnosis.jpg", author: "林協霆yeeee", body: "長長的內文長長的內文長長的內文長長的內文", time: "2016-09-13", division: "內科")
        let articleBookmark2 = article(title: "標題測試二收藏喔", photo:  "Diagnosis", author: "林協霆yeeee", body: "長長的內文長長的內文長長的內文長長的內文", time: "2016-09-13", division: "內科")
        let articleBookmark3 = article(title: "標題測試三收藏喔", photo: "Surgery", author: "林協霆yeeee", body: "長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文",time: "2016-09-13", division: "內科")
        articleArrayBookmark.append(articleBookmark1)
        articleArrayBookmark.append(articleBookmark2)
        articleArrayBookmark.append(articleBookmark3)



        // Do any additional setup after loading the view.
    }
    
    // 不同Segm換鈕切換時的結果
    

    @IBAction func BookmarkSegControlAction(sender: AnyObject) {
        tableView.reloadData()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    // 不同array被選擇時，要回傳不同row的數量
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var returnRowCount = 0
        switch (BookmarkSegControlIBO.selectedSegmentIndex) {
        case 0:
            returnRowCount = articleArrayHistory.count
        case 1:
            returnRowCount = articleArrayBookmark.count
        default:
            break
        }
        
        
        return returnRowCount
    }
    
    // 不同的seg要傳回不同的cell值
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! myBookmarkCell
        
        switch (BookmarkSegControlIBO.selectedSegmentIndex) {
        case 0:
            let articleItem = articleArrayHistory[indexPath.row]
            cell.BookmarkImageViewCellIBO.image = UIImage(named: articleItem.photo)
            cell.BookmarkTitleIBO.text = articleItem.title
            cell.BookmarkAuthorIBO.text = articleItem.author
            cell.BookmarkBodyIBO.text = articleItem.body
            break
        case 1:
            let articleItem = articleArrayBookmark[indexPath.row]
            cell.BookmarkImageViewCellIBO.image = UIImage(named: articleItem.photo)
            cell.BookmarkTitleIBO.text = articleItem.title
            cell.BookmarkAuthorIBO.text = articleItem.author
            cell.BookmarkBodyIBO.text = articleItem.body
        default:
            break
        }
        return cell
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
