//
//  ArticleViewController.swift
//  ViewControlller for showing one Article Content Detail
//
//  HealthEdu
//
//  Created by Mac on 2016/9/12.
//  Copyright © 2016年 NCKU_hospital. All rights reserved.
//

import UIKit
import CoreData

class ArticleViewController: UIViewController {
    
    // MARK:- Variable Declaration
    var currentIdString: String?
    
    // TODO: 這個應該要刪掉
    var currentPhotoString: String?
    
    var currentDivisionString: String?
    
    var currentTitleString: String?
    
    var currentAuthorString: String?
    
    var currentBodyString: String?
    
    var currentTimeString: String?
    
    var currentPhotoUIImage = UIImage()

    // WebView for article Full text
    @IBOutlet var articleFullWebView: UIWebView!
    
    // qrcodeImage
    var qrcodeImage: CIImage!
    
    // URLArray for storing redirecting qrcode url
    var URLArrayforQRCode = [String]()
    
    // storing fontSize
    var fontSizeString :String?

    // for core data
    let core_data = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    

    // MARK:- Basic Func
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /**
     execute once whenever user view this ViewController
     - show navigation Bar button item
     - show article full html in web view
     - delete History of same article 
     - add new history record to core data
     
     - returns: nothing
     */
    override func viewWillAppear(animated: Bool) {
        
        // show bar button item (qrcode, change font size, AddTobookmark)
        self.showBarButtonItem()
        
        // show article Full in web view (get defaults font size)
        self.showarticleFullHTML(self.getDefaultFontSize())
        
        // delete same history
        self.deleteHistoryExist()
        
        // add new record to HistoryEntities
        self.addToHistory()
        
        
    }
    
    /**
     show bar button item here
     
     - returns: nothing
     */
    
    func showBarButtonItem()
    {
        // check if the article is in core data
        let fetchRequest = NSFetchRequest(entityName: "BookmarkEntities")
        fetchRequest.predicate = NSPredicate(format: "id == %@", currentIdString!)
        
        do {
            
            let fetchResults = try self.core_data.executeFetchRequest(fetchRequest) as? [BookmarkEntities]
            
            var button1 = UIBarButtonItem()
            
            if fetchResults!.count > 0 {
                
                // the article already exist, show bookmark black button
                button1 = UIBarButtonItem(image: UIImage(named: "bookmark_black"), landscapeImagePhone: nil, style: .Done, target: self, action: #selector(self.deleteFromBookmark))
                
            }else{
                
                // the article does not exist, show bookmark white button
                button1 = UIBarButtonItem(image: UIImage(named: "bookmark_white"), landscapeImagePhone: nil, style: .Done, target: self, action: #selector(self.addToBookmark(_:)))
                
            }
            
            
            var width =  button1.width
            width = -10
            button1.width = width
            
            
            
            let button2 = UIBarButtonItem(image: UIImage(named: "font_size"), landscapeImagePhone: nil, style: .Done, target: self, action: #selector(self.changeFontSize(_:)))
            
            let button3 = UIBarButtonItem(image: UIImage(named: "qrcode"), landscapeImagePhone: nil, style: .Done, target: self, action: #selector(self.qrcodeBtn(_:)))
            
            
            self.navigationItem.setRightBarButtonItems([button1,button2,button3], animated: false)
            
            
            
            
        }catch{
            
            fatalError("CANT FIND: \(error)")
            
        }
    }

    
    
    
    
    
    // MARK:- Show HTML
    
    
    /**
        show full article HTML
        - paraemeter fontsize: size of font
        - returns: nothgin
     
     */
    func showarticleFullHTML(fontsize: Int){
        
        

        
        
        let divWidth = self.view.frame.size.width-17
        let divHeight = 243
        let imgWidth = self.view.frame.size.width-17
        
        
        var articleFullHTMLarray = [String]()
        articleFullHTMLarray.append("<div width=\"\(divWidth)\" style=\"word-break: break-all;\"")
        
        
        articleFullHTMLarray.append("<br><p><div align=\"center\" style=\"font-size:35px; font-weight:bold;\">\(self.currentTitleString!)</div></p>")
        articleFullHTMLarray.append("<p><div align=\"center\" style=\"color: gray; font-size:19px\">\(self.currentAuthorString!)</div></p>")
        articleFullHTMLarray.append("<div align=\"center\" style=\"width:\(divWidth)px; height:\(divHeight)px; overflow:hidden;  \">")
        
        // amazing: UIImageJPEGRepresentation can convert jpeg png gif
        let imageData = NSData(data: UIImageJPEGRepresentation(self.currentPhotoUIImage,1.0)!)
        
        let base64Data = imageData.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)

        articleFullHTMLarray.append("<img src=\"data:image/jpg;base64,\(base64Data)\" width=\"\(imgWidth)\">")
        articleFullHTMLarray.append("</div>")
        articleFullHTMLarray.append("<div style='font-size: \(fontsize)px' id=\"body\"><p>\(self.currentBodyString!)</p>")
        articleFullHTMLarray.append("<p>最後更新：\(self.currentTimeString!)<br></p></div>")
        articleFullHTMLarray.append("</div>")
        
        
        let articleFullHTML = articleFullHTMLarray.joinWithSeparator("")
        
        self.fontSizeString = "正常"
        self.articleFullWebView.loadHTMLString(articleFullHTML, baseURL: nil)
        
    }
    
    
    
    // MARK: Bar Button Item Function
    
    /**
     this func will generate a qrcode related to id of the article
     - returns: UIImage()
     */
    func GenerateQRCode(imgview: UIImageView) -> UIImage
    {
        // generate the url for this article id
        self.URLArrayforQRCode.append("http://medcode.in/for_ncku_app_test/index.php?articleID=")
        self.URLArrayforQRCode.append(self.currentIdString!)
        
        let realURLStringforQRCode = URLArrayforQRCode.joinWithSeparator("")
        
        // prevent
        if realURLStringforQRCode == "" {
            return UIImage()
        }
        
        // variable data is going to be sent to generate a QR Code image
        let data = realURLStringforQRCode.dataUsingEncoding(NSISOLatin1StringEncoding, allowLossyConversion: false)
        
        
        let filter = CIFilter(name: "CIQRCodeGenerator")
        
        filter!.setValue(data, forKey: "inputMessage")
        filter!.setValue("Q", forKey: "inputCorrectionLevel")
        
        self.qrcodeImage = filter!.outputImage
        
        // calculate the scale of between size of imgQRCode.frame and qrcodeimage
        let scaleX = imgview.frame.size.width / self.qrcodeImage.extent.size.width
        let scaleY = imgview.frame.size.height / self.qrcodeImage.extent.size.height
        
        
        // change to fit the size of  qrcodeimage
        let transformedImage = self.qrcodeImage.imageByApplyingTransform(CGAffineTransformMakeScale(scaleX, scaleY))
        
        
        return UIImage(CIImage: transformedImage)
        
    }
    
    
    /**
     
     function: press background and alert controller will close
     
     */
    func alertControllerBackgroundTapped()
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    /**
        executed when qr code generate button is clicked
        - returns: 沒有
     */
    func qrcodeBtn(sender: AnyObject) {
        
        // define what to show in alert controller
        let alertMessage = UIAlertController(title: "請使用QR Code掃描器掃描！", message: "點擊背景以返回", preferredStyle: .Alert)
        
        let height:NSLayoutConstraint = NSLayoutConstraint(item: alertMessage.view, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 320)
        
        alertMessage.view.addConstraint(height)
        
        
        let imageView = UIImageView(frame: CGRectMake(35, 90, 200, 200))
        
        // call self.GenerateQRCode to return a UIImage
        imageView.image = self.GenerateQRCode(imageView)
        
        alertMessage.view.addSubview(imageView)
        
        self.presentViewController(alertMessage, animated: true, completion:{
            alertMessage.view.superview?.userInteractionEnabled = true
            alertMessage.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.alertControllerBackgroundTapped)))
        })
        
    }
    
    /**
     
        executed when qr code generate button is clicked
        change font size
        and store it in NSUserDefaults
     
     */
    func changeFontSize(sender: AnyObject) {
        
        
        
        let alertMessage = UIAlertController(title: "改變文字大小", message: "目前文字大小：\(self.getDefaultFontSizeString())", preferredStyle: .Alert)
        
        
        let sizeSmaller = UIAlertAction(title: "小", style: .Default, handler: { (action) -> Void in
            
            
            let script = "document.getElementById('body').style.fontSize = '19px'"
            self.articleFullWebView.stringByEvaluatingJavaScriptFromString(script)
            self.fontSizeString = "小"
            MoreTextSettingVC.storeFontSizetoUserDefaults(0)
        })
        
        let sizeNormal = UIAlertAction(title: "正常", style: .Default, handler: { (action) -> Void in
            let script = "document.getElementById('body').style.fontSize = '21px'"
            self.articleFullWebView.stringByEvaluatingJavaScriptFromString(script)
            self.fontSizeString = "正常"
            MoreTextSettingVC.storeFontSizetoUserDefaults(1)
        })
        
        let sizeBigger = UIAlertAction(title: "大", style: .Default, handler: { (action) -> Void in
            let script = "document.getElementById('body').style.fontSize = '24px'"
            self.articleFullWebView.stringByEvaluatingJavaScriptFromString(script)
            self.fontSizeString = "大"
            MoreTextSettingVC.storeFontSizetoUserDefaults(2)
        })
        
        let sizeBiggest = UIAlertAction(title: "最大", style: .Default, handler: { (action) -> Void in
            let script = "document.getElementById('body').style.fontSize = '29px'"
            self.articleFullWebView.stringByEvaluatingJavaScriptFromString(script)
            self.fontSizeString = "最大"
            MoreTextSettingVC.storeFontSizetoUserDefaults(3)
            
        })
        
        alertMessage.addAction(sizeSmaller)
        alertMessage.addAction(sizeNormal)
        alertMessage.addAction(sizeBigger)
        alertMessage.addAction(sizeBiggest)
        
        
        self.presentViewController(alertMessage, animated: true, completion:nil)
        // 若有點擊背景以返回功能，則會影響 alert 的 button 功能
        
        
    }
    

    
    /**
     
        add article to bookmark
     
     */
    func addToBookmark(sender: AnyObject) {
        
        
        if let bookmark = NSEntityDescription.insertNewObjectForEntityForName("BookmarkEntities", inManagedObjectContext: self.core_data) as? BookmarkEntities {
            
            // get the biggest autoIncrement in core data now
            let countRequest = NSFetchRequest(entityName: "BookmarkEntities")
            
            do {
                
                let fetchResults = try self.core_data.executeFetchRequest(countRequest) as? [BookmarkEntities]
                
                var biggest:Int? = 0
                
                for a_result in fetchResults!{
                    
                    if a_result.autoIncrement != nil {
                        if Int(a_result.autoIncrement!) > biggest {
                            biggest = Int(a_result.autoIncrement!)
                        }
                    }
                    
                }
                
                // autoIncrement = biggest +1
                if biggest != nil {
                    bookmark.autoIncrement = biggest! + 1
                }else{
                    bookmark.autoIncrement = 0
                }
                
            }catch{
                
                fatalError("Failure to save context: \(error)")
                // can not store
            }
            
            
            bookmark.id = currentIdString
            bookmark.time = currentTimeString
            bookmark.author = currentAuthorString
            bookmark.body = currentBodyString
            bookmark.title = currentTitleString
            bookmark.photo = currentPhotoString
            bookmark.division = currentDivisionString
            
            do {
                
                try self.core_data.save()
                // store
                
                self.showBarButtonItem()
                // reload bar button
                
            }catch{
                
                fatalError("Failure to save context: \(error)")
                // can not store
            }
            
            
            
        }
        
        
        
        
        
    }
    
    
    
    
    

    
    /**
     
     get user default setting for article font size
     - returns: String 小 正常 大 最大
     
     */
    func getDefaultFontSizeString() -> String {
        
        // userDefault basic variable object
        let userDefault = NSUserDefaults.standardUserDefaults()
        
        
        
        if let storedFontSize = userDefault.objectForKey("fontSizeUserDefaults") {
            
            switch storedFontSize as! Int {
            case 0:
                return "小"
            case 1:
                return "正常"
            case 2:
                return "大"
            case 3:
                return "最大"
            default:
                return "正常"
            }
        
        }else{
            return "正常"
        }
    }
    
    
    /**
     
      get user default font size in Int (px)
     
     - returns: Int, 19,21,24,29
     
     */
    func getDefaultFontSize() -> Int {
        
        // userDefault basic variable object
        let userDefault = NSUserDefaults.standardUserDefaults()
        
        
        
        if let storedFontSize = userDefault.objectForKey("fontSizeUserDefaults") {
            
            switch storedFontSize as! Int {
            case 0:
                return 19
            case 1:
                return 21
            case 2:
                return 24
            case 3:
                return 29
            default:
                return 21
            }
            
        }else{
            
            return 21
            // if key does not exist, return 21 (正常)
            
        }
        
        
    }
    
    
    
    /**
     
     delete article from bookmark
     
     */
    func deleteFromBookmark()
    {
        
        let deleteRequest = NSFetchRequest(entityName: "BookmarkEntities")
        deleteRequest.predicate = NSPredicate(format: "id == %@", currentIdString!)
        
        do {
            
            let results = try self.core_data.executeFetchRequest(deleteRequest) as! [BookmarkEntities]
            
            for result in results {
                
                self.core_data.deleteObject(result)
                
            }
            
            do {
                
                try self.core_data.save()
                
                self.showBarButtonItem()
                // reload show bar button
                
            }catch{
                
                fatalError("Failure to save context: \(error)")
            }
            
        }catch{
            
            fatalError("Failed to fetch data: \(error)")
            
        }
        
        
    }
    
    /**
     
     delete existing article from History
     
     */
    func deleteHistoryExist()
    {
        let deleteExistRequest = NSFetchRequest(entityName: "HistoryEntities")
        deleteExistRequest.predicate = NSPredicate(format: "id == %@", currentIdString!)
        
        
        // delete existing article from history
        do {
            
            let results = try self.core_data.executeFetchRequest(deleteExistRequest) as! [HistoryEntities]
         
            for result in results {
                
                self.core_data.deleteObject(result)
                
            }
            
            do {
                
                try self.core_data.save()
                
            }catch{
                
                fatalError("Failure to save context: \(error)")
                // can not store
            }
            
        }catch{
            
            fatalError("Failure to save context: \(error)")
            // can not store
        }
    }
    
    
    /**
     
     add article to History
     
     */
    func addToHistory()
    {
        
        
        
        if let history = NSEntityDescription.insertNewObjectForEntityForName("HistoryEntities", inManagedObjectContext: self.core_data) as? HistoryEntities {
            
            
            
            
            // find the biggest autoIncrement value in core data
            let countRequest = NSFetchRequest(entityName: "HistoryEntities")
            
            do {
                
                let fetchResults = try self.core_data.executeFetchRequest(countRequest) as? [HistoryEntities]
                
                var biggest:Int? = 0
                
                
                // find the biggest autoIncrement value in core data
                for a_result in fetchResults!{
                    
                    if a_result.autoIncrement != nil {
                        if Int(a_result.autoIncrement!) > biggest {
                            biggest = Int(a_result.autoIncrement!)
                            
                        }
                    }
                    
                }
                
                // define History autoIncrement = biggest +1
                if biggest != nil {
                    history.autoIncrement = biggest! + 1
                }else{
                    history.autoIncrement = 0
                }
                
                
            }catch{
                
                fatalError("Failure to save context: \(error)")
                // can not store
            }
            
            history.id = currentIdString
            history.time = currentTimeString
            history.author = currentAuthorString
            history.body = currentBodyString
            history.title = currentTitleString
            history.photo = currentPhotoString
            history.division = currentDivisionString
            
            do {
                
                try self.core_data.save()
                // store
                
            }catch{
                
                fatalError("Failure to save context: \(error)")
                // can not store
            }
            
            
            
            
        }
    }
    
    

    
    
    
    
    
}
