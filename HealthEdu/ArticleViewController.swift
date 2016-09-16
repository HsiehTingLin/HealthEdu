//
//  ArticleViewController.swift
//  HealthEdu
//
//  Created by Mac on 2016/9/12.
//  Copyright © 2016年 NCKU_hospital. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController {

    @IBOutlet weak var currentPhoto: UIImageView!
    @IBOutlet weak var currentDivision: UILabel!
    @IBOutlet weak var currentTitle: UILabel!
    @IBOutlet weak var currentAuthor: UILabel!
    @IBOutlet weak var currentBody: UILabel!
    @IBOutlet weak var currentTime: UILabel!
    //上面這些是從VC連過來的outlet，因為他們屬性不同，不能直接來使用
    
    
    var currentPhotoString = ""
    var currentDivisionString = ""
    var currentTitleString = ""
    var currentAuthorString = ""
    var currentBodyString = ""
    var currentTimeString = ""
    //這裡先宣告一些變變
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentPhoto.image = UIImage(named: currentPhotoString)
        currentDivision.text = currentDivisionString
        currentTitle.text = currentTitleString
        currentAuthor.text = currentAuthorString
        currentBody.text = currentBodyString
        currentTime.text = currentTimeString
        
        
        
    
        

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
