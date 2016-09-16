//
//  DivisionViewController.swift
//  HealthEdu
//
//  Created by Mac on 2016/9/11.
//  Copyright © 2016年 NCKU_hospital. All rights reserved.
//

import UIKit

class DivisionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    // 宣告 divisions，負責裝載 DivisionStruct 的 Array
    
    @IBOutlet var tableView: UITableView!
    var domains_and_divisions_hierarchy = [DomainAndDivisionStruct]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 讀取 domain 資料
        self.load_Domains_StaticData()
        
        // 讀取 divisions 資料，並將之填入 domains_and_division_hierarchy 大 array 中
        self.load_Divisions_StaticData()

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

    
    // 這個 func 負責 section 數目
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return domains_and_divisions_hierarchy.count
        // domains_and_divisions_hierarchy 的子項目數目即是 section 數
    }
    
    // 這個 func 負責每隔不同section裡面的 項目數目
    // section 假設是n，那個這 func 會從 0 開始跑到 (n-1)
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return domains_and_divisions_hierarchy[section].division_data.count
        // 每個 domains_and_divisions_hierarchy 的 子項目的 division_data 的數目
        // 就是 每個 section 內的項目數目
        
    }
    
    // 這個 func 負責 每個 section 內的 row 的名稱
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("division", forIndexPath: indexPath) as UITableViewCell
        
        
        let (division_name) = domains_and_divisions_hierarchy[indexPath.section].division_data[indexPath.row]!.division
        // indexPath.section 會代入現在跑到的 section 編號
        // indexPath.row 會代入現在跑到的 row 編號
        
        
        cell.textLabel?.text = (division_name)
        // 將 division_name 放到 cell 上
        
        return cell
        
    }
    
    // 這個 func 負責 每個 section 的 name
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return domains_and_divisions_hierarchy[section].domain
        // 每個 domains_and_divisions_hierarchy 元素的 domain 就是指該元素的名稱
        
    }
    
    
    // 跨 view 傳遞變數
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let divisionDetail = segue.destinationViewController as! DevisionOnlyVC
        
        if let indexPath = self.tableView.indexPathForSelectedRow {
            
            let selected_division_id: String = domains_and_divisions_hierarchy[indexPath.section].division_data[indexPath.row]!.id!
            // 以上這個是真正要 pass 到 文章列表頁面的 變數
            
            let selected_division_name: String =  domains_and_divisions_hierarchy[indexPath.section].division_data[indexPath.row]!.division!
            
            divisionDetail.selected_division_id = selected_division_id
            // 將 選中的 division_id 變數傳到下一個頁面去
            
            divisionDetail.selected_division_name = selected_division_name
            // 將 選中的 division 的 name 變數傳到下一個頁面去，作為顯示用
        }
    }




}
