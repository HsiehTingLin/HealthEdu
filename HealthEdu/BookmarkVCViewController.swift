//
//  BookmarkVCViewController.swift
//  HealthEdu
//
//  Created by Mac on 2016/9/17.
//  Copyright © 2016年 NCKU_hospital. All rights reserved.
//

import UIKit
import CoreData

class BookmarkVCViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    
    @IBOutlet weak var BookmarkSegControlIBO: UISegmentedControl!
    var articleArrayHistory:[article] = [article]()
    var articleArrayBookmark:[article] = [article]()

    @IBOutlet weak var tableView: UITableView!
    
    
    // 給 core data (讀取文章) 功能使用
    let core_data = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }
    
    // 不同Segm換鈕切換時的結果
    
    
    override func viewWillAppear(animated: Bool) {
        
        // 顯示瀏覽歷史
        self.showHistory()
        
        // 顯示書籤
        self.showBookmark()
        
        tableView.reloadData()
        
        
    }

    
    func showBookmark(){
        
        /* 讀取 Bookmark core data */
        //articleArrayBookmark = articleArrayBookmarkData.getArticle()
        articleArrayBookmark = []
        
        /* 讀取 Bookmark core data */
        let request = NSFetchRequest(entityName: "BookmarkEntities")
        
        do {
            
            let results = try self.core_data.executeFetchRequest(request) as! [BookmarkEntities]
            
            for result in results {
                
                articleArrayBookmark.append(article(id: result.id! ,title: result.title!, photoUIImage: UIImage() ,  photo: result.photo!, author: result.author!, body: result.body!, time: result.time! , division: result.division!))
            }
            
        }catch{
            fatalError("Failed to fetch data: \(error)")
        }
        
    }
    
    func showHistory(){
        
        /* 讀取 History core data */
        //articleArrayHistory = articleArrayHistoryData.getArticle()
        articleArrayBookmark = []
        
        /* 讀取 History core data */
        let request = NSFetchRequest(entityName: "HistoryEntities")
        
        do {
            
            let results = try self.core_data.executeFetchRequest(request) as! [HistoryEntities]
            
            for result in results {
                
                articleArrayHistory.append(article(id: result.id! ,title: result.title!, photoUIImage: UIImage() ,  photo: result.photo!, author: result.author!, body: result.body!, time: result.time! , division: result.division!))
            }
            
        }catch{
            fatalError("Failed to fetch data: \(error)")
        }
        
    }
    
    

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
            cell.BookmarkBodyIBO.text = articleItem.body.stringByReplacingOccurrencesOfString("<[^>]+>", withString: "", options: .RegularExpressionSearch, range: nil)
            break
        case 1:
            let articleItem = articleArrayBookmark[indexPath.row]
            cell.BookmarkImageViewCellIBO.image = UIImage(named: articleItem.photo)
            cell.BookmarkTitleIBO.text = articleItem.title
            cell.BookmarkAuthorIBO.text = articleItem.author
            cell.BookmarkBodyIBO.text = articleItem.body.stringByReplacingOccurrencesOfString("<[^>]+>", withString: "", options: .RegularExpressionSearch, range: nil)
        default:
            break
        }
        return cell
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let articleDetail = segue.destinationViewController as! ArticleViewController
        if let indexPath = self.tableView.indexPathForSelectedRow {
            // 因為有兩種情況，所弄了酪switch 我覺得這堆碼有夠醜Q
            switch (BookmarkSegControlIBO.selectedSegmentIndex) {
            case 0:
                let articleSelected = articleArrayHistory[indexPath.row]
                articleDetail.currentIdString = articleSelected.id
                articleDetail.currentTitleString = articleSelected.title
                articleDetail.currentBodyString = articleSelected.body
                articleDetail.currentAuthorString = articleSelected.author
                articleDetail.currentDivisionString = articleSelected.division
                articleDetail.currentPhotoString = articleSelected.photo
                articleDetail.currentTimeString = articleSelected.time
                break
            case 1:
                let articleSelected = articleArrayBookmark[indexPath.row]
                articleDetail.currentIdString = articleSelected.id
                articleDetail.currentTitleString = articleSelected.title
                articleDetail.currentBodyString = articleSelected.body
                articleDetail.currentAuthorString = articleSelected.author
                articleDetail.currentDivisionString = articleSelected.division
                articleDetail.currentPhotoString = articleSelected.photo
                articleDetail.currentTimeString = articleSelected.time
            default:
                break
            }
    
            
            
            
            // 這個func的作用:先把 articleArray中，被選中的資料，指定為 articleSelected這個變數(class是article )，然後將來自"ArticleViewController"的變數指定為articleDetail這個var(class 是ArticleViewController)，接著把articleSelected的每個變數都指定為articleDetail的各個對應的變數，類型都是String
            
            
        }
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
