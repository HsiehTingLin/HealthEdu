//
//  DevisionOnlyVC.swift
//  HealthEdu
//
//  Created by Mac on 2016/9/11.
//  Copyright © 2016年 NCKU_hospital. All rights reserved.
//

import UIKit

class DevisionOnlyVC: UITableViewController {
    
    var articleArray:[article] = [article]()
    
    var test_segue: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let article1 = article(title: self.test_segue!, photo: "Diagnosis.jpg", author: "林協霆yeeee", body: "長長的內文長長的內文長長的內文長長的內文")
        let article2 = article(title: self.test_segue!, photo:  "Diagnosis.jpg", author: "林協霆yeeee", body: "長長的內文長長的內文長長的內文長長的內文")
        let article3 = article(title: self.test_segue!, photo: "adult-stem-cell-cloning-670-1.jpg", author: "林協霆yeeee", body: "長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文長長的內文")
        articleArray.append(article1)
        articleArray.append(article2)
        articleArray.append(article3)
        
        
        
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
        let cell = tableView.dequeueReusableCellWithIdentifier("articleCell", forIndexPath: indexPath) as! myArticleCell
        
        
        var articleItem = articleArray[indexPath.row]
        cell.myPhoto.image = UIImage(named: articleItem.photo)
        cell.title.text = articleItem.title
        cell.author.text = articleItem.author
        cell.body.text = articleItem.body
        
        return cell
    }

}
