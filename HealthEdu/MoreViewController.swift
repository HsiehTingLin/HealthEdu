//
//  MoreViewController.swift
//  HealthEdu
//
//  Created by Mac on 2016/9/25.
//  Copyright © 2016年 NCKU_hospital. All rights reserved.
//

import UIKit

class MoreViewController: UIViewController,UITableViewDelegate {

    @IBOutlet weak var moreTableView: UITableView!
    
    var moreOptions = [String]()
    var viewControllerStoryboardIdentity = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moreOptions = ["訂閱電子報","意見回饋","文章顯示設定","關於"]
        viewControllerStoryboardIdentity = ["MoreSubscribe","MoreComment","MoreTextSetting","MoreAbout"]

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
        return moreOptions.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        cell.textLabel?.text = moreOptions[indexPath.row]
        return cell
        
    }
    // 以下是當cell被選擇時，要傳送到哪一個view
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vcID = viewControllerStoryboardIdentity[indexPath.row]
        let viewController = storyboard?.instantiateViewControllerWithIdentifier(vcID)
        self.navigationController?.pushViewController(viewController!, animated: true)
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
