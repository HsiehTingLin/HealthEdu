//
//  CustomExtension.swift
//  HealthEdu
//
//  Created by Yu-Ju Lin on 2016/10/1.
//  Copyright © 2016年 NCKU_hospital. All rights reserved.
//

import Foundation
import UIKit

extension String{
    
    var noHTMLtag: String { return  self.stringByReplacingOccurrencesOfString("<[^>]+>", withString: "", options: .RegularExpressionSearch, range: nil) }
    
    
}

 extension UIImageView {
    public func imageFromServerURL(view: UIImageView, urlString: String, completionHandler: UIImage -> Void) {
        
            if(urlString == ""){
            
                // when there is no provided photo url
                let image = UIImage(named: "DefaultPhotoForArticle")
                self.image = image
                completionHandler(image!)
                
            }else{

                // photo url exist
                // execute download
                NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: urlString)!, completionHandler: { (data, response, error) -> Void in

                    if error != nil {
                        print(error)
                        return
                    }
                
                    // update UI
                    dispatch_async(dispatch_get_main_queue(), {
                        () -> Void in
                    
                        let image = UIImage(data: data!)

                        // image view transition animate
                        UIImageView.transitionWithView(
                            
                            view,
                            
                            duration: 3.0,
                            
                            options: .TransitionCrossDissolve,
                            
                            animations: {
                                self.alpha = 0.3
                                self.image = image
                                self.alpha = 1.0
                            },
                            
                            completion: nil
                            
                        )
                        
                        
                        completionHandler(image!)
                    
                    })

                }).resume()
            
            }
        }
}