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
        print("我是佑如！！！！！！")
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        print(appDelegate.QRcodeEntry)
        
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
    
    
    @IBAction func GenerateQRCode(sender: AnyObject) {
        
        let alertMessage = UIAlertController(title: "請使用QR Code掃描器掃描！", message: "點擊背景以返回", preferredStyle: .Alert)
        
        let height:NSLayoutConstraint = NSLayoutConstraint(item: alertMessage.view, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: self.view.frame.height * 0.43)
        
        alertMessage.view.addConstraint(height)

        let imageView = UIImageView(frame: CGRectMake(30, 90, 200, 200))
        
        imageView.image = UIImage(named: "Diagnosis.jpg")
        alertMessage.view.addSubview(imageView)
        
        //let action = UIAlertAction(title: "返回", style: .Default, handler: nil)
        
        //alertMessage.addAction(action)
        
        self.presentViewController(alertMessage, animated: true, completion:{
            alertMessage.view.superview?.userInteractionEnabled = true
            alertMessage.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.alertControllerBackgroundTapped)))
        })

       
        
    }
    
    
    func alertControllerBackgroundTapped()
    {
        self.dismissViewControllerAnimated(true, completion: nil)
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
