//
//  StarMany.swift
//  The First viewController of the Star tabmenu, which contain the topics which are clickable
//  HealthEdu
//
//
//  Created by Yu-Ju Lin, Hsieh-Ting Lin.
//  Copyright © 2016年 衛教成大. All rights reserved.
//

// cell identifier: StarCellFirst

import UIKit

class StarMany: UIViewController,UITableViewDelegate {
    
    // the class of "topic" is defined in file TopicClass.swift
    var topicArray:[topic] = [topic]()

    @IBOutlet weak var StarTableViewIBO: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //  fetch the data from the file StarManyTopic.swift when view did load
        self.topicArray = StarManyTopic.getTopicArray()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
     - returns: count of topicArray
     */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topicArray.count
    }
    /**
     Define the cell.
     The cell Identifier in Storyboard is called starcellFirst
     - returns: cell
     */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // creat the variable cell, the detail of the cell is define in file myTopicCell.swift
        let cell = tableView.dequeueReusableCellWithIdentifier("starCellFirst", forIndexPath: indexPath) as! myTopicsCell
        // fetch data from each row of the topicArray and let it be topicItem
        let topicItem = topicArray[indexPath.row]
        // for the different types of data in topicItem, assign them as the element in starCellFirst.swift
        cell.topicPhotoIBO.image = UIImage(named: topicItem.topicPhoto)
        cell.topicTitleIBO.text = topicItem.topicTitle
        cell.opacityhalf.image = UIImage(named: "opacityhalf")

        return cell
    }
    
    /**
     Prepare for segue. When users tap one topic in this viewController, we must prepare the selected data and pass them to next viewcontroller
     The cell Identifier in Storyboard is called starcellFirst
     - returns: cell
     */
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let topicOnly = segue.destinationViewController as! StarSingleTopic
        if let indexPath = self.StarTableViewIBO.indexPathForSelectedRow {
            let topicSeleted = topicArray[indexPath.row]
            topicOnly.TopicMainIdString = topicSeleted.topicId
            topicOnly.TopicMainTitleString = topicSeleted.topicTitle
            topicOnly.TopicMainPhotoString = topicSeleted.topicPhoto
        }
    }

}
