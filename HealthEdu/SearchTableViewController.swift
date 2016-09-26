//
//  SearchTableViewController.swift
//  HealthEdu
//
//  Created by Mac on 2016/9/12.
//  Copyright © 2016年 NCKU_hospital. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController, UISearchBarDelegate {
    
    let searchItem = ["[範例] 糖尿病", "[範例] 飲食控制", "[範例] 大便潛血反應"]
    let searchBar = UISearchBar.self
    var filterArray = [String]()
    var showSearhResult = false

    override func viewDidLoad() {
        super.viewDidLoad()
        creatSearchBar()

  
    }
    func creatSearchBar() {
        let searchBar = UISearchBar()
        searchBar.showsCancelButton = false
        searchBar.placeholder = "搜尋：請在此輸入關鍵字"
        searchBar.delegate = self
        
        self.navigationItem.titleView = searchBar
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // Function for adding search
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        filterArray = searchItem.filter({ (names: String) -> Bool in
            return names.lowercaseString.rangeOfString(searchText.lowercaseString) != nil
        })
        if searchText != ""
        {
            showSearhResult = true
            self.tableView.reloadData()
        } else {
            showSearhResult = false
            self.tableView.reloadData()
        }
    }
    
    
    // END Function for adding search

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if showSearhResult {
            return filterArray.count
        } else {
            return searchItem.count
        }
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("searchCell", forIndexPath: indexPath)
        if showSearhResult {
            cell.textLabel?.text = filterArray[indexPath.row]
        } else {
            cell.textLabel?.text = searchItem[indexPath.row]
        }
        
        return cell
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.tableView.endEditing(true)
    }
    
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        showSearhResult = true
        searchBar.endEditing(true)
        self.tableView.reloadData()
        
    }
 


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
