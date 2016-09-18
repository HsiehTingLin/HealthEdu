//
//  StarMany.swift
//  HealthEdu
//
//  Created by Mac on 2016/9/18.
//  Copyright © 2016年 NCKU_hospital. All rights reserved.
//

// cell identifier: StarCellFirst

import UIKit

class StarMany: UIViewController,UITableViewDelegate {
    
    var topicArray:[topic] = [topic]()

    @IBOutlet weak var StarTableViewIBO: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let topic1 = topic(topicTitle: "專題title1", topicPhoto: "Drug", topicAuthor: "你爸", topicBody: "這應該不會出現啦", topicTime: "2016-9-16", topicDivision: "外科")
        let topic2 = topic(topicTitle: "專題title2", topicPhoto: "Drug", topicAuthor: "你爸", topicBody: "這應該不會出現啦", topicTime: "2016-9-16", topicDivision: "外科")
        let topic3 = topic(topicTitle: "專題title3", topicPhoto: "Drug", topicAuthor: "你爸", topicBody: "這應該不會出現啦", topicTime: "2016-9-16", topicDivision: "外科")
        
      
        topicArray.append(topic1)
        topicArray.append(topic2)
        topicArray.append(topic3)

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
        return topicArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("StarCellFirst", forIndexPath: indexPath) as! myTopicsCell
        
        
        let
        topicItem = topicArray[indexPath.row]
        cell.topicPhotoIBO.image = UIImage(named: topicItem.topicPhoto)
        cell.topicTitleIBO.text = topicItem.topicTitle

        
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
