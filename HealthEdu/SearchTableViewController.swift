//
//  SearchTableViewController.swift
//  HealthEdu
//
//  Created by Mac on 2016/9/12.
//  Copyright © 2016年 NCKU_hospital. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController, UISearchBarDelegate {
    
    // the full function will be modified in future
    
    let searchItem = ["[範例] 糖尿病", "[範例] 飲食控制", "[範例] 大便潛血反應"]
    let searchBar = UISearchBar.self
    var filterArray = [String]()
    var showSearhResult = false

    override func viewDidLoad() {
        super.viewDidLoad()
        creatSearchBar()

  
    }
    /**
     creat search bar in naviagtion bar
     - returns: searchBar
     */
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
    
    /**
     search bar function
     - returns: bool
     */
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


}
