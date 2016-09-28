//
//  DivisionViewController.swift
//  The first viewController in Class tab menu
//  HealthEdu
//
//  Created by Yu-Ju Lin, Hsieh-Ting Lin.
//  Copyright © 2016年 衛教成大. All rights reserved.
//

import UIKit

class DivisionViewController: UIViewController, UITableViewDataSource{
    
    
    @IBOutlet var tableView: UITableView!

    
    let NckuHospital = ["最新消息"]
    let InternalMedicine = ["胸腔內科","感染科","血液腫瘤科"]
    let Surgical = ["一般外科","小兒外科","骨科"]
    
    /**
     Define how many section in table view, need modified in beta version
     - returns: 1:Int
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        // MARK: - Table view data source
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
        // MARK: important ! Change in future
    }
    
    /**
     Define numberOfRowsInSection
     - returns: count of different array. Add more condition in future
     */
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return NckuHospital.count
        } else if section == 1 {
            return InternalMedicine.count
            // MARK: important ! Change in future
        } else {
            return Surgical.count
        }
        
    }
    /**
     Define cell
     - returns: cell
     */
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("division", forIndexPath: indexPath) as UITableViewCell
        
        
        if indexPath.section == 0 {
            let (divisioin_name) = NckuHospital[indexPath.row]
            cell.textLabel?.text = divisioin_name
        } else if indexPath.section == 1 {
            let (divisioin_name) = InternalMedicine[indexPath.row]
            cell.textLabel?.text = divisioin_name
        } else {
            let (divisioin_name) = Surgical[indexPath.row]
            cell.textLabel?.text = divisioin_name
            
        }
         // MARK: important ! Change in future
        
        return cell
    }
    /**
     Define the title for header in section
     - returns: string
     */
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "成大醫院"
        } else if section == 1 {
            return "內科"
        } else {
            return "外科"
        }
        // MARK: important ! Change in future
    }
    
    /**
     Pass the data to the DevisionOnlyVC
     - returns: string
     */
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let devisionVC = segue.destinationViewController as! DevisionOnlyVC
        
        if let indexPath = self.tableView.indexPathForSelectedRow {
            
            devisionVC.sectionSelected = indexPath.section
            devisionVC.rowSelected = indexPath.row
            
        }
    }
    
}
