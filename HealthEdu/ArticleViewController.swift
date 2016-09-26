//
//  ArticleViewController.swift
//  HealthEdu
//
//  Created by Mac on 2016/9/12.
//  Copyright © 2016年 NCKU_hospital. All rights reserved.
//

import UIKit
import CoreData

class ArticleViewController: UIViewController {
    
    // 變數定義區
    var currentIdString = ""
    var currentPhotoString = ""
    var currentDivisionString = ""
    var currentTitleString = ""
    var currentAuthorString = ""
    var currentBodyString = ""
    var currentTimeString = ""
    var currentPhotoUIImage = UIImage()
    //這裡先宣告一些變數，注意這裡的名字會被使用在資料來源的vc
    
    
    @IBOutlet var articleFullWebView: UIWebView!
    
    // 以下為 qrcodeImage 變數
    var qrcodeImage: CIImage!
    
    // 以下這個也是要傳遞過來的變數
    var articleIdforQRCode :String? = "http://myelin.tk/for_ncku_app_test/"
    
    var fontSizeString :String?
    
    
    
    // 給 core data (儲存文章) 功能使用
    let core_data = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    
    
    
    
    
    
    
    // 產生 QR Code 按鈕 button func
    func qrcodeBtn(sender: AnyObject) {
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
    
    // 改變文字大小 button func
    func changeFontSize(sender: AnyObject) {
        
        
        
        let alertMessage = UIAlertController(title: "改變文字大小", message: "目前文字大小：\(self.getDefaultFontSizeString())", preferredStyle: .Alert)
        
        
        let sizeSmaller = UIAlertAction(title: "小", style: .Default, handler: { (action) -> Void in
            
            
            let script = "document.getElementById('body').style.fontSize = '19px'";
            if let result = self.articleFullWebView.stringByEvaluatingJavaScriptFromString(script) {
                print("result is \(result)")
            }
            self.fontSizeString = "小"
            MoreTextSettingVC.storeFontSizetoUserDefaults(0)
        })
        
        let sizeNormal = UIAlertAction(title: "正常", style: .Default, handler: { (action) -> Void in
            let script = "document.getElementById('body').style.fontSize = '21px'";
            if let result = self.articleFullWebView.stringByEvaluatingJavaScriptFromString(script) {
                print("result is \(result)")
            }
            self.fontSizeString = "正常"
            MoreTextSettingVC.storeFontSizetoUserDefaults(1)
        })
        
        let sizeBigger = UIAlertAction(title: "大", style: .Default, handler: { (action) -> Void in
            let script = "document.getElementById('body').style.fontSize = '24px'";
            if let result = self.articleFullWebView.stringByEvaluatingJavaScriptFromString(script) {
                print("result is \(result)")
            }
            self.fontSizeString = "大"
            MoreTextSettingVC.storeFontSizetoUserDefaults(2)
        })
        
        let sizeBiggest = UIAlertAction(title: "最大", style: .Default, handler: { (action) -> Void in
            let script = "document.getElementById('body').style.fontSize = '29px'";
            if let result = self.articleFullWebView.stringByEvaluatingJavaScriptFromString(script) {
                print("result is \(result)")
            }
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
    
    // 顯示 article web view HTML
    func showarticleFullHTML(fontsize: Int){
        
        
        let photoSeparated:Array = currentPhotoString.componentsSeparatedByString(".")
        
        let photoPath :String? = NSBundle.mainBundle().pathForResource(photoSeparated[0], ofType: photoSeparated[1])
        
        
        let divWidth = self.view.frame.size.width-17
        let divHeight = 243
        let imgWidth = self.view.frame.size.width-17
        
        
        var articleFullHTMLarray = [String]()
        articleFullHTMLarray.append("<div width=\"\(divWidth)\" style=\"word-break: break-all;\"")
        
        
        articleFullHTMLarray.append("<br><p><div align=\"center\" style=\"font-size:35px; font-weight:bold;\">\(self.currentTitleString)</div></p>")
        articleFullHTMLarray.append("<p><div align=\"center\" style=\"color: gray; font-size:19px\">\(self.currentAuthorString)</div></p>")
        articleFullHTMLarray.append("<div align=\"center\" style=\"width:\(divWidth)px; height:\(divHeight)px; overflow:hidden;  \">")
        articleFullHTMLarray.append(NSString(format:"<img src=\"file://%@\" width=\"\(imgWidth)\">", photoPath!) as String)
        articleFullHTMLarray.append("</div>")
        articleFullHTMLarray.append("<div style='font-size: \(fontsize)px' id=\"body\"><p>\(self.currentBodyString)</p>")
        articleFullHTMLarray.append("<p>最後更新：\(self.currentTimeString)<br></p></div>")
        articleFullHTMLarray.append("</div>")
        
        
        let articleFullHTML = articleFullHTMLarray.joinWithSeparator("")
        
        self.fontSizeString = "正常"
        self.articleFullWebView.loadHTMLString(articleFullHTML, baseURL: nil)
        
    }
    
    // func 新增到書籤
    func addToBookmark(sender: AnyObject) {
        
        
        if let bookmark = NSEntityDescription.insertNewObjectForEntityForName("BookmarkEntities", inManagedObjectContext: self.core_data) as? BookmarkEntities {
            
            /*取得目前最高數量*/
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
                
                /* 指定新增的 history 的 autoIncrement 為 biggest + 1 */
                /* 預防 biggest 為 nil */
                if biggest != nil {
                    bookmark.autoIncrement = biggest! + 1
                }else{
                    bookmark.autoIncrement = 0
                }
                
            }catch{
                
                fatalError("Failure to save context: \(error)")
                // 無法儲存
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
                // 儲存
                
                self.showBarButtonItem()
                // 重整按鈕（bookmark 空心變成實心）
                
            }catch{
                
                fatalError("Failure to save context: \(error)")
                // 無法儲存
            }
            
            
            
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
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
       
        self.showBarButtonItem()
        
        
        
        // self.navigationItem.title = currentDivisionString
        // 顯示標題在此
        
        self.showarticleFullHTML(self.getDefaultFontSize())
        // 一開此頁面顯示文章，以 21 font-size顯示
        
        self.deleteHistoryExist()
        
        self.addToHistory()
        
        
    }
    

    func getDefaultFontSizeString() -> String {
        /* userDefault 初始化：儲存 預設 font size */
        let userDefault = NSUserDefaults.standardUserDefaults()
        // 初始化
        
        
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
    
    func getDefaultFontSize() -> Int {
        
        /* userDefault 初始化：儲存 預設 font size */
        let userDefault = NSUserDefaults.standardUserDefaults()
        // 初始化
        
        
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
            // 如果該 key 不存在的話，預設以 1 回傳
            
        }
        
        
    }
    
    
    
    func showBarButtonItem()
    {
        /*如果該文章已經被儲存在 core data 中，則顯示填滿的 書籤 icon*/
        let fetchRequest = NSFetchRequest(entityName: "BookmarkEntities")
        fetchRequest.predicate = NSPredicate(format: "id == %@", currentIdString)
        
        do {
            
            let fetchResults = try self.core_data.executeFetchRequest(fetchRequest) as? [BookmarkEntities]
            // 找尋
            
            var button1 = UIBarButtonItem()
            
            if fetchResults!.count > 0 {
                
                button1 = UIBarButtonItem(image: UIImage(named: "bookmark_black"), landscapeImagePhone: nil, style: .Done, target: self, action: #selector(self.deleteFromBookmark))
                
            }else{
                
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
            // 無法找尋
        }
    }
    
    func deleteFromBookmark()
    {
        
        let deleteRequest = NSFetchRequest(entityName: "BookmarkEntities")
        deleteRequest.predicate = NSPredicate(format: "id == %@", currentIdString)
        
        do {
            
            let results = try self.core_data.executeFetchRequest(deleteRequest) as! [BookmarkEntities]
            
            for result in results {
                
                self.core_data.deleteObject(result)
                
            }
            
            do {
                
                try self.core_data.save()
                
                self.showBarButtonItem()
                // 重整按鈕（bookmark 空心變成實心）
                
            }catch{
                
                fatalError("Failure to save context: \(error)")
            }
            
        }catch{
            
            fatalError("Failed to fetch data: \(error)")
            
        }
        
        
    }
    
    func deleteHistoryExist()
    {
        let deleteExistRequest = NSFetchRequest(entityName: "HistoryEntities")
        deleteExistRequest.predicate = NSPredicate(format: "id == %@", currentIdString)
        
        
        /* 刪除現存該文章之紀錄 */
        do {
            
            let results = try self.core_data.executeFetchRequest(deleteExistRequest) as! [HistoryEntities]
            print("-------")
            print(currentIdString)
            for result in results {
                print("刪除\(result.title)")
                self.core_data.deleteObject(result)
                
            }
            
            do {
                
                try self.core_data.save()
                
            }catch{
                
                fatalError("Failure to save context: \(error)")
                // 無法儲存
            }
            
        }catch{
            
            fatalError("Failure to save context: \(error)")
            // 無法儲存
        }
    }
    
    
    func addToHistory()
    {
        
        
        
        if let history = NSEntityDescription.insertNewObjectForEntityForName("HistoryEntities", inManagedObjectContext: self.core_data) as? HistoryEntities {
            
            
            
            
            /*取得目前最高數量*/
            let countRequest = NSFetchRequest(entityName: "HistoryEntities")
            
            do {
                
                let fetchResults = try self.core_data.executeFetchRequest(countRequest) as? [HistoryEntities]
                
                var biggest:Int? = 0
                
                
                /* 找出目前 core data 中，最大的 autoIncrment，做為排序用途 */
                for a_result in fetchResults!{
                    
                    if a_result.autoIncrement != nil {
                        if Int(a_result.autoIncrement!) > biggest {
                            biggest = Int(a_result.autoIncrement!)
                            
                        }
                    }
                    
                }
                print("biggest:\(biggest)")
                /* 指定新增的 history 的 autoIncrement 為 biggest + 1 */
                /* 預防 biggest 為 nil */
                if biggest != nil {
                    history.autoIncrement = biggest! + 1
                }else{
                    history.autoIncrement = 0
                }
                
                
            }catch{
                
                fatalError("Failure to save context: \(error)")
                // 無法儲存
            }
            
            history.id = currentIdString
            history.time = currentTimeString
            history.author = currentAuthorString
            history.body = currentBodyString
            history.title = currentTitleString
            history.photo = currentPhotoString
            history.division = currentDivisionString
            
            do {
                print("\(history.autoIncrement)\(history.title)！！新增")
                try self.core_data.save()
                // 儲存
                
            }catch{
                
                fatalError("Failure to save context: \(error)")
                // 無法儲存
            }
            
            
            
            
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
}
