//
//  SearchTableViewController.swift
//  ViewController for Search bar and showing recommended keywords
//
//  HealthEdu
//
//  Created by Mac on 2016/9/12.
//  Copyright © 2016年 NCKU_hospital. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController, UISearchBarDelegate {
    
    // MARK:- Variable Declaration
    
    // Offline Data for now. Recommended Keywords
    let searchItem = ["[範例] 糖尿病", "[範例] 飲食控制", "[範例] 大便潛血反應"]
    
    // Variable for containing searchBar
    let searchBar = UISearchBar.self
    
    // FilterArray for filter keywords
    var filterArray = [String]()
    
    // for marking whether user type in something to search or not
    var showSearhResult = false


    // MARK:- Basic Func
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // create search bar func
        creatSearchBar()

  
    }
    
    /**
     for creating search bar in navigationItem title view
     - parameter nothing
     - returns: nothing
    */
    func creatSearchBar() {
        
        let searchBar = UISearchBar()
        searchBar.showsCancelButton = false
        
        // placeholder
        searchBar.placeholder = "搜尋：請在此輸入關鍵字"
        searchBar.delegate = self
        
        // put search bar on
        self.navigationItem.titleView = searchBar
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    /**
     func for detecting searchBar action, and doing some other thing
    */
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        // filterArray for contain keywords related to searchText in real time
        filterArray = searchItem.filter({ (names: String) -> Bool in
            return names.lowercaseString.rangeOfString(searchText.lowercaseString) != nil
        })
        
        if searchText != ""
        {
            // user do type in some text to search
            showSearhResult = true
            self.tableView.reloadData()
            
        } else {
            
            // user do not type anything
            showSearhResult = false
            self.tableView.reloadData()
            
        }
    }


    // MARK: - Table view data source

    /**
     Define how many section are there
     - returns: Int , section number, in this case just one
    */
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    /**
     Define how rows in each section
     In this case, only one section. So, no need to use variable section
     - returns: Int , row number
     */
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // determine whether user type in some text or not
        if showSearhResult {
            
            // user do type in some text to search -> show filterArray
            return filterArray.count
            
        } else {
            
            // user do not type anything -> show original searchItem array
            return searchItem.count
        }
        
        
        
    }
    
    /**
     Define content of each row
     In this case, only one section. So, no need to use variable section
     - returns: UITableViewCell , row number
     */
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Define identifier searchCell
        let cell = tableView.dequeueReusableCellWithIdentifier("searchCell", forIndexPath: indexPath)
        
        
        // determine whether user type in some text or not
        if showSearhResult {
            
            // user do type in some text to search -> show filterArray
            cell.textLabel?.text = filterArray[indexPath.row]
            
            
        } else {
            
            // user do not type anything -> show original searchItem array
            cell.textLabel?.text = searchItem[indexPath.row]
            
        }
        
        return cell
    }
    
    // MARK:- Specific funcs for search functionality
    
    /**
     touch on screen trigger this
     then execute tableview endEditing to dismiss the keyboard
     
     - returns: nothing
     */
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.tableView.endEditing(true)
    }
    
    /**
     press on keyboard's "return" button trigger this func
     then it dismiss keyboard and  reload tableView data
     
     - returns: nothing
     */
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        showSearhResult = true
        searchBar.endEditing(true)
        self.tableView.reloadData()
        
    }
 


}
