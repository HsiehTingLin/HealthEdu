//
//  ArticleViewController.swift
//  HealthEdu
//
//  Created by Mac on 2016/9/12.
//  Copyright © 2016年 NCKU_hospital. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController {

    @IBOutlet var articleTitle: UILabel!
    @IBOutlet var articleTime: UILabel!
    @IBOutlet var articleDivision: UILabel!
    @IBOutlet var articleAuthor: UILabel!
    @IBOutlet var articleImage: UIImageView!
    @IBOutlet var articleContent: UITextView!
    
    var articleTitleVar :String? = "預設標題"
    var articleTimeVar :String?
    var articleDivisionVar :String?
    var articleAuthorVar : String?
    var articleImageVar :UIImage?
    var articleContentVar :String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.articleTitle.text = articleTitleVar
        
        self.articleTime.text = articleTimeVar
        
        self.articleDivision.text = articleDivisionVar
        
        self.articleAuthor.text = articleAuthorVar
        
        self.articleImage.image = articleImageVar
        
        self.articleContent.text = articleContentVar
        
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
