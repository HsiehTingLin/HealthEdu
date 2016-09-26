//
//  DivisionViewController.swift
//  HealthEdu
//
//  Created by Mac on 2016/9/11.
//  Copyright © 2016年 NCKU_hospital. All rights reserved.
//

import UIKit

class DivisionViewController: UIViewController, UITableViewDataSource{
    
    ////////////////////////////////////
    // 這頁我加入了 NckuHospital 這個 section 因為我在成果報告書中有提到這一塊
    
    @IBOutlet var tableView: UITableView!

    
    let NckuHospital = ["最新消息"]
    let InternalMedicine = ["胸腔內科","感染科","血液腫瘤科"]
    let Surgical = ["一般外科","小兒外科","骨科"]
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return NckuHospital.count
        } else if section == 1 {
            return InternalMedicine.count
        } else {
            return Surgical.count
        }
        
    }
    
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
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "成大醫院"
        } else if section == 1 {
            return "內科"
        } else {
            return "外科"
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let devisionVC = segue.destinationViewController as! DevisionOnlyVC
        
        if let indexPath = self.tableView.indexPathForSelectedRow {
            
            devisionVC.sectionSelected = indexPath.section
            devisionVC.rowSelected = indexPath.row
            // 這個func的作用:先把 articleArray中，被選中的資料，指定為 articleSelected這個變數(class是article )，然後將來自"ArticleViewController"的變數指定為articleDetail這個var(class 是ArticleViewController)，接著把articleSelected的每個變數都指定為articleDetail的各個對應的變數，類型都是String
            
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
