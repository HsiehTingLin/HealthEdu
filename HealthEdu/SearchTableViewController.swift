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
    let searchItem = ["糖尿病", "飲食控制", "大便潛血"]
    
    // Variable for containing searchBar
    let searchBar = UISearchBar.self
    
    // contain text to search when button return clicked
    var searchTextTemp: String?
    
    // for marking whether user type in something to search or not
    var showSearhResult = false


    // MARK:- Basic Func
    override func viewDidLoad() {
        
        super.viewDidLoad()
        

        
        
        // create search bar func
        let searchBar = UISearchBar()
        searchBar.showsCancelButton = false
        
        // placeholder
        searchBar.placeholder = "搜尋：請在此輸入關鍵字"
        searchBar.delegate = self
        
        // put search bar on
        self.navigationItem.titleView = searchBar
        
  
  
    }
    
    


    // MARK:- Specific funcs for search functionality
    func hideKeyboard(){
        self.view.endEditing(true)
    }
    
    // TODO: 如何 dismiss keyboard
    
    /**
        press on keyboard's "return" button trigger this func
        then it dismiss keyboard, temporarily store searchText, and preform segue
     
        - returns: nothing
     */
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        // dismiss keyboard
        searchBar.endEditing(true)
        
        // 檢查不能是空直
        let whitespaceSet = NSCharacterSet.whitespaceCharacterSet()
        if searchBar.text!.stringByTrimmingCharactersInSet(whitespaceSet) != "" {
            
            // string contains non-whitespace characters
            
            // temporary store searchBar text to searchTextTemp
            self.searchTextTemp = searchBar.text
            
            // perform segue change vc
            self.performSegueWithIdentifier("searchTextSendSegue", sender: nil)

            
        }
        
        
        
        
    }

    
    

    // MARK: - Table view data source

    /**
        Define how many section are there
        - returns: Int , section number, in this case just one
    */
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "♨ 熱門關鍵字"
        }else{
            return "📈 最新趨勢"
        }
        
    }
    
    
    /**
        Define how rows in each section
        In this case, only one section. So, no need to use variable section
     
        - returns: Int , row number
     */
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
            
        // user do not type anything -> show original searchItem array
        return searchItem.count

        
    }
    
    
    
    // TODO: 應作出網路趨勢統整
    /**
        Define content of each row
        In this case, only one section. So, no need to use variable section
     
        - returns: UITableViewCell , row number
     */
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Define identifier searchCell
        let cell = tableView.dequeueReusableCellWithIdentifier("searchCell", forIndexPath: indexPath)
        

        // user do not type anything -> show original searchItem array
        cell.textLabel?.text = searchItem[indexPath.row]
        
        
        
        return cell
    }
    
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // check if segue is trigger from click on tableView
        // YES for execute this if clause, extract text to search from array
        // NO for skip it
        if let indexPath = self.tableView.indexPathForSelectedRow {
            
            self.searchTextTemp = self.searchItem[indexPath.row]
            
        }
        
        // set SearchResultVC
        let searchResultVC = segue.destinationViewController as! SearchResultVC
        
        // pass data to SearchResultVC
        searchResultVC.searchText = self.searchTextTemp
        
        
        
    }
    
    


}
