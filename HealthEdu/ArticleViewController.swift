//
//  ArticleViewController.swift
//  HealthEdu
//
//  Created by Mac on 2016/9/12.
//  Copyright © 2016年 NCKU_hospital. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController {

    
    @IBOutlet weak var addToBookmark: UIBarButtonItem!
    
    
    @IBOutlet weak var currentPhoto: UIImageView!
    @IBOutlet weak var currentDivision: UILabel!
    @IBOutlet weak var currentTitle: UILabel!
    @IBOutlet weak var currentAuthor: UILabel!
    @IBOutlet weak var currentBody: UILabel!
    @IBOutlet weak var currentTime: UILabel!
    //上面這些是從VC連過來的outlet，因為他們屬性不同，不能直接來使用
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    var currentPhotoString = ""
    var currentDivisionString = ""
    var currentTitleString = ""
    var currentAuthorString = ""
    var currentBodyString = ""
    var currentTimeString = ""
    //這裡先宣告一些變數，注意這裡的名字會被使用在資料來源的vc
    
    
    @IBOutlet var articleFullWebView: UIWebView!
    
    // 以下為 qrcodeImage 變數
    var qrcodeImage: CIImage!
    
    // 以下這個也是要傳遞過來的變數
    var articleIdforQRCode :String? = "http://myelin.tk/for_ncku_app_test/"
    
    
    @IBAction func qrcodeBtn(sender: AnyObject) {
        let alertMessage = UIAlertController(title: "請使用QR Code掃描器掃描！", message: "點擊背景以返回", preferredStyle: .Alert)
        
        let height:NSLayoutConstraint = NSLayoutConstraint(item: alertMessage.view, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 320)
        
        alertMessage.view.addConstraint(height)
        
        
        
        let imageView = UIImageView(frame: CGRectMake(35, 90, 200, 200))
        
        imageView.image = self.GenerateQRCode(imageView)
        // 右邊產生 qrcode
        alertMessage.view.addSubview(imageView)
        
        //let action = UIAlertAction(title: "返回", style: .Default, handler: nil)
        
        //alertMessage.addAction(action)
        
        self.presentViewController(alertMessage, animated: true, completion:{
            alertMessage.view.superview?.userInteractionEnabled = true
            alertMessage.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.alertControllerBackgroundTapped)))
        })

    }
    
    // 加到bookmark
    var addedToBookmark = false
    @IBAction func addToBookmarkAction(sender: UIBarButtonItem) {
        
        if addedToBookmark {
            //存到bookmark
        } else {
            //不存到bookmark
        }
        
    }
    
    // 產生QR Code
    func GenerateQRCode(imgview: UIImageView) -> UIImage
    {
        
        if self.articleIdforQRCode == "" {
            return UIImage()
        }
        
        let data = self.articleIdforQRCode!.dataUsingEncoding(NSISOLatin1StringEncoding, allowLossyConversion: false)
        // data 為要送去製造 QR Code 的 String
        
        let filter = CIFilter(name: "CIQRCodeGenerator")
        
        filter!.setValue(data, forKey: "inputMessage")
        filter!.setValue("Q", forKey: "inputCorrectionLevel")
        
        self.qrcodeImage = filter!.outputImage
        
        let scaleX = imgview.frame.size.width / self.qrcodeImage.extent.size.width
        let scaleY = imgview.frame.size.height / self.qrcodeImage.extent.size.height
        // 上面這兩行 是算出目前 imgQRCode 這個 frame 的大小與 qrcodeimage
        
        let transformedImage = self.qrcodeImage.imageByApplyingTransform(CGAffineTransformMakeScale(scaleX, scaleY))
        // 轉換 qrcodeimage的大小
        
        return UIImage(CIImage: transformedImage)
        
    }
    
    
    // 按下背景可以返回
    func alertControllerBackgroundTapped()
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = currentDivisionString
        
        self.showarticleFullHTML(21)
        // 一開此頁面顯示文章，以 21 font-size顯示
        
        
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
