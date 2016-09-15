//
//  DivisionViewController.swift
//  HealthEdu
//
//  Created by Mac on 2016/9/11.
//  Copyright © 2016年 NCKU_hospital. All rights reserved.
//

import UIKit

class DivisionViewController: UIViewController {
    
    // 宣告 divisions，負責裝載 DivisionStruct 的 Array
    var divisions = [DivisionStruct]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 讀取 divisions 資料
        self.loadDivisionsStaticData()
        for a in divisions{
            print(a.division)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // func 負責載入靜態 json 檔案，取得 divisions 分科資料
    func loadDivisionsStaticData() -> Void
    {
        if let path = NSBundle.mainBundle().pathForResource("Divisions", ofType: "json")
        {
            if let jsonData = NSData(contentsOfFile: path)
            {
                if let jsonArray = Parse.parseJSONdata(jsonData){
                    
                    // 以下把每一個 array 原本item 抓出來，轉換成 DivisionStruct的樣子
                    for jsonItem in jsonArray {

                        let newJsonItem = DivisionStruct(id: jsonItem["id"] as! String?, division: jsonItem["division"]  as! String?, description: jsonItem["description"]  as! String?)
                        self.divisions.append(newJsonItem)

                    }
                }
            }
        }
    }

    
    /*
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return InternalMedicine.count
        } else {
            return Surgical.count
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("division", forIndexPath: indexPath) as UITableViewCell
        
        if indexPath.section == 0 {
            let (divisioin_name) = InternalMedicine[indexPath.row]
            cell.textLabel?.text = divisioin_name
        } else {
            let (divisioin_name) = Surgical[indexPath.row]
            cell.textLabel?.text = divisioin_name
            
        }
        
        let (divisioin_name) = InternalMedicine[indexPath.row]
        
        cell.textLabel?.text = divisioin_name
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "內科"
        } else {
            return "外科"
        }
    }
    
    */




}
