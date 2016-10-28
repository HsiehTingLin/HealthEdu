//
//  StarMany.swift
//  The First viewController of the Star tabmenu, which contain the topics which are clickable
//  HealthEdu
//
//
//  Created by Yu-Ju Lin, Hsieh-Ting Lin.
//  Copyright © 2016年 衛教成大. All rights reserved.
//

import UIKit

class StarMany: UIViewController {
    

    // 測試用 abc 跟 Qrcode啟動轉址有關
    var abc: Bool?
    var imm = UIImage()
    // 測試用以上
    
    
    
    
    // MARK:- Variable Declaration
    // the class of "topic" is defined in file TopicClass.swift
    var topicArray: [topic] = []
    
    // refer TableView
    @IBOutlet weak var StarTableViewIBO: UITableView!
    
    // init activityindicator
    var activityIndicator = UIActivityIndicatorView()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // 測試用 當 abc 為 true 時，會實現 Qrcode 開啟本機畫面直接轉畫面的功能
        self.abc = false
        if(self.abc == true){
            self.performSegueWithIdentifier("QrcodeDirectShowArticleSegue", sender: nil)
        }
        // 測試用以上
        
        
        
        // build activityIndicator as WhiteLarge(change to blue later)
        self.activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        
        // change activityIndicator color to blue (default iOS blue)
        self.activityIndicator.color = UIColor.init(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0)
        
        // init activityIndicator Animating
        self.activityIndicator.startAnimating()
        

        // not to display UITableView separator style
        self.StarTableViewIBO.separatorStyle = UITableViewCellSeparatorStyle.None
        
        // set activityIndicator as StarTableViewIDB's backgrousView
        self.StarTableViewIBO.backgroundView = self.activityIndicator
        
        
        
        // call ListStar byDefault() method to download star topic data from Server
        ListStar.byDefault({
            (starTopicArray) in

            
            // change UI inside main queue
            dispatch_async(dispatch_get_main_queue(), {
                
                // no matter how long it takes to download data from Server
                // the activityIndicator will animating from 3 seconds
                let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 3 * Int64(NSEC_PER_SEC))
                    dispatch_after(time, dispatch_get_main_queue()) {
                        
                        // stop activity indicator animating
                        self.activityIndicator.stopAnimating()
                        self.activityIndicator.hidden = true
                        
                        // refer self.topicArray to starTopicArray (Array from Server)
                        self.topicArray = starTopicArray
                        
                        // show the line separator again
                        self.StarTableViewIBO.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
                        
                        // reload StarTableViewIBO in animating style
                        UIView.transitionWithView(self.StarTableViewIBO, duration: 1.0, options: .TransitionCrossDissolve, animations: {self.StarTableViewIBO.reloadData()}, completion: nil)
                        
                        
                }
                

                
                
            })
            

        })
    

        
    }
    

    
}


// MARK: - Table view
extension StarMany: UITableViewDataSource, UITableViewDelegate {

    

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

        
        // add photo from imageFromSeverURL (which is a custom extension)
        // will load photo later on
        cell.topicPhotoIBO.imageFromServerURL(cell.topicPhotoIBO, urlString: topicItem.topicPhoto!, completionHandler: {
            (imageFromNet) in
            
            // here insert image From Net to topicArray.topicPhotoUIImage
            self.topicArray[indexPath.row].topicPhotoUIImage = imageFromNet
            
        })
        
        
        // add title
        cell.topicTitleIBO.text = topicItem.topicTitle
        
        // add opacityhalf image
        cell.opacityhalf.image = UIImage(named: "opacityhalf")

        return cell
    }
    
    
    
    
    
    /**
     
        Prepare for segue. When users tap one topic in this viewController, we must prepare the selected data and pass them to next viewcontroller
        The cell Identifier in Storyboard is called starcellFirst
     
        - returns: cell
     
     */
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if(segue.identifier == "QrcodeDirectShowArticleSegue"){
            // User launch app from qrcode scan
            print("go to qrcode")
            
        }else{
            
            let topicOnly = segue.destinationViewController as! StarSingleTopic
            
            if let indexPath = self.StarTableViewIBO.indexPathForSelectedRow {
                
                let topicSeleted = topicArray[indexPath.row]
                
                topicOnly.TopicMainIdString = topicSeleted.topicId
                
                topicOnly.TopicMainTitleString = topicSeleted.topicTitle
                
                topicOnly.TopicMainPhotoFromMany = topicSeleted.topicPhotoUIImage!
                
                
            }
            
        }

        
    }

}
