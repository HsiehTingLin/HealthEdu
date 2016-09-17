//
//  BookmarkVCViewController.swift
//  HealthEdu
//
//  Created by Mac on 2016/9/17.
//  Copyright © 2016年 NCKU_hospital. All rights reserved.
//

import UIKit

class BookmarkVCViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    
    var articleArray:[article] = [article]()

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let article1 = article(title: "標題測試一", photo: "Diagnosis.jpg", author: "林協霆yeeee", body: "長長的內文長長的內文長長的內文長長的內文", time: "2016-09-13", division: "內科")
        let article2 = article(title: "標題測試二", photo:  "Diagnosis", author: "林協霆yeeee", body: "長長的內文長長的內文長長的內文長長的內文", time: "2016-09-13", division: "內科")
        let article3 = article(title: "標題測試三", photo: "Surgery", author: "林協霆yeeee", body: "長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文",time: "2016-09-13", division: "內科")
        articleArray.append(article1)
        articleArray.append(article2)
        articleArray.append(article3)


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("articleCell", forIndexPath: indexPath) as! myArticleCell
        
        
        let articleItem = articleArray[indexPath.row]
        cell.myPhoto.image = UIImage(named: articleItem.photo)
        cell.title.text = articleItem.title
        cell.author.text = articleItem.author
        cell.body.text = articleItem.body
        
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
