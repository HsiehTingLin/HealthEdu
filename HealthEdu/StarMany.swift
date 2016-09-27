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
    
    // 注意，topic的class跟article不一樣，topic的class定義在 TopicClass.swift這個文件裡
    
    var topicArray:[topic] = [topic]()

    @IBOutlet weak var StarTableViewIBO: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.topicArray = StarManyTopic.getTopicArray()
     
        
        // End of topicArray
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
        // 定義要return 的 cell
        let cell = tableView.dequeueReusableCellWithIdentifier("starCellFirst", forIndexPath: indexPath) as! myTopicsCell
        // 對於 cell的一些詳細規範定義在 myTopicsCell.swift這個文件裡
        
        let
        topicItem = topicArray[indexPath.row]
        // 雖然topic 有蠻多變數的，但在storyboard中的cell上只有topicTitle跟topicPhoto這兩個outlet
        cell.topicPhotoIBO.image = UIImage(named: topicItem.topicPhoto)
        cell.topicTitleIBO.text = topicItem.topicTitle
        cell.opacityhalf.image = UIImage(named: "opacityhalf")

        
        return cell
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let topicOnly = segue.destinationViewController as! StarSingleTopic
        if let indexPath = self.StarTableViewIBO.indexPathForSelectedRow {
            let topicSeleted = topicArray[indexPath.row]
            
            topicOnly.TopicMainIdString = topicSeleted.topicId
            // 新增 TopicMainIdString
            
            topicOnly.TopicMainTitleString = topicSeleted.topicTitle
            topicOnly.TopicMainPhotoString = topicSeleted.topicPhoto
        }
    }
    
    
    
    
    
    

}
