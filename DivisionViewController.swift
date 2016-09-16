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
    
    var domains_and_divisions_hierarchy = [DomainAndDivisionStruct]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 讀取 domain 資料
        self.load_Domains_StaticData()
        
        // 讀取 divisions 資料，並將之填入 domains_and_division_hierarchy 大 array 中
        self.load_Divisions_StaticData()
        print("---------")
        for a in domains_and_divisions_hierarchy{
            
            print("##")
            for b in a.division_data{
                print(b?.division)
            }
            print("##")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // func 負責載入靜態 json 檔案，取得 domain 資料
    // 並建立一個超大 array，等一下 讀取 division 時，把所有東西塞入那個 array
    func load_Domains_StaticData() -> Void
    {
        if let path = NSBundle.mainBundle().pathForResource("Domains", ofType: "json")
        {
            if let jsonData = NSData(contentsOfFile: path)
            {
                if let jsonArray = Parse.parseJSONdata(jsonData){
                    
                    // 以下把每一個 array 原本item 抓出來，轉換成 DivisionStruct的樣子
                    for jsonItem in jsonArray {
                        
                        
                        let newJsonItem = DomainAndDivisionStruct(id: jsonItem["id"] as! String?, domain: jsonItem["domain"]  as! String?, division_data: [DivisionStruct?]() )
                        
                        self.domains_and_divisions_hierarchy.append(newJsonItem)
                        
                    }
                }
            }
        }
    }
    
    
    // func 負責載入靜態 json 檔案，取得 divisions 分科資料
    func load_Divisions_StaticData() -> Void
    {
        if let path = NSBundle.mainBundle().pathForResource("Divisions", ofType: "json")
        {
            if let jsonData = NSData(contentsOfFile: path)
            {
                if let jsonArray = Parse.parseJSONdata(jsonData){
                    
                    // 以下把每一個 array 原本item 抓出來，轉換成 DivisionStruct的樣子
                    for jsonItem in jsonArray {

                        let newJsonItem = DivisionStruct(id: jsonItem["id"] as! String?, division: jsonItem["division"]  as! String?, domain: jsonItem["domain"] as! String? , description: jsonItem["description"]  as! String?)
                        
                        
                        // 以下這個 for 遍歷每個 domains
                        // 確認 是該domain 的 division 就納入 該domain 的 division_data 中
                        for (index,a_domain) in self.domains_and_divisions_hierarchy.enumerate() {
                           
                            // 判斷 是否這個 jsonItem (這個科別) 的 domain 是 a_domain 這個轄下
                            if newJsonItem.domain == a_domain.id {
                                self.domains_and_divisions_hierarchy[index].division_data.append(newJsonItem)
                            }

                        }
                        
                        

                    }
                }
            }
        }
    }

    
    ///////////////////////////////////////

    
    
    let Official = ["最新消息"]
    let InternalMedicine = ["一般內科","胃腸肝膽內科","感染科","胸腔內科","血液腫瘤科"]
    let Surgical = ["一般外科","心臟血管外科","胸腔外科","胸腔外科"]
    let Others = ["泌尿科","藥劑部"]
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return Official.count
        case 1:
            return InternalMedicine.count
        case 2:
            return Surgical.count
        case 3:
            return Others.count
        default:
            return 0
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("division", forIndexPath: indexPath) as UITableViewCell
        
        
        
        switch indexPath.section {
        case 0:
            let (divisioin_name) = Official[indexPath.row]
            cell.textLabel?.text = divisioin_name
        case 1:
            let (divisioin_name) = InternalMedicine[indexPath.row]
            cell.textLabel?.text = divisioin_name
        case 2:
            let (divisioin_name) = Surgical[indexPath.row]
            cell.textLabel?.text = divisioin_name
        case 3:
            let (divisioin_name) = Others[indexPath.row]
            cell.textLabel?.text = divisioin_name
        default:
            print()
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "成大醫院"
        case 1:
            return "內科"
        case 2:
            return "外科"
        case 3:
            return "其他科別"
        default:
            return ""
        }
    }
    




}
