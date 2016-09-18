//
//  ViewController.swift
//  HealthEdu
//
//  Created by Mac on 2016/9/11.
//  Copyright © 2016年 NCKU_hospital. All rights reserved.
//

import UIKit
//dddd
//sss
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        // 本來預設QR Code掃描完到這邊再到 article 顯示頁面
        // 但後來不用了！在此保留code
        /*let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        //print(appDelegate.QRcodeEntry)
        
     
        // 若是轉換過來的頁面，執行此區 code
        if appDelegate.QRcodeEntry! == "YES" {
            //print("判斷應該前往 article")
            
            dispatch_async(dispatch_get_main_queue()) {
                [unowned self] in
                self.performSegueWithIdentifier("QRCodeEntryShowArticle", sender: self)
            }
                        // 轉換畫面就靠它
        }*/
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

