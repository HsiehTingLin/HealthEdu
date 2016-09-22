//
//  ArticleViewController.swift
//  HealthEdu
//
//  Created by Mac on 2016/9/12.
//  Copyright © 2016年 NCKU_hospital. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController, UIPopoverPresentationControllerDelegate {
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
    
    
    @IBAction func changeFontSize(sender: AnyObject) {
        
 
        let storyboard : UIStoryboard = UIStoryboard(
            name: "Main",
            bundle: nil)
        
        let ChangeFontSizePopover: ArticlePopoverViewController = storyboard.instantiateViewControllerWithIdentifier("ArticlePopoverViewController") as! ArticlePopoverViewController
        
        ChangeFontSizePopover.modalPresentationStyle = .Popover
        

        let popoverPresentationViewController = ChangeFontSizePopover.popoverPresentationController
        
        popoverPresentationViewController?.permittedArrowDirections = .Up
        popoverPresentationViewController?.delegate = self
        popoverPresentationController?.barButtonItem = sender as? UIBarButtonItem
        
        
        
        popoverPresentationViewController?.barButtonItem = sender as? UIBarButtonItem
 
        //print(sender.bounds)
        
        
        
        ChangeFontSizePopover.preferredContentSize = CGSizeMake(230, 110)
        
        presentViewController(ChangeFontSizePopover, animated: true, completion: nil)
    }
    
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle{
        return .None
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
        
        let photoSeparated:Array = currentPhotoString.componentsSeparatedByString(".")
        
        let photoPath :String? = NSBundle.mainBundle().pathForResource(photoSeparated[0], ofType: photoSeparated[1])
        
        
        let divWidth = self.view.frame.size.width-17
        let divHeight = 243
        let imgWidth = self.view.frame.size.width-17
        
        
        var articleFullHTMLarray = [String]()
        articleFullHTMLarray.append("<div width=\"\(divWidth)\" style=\"word-break: break-all;\"")
  
        
        articleFullHTMLarray.append("<br><p><div align=\"center\" style=\"font-size:35px; font-weight:bold;\">\(self.currentTitleString)</div></p>")
        articleFullHTMLarray.append("<p><div align=\"center\" style=\"color: gray;\">\(self.currentAuthorString)</div></p>")
        articleFullHTMLarray.append("<div align=\"center\" style=\"width:\(divWidth)px; height:\(divHeight)px; overflow:hidden;  \">")
        articleFullHTMLarray.append(NSString(format:"<img src=\"file://%@\" width=\"\(imgWidth)\">", photoPath!) as String)
        articleFullHTMLarray.append("</div>")
        articleFullHTMLarray.append("<div style='font-size: 21px'><p>\(self.currentBodyString)</p>")
        articleFullHTMLarray.append("<p>最後更新：\(self.currentTimeString)<br></p></div>")
        articleFullHTMLarray.append("</div>")
        
        
        let articleFullHTML = articleFullHTMLarray.joinWithSeparator("")
        self.articleFullWebView.loadHTMLString(articleFullHTML, baseURL: nil)
        

        /*currentPhoto.image = UIImage(named: currentPhotoString)
        currentDivision.text = currentDivisionString
        currentTitle.text = currentTitleString
        currentAuthor.text = currentAuthorString
        currentBody.text = currentBodyString
        currentTime.text = currentTimeString*/
        // 把outlet 裡的屬性指定為變數
        
        
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
