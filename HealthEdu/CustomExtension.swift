//
//  CustomExtension.swift
//  HealthEdu
//
//  Created by Yu-Ju Lin on 2016/10/1.
//  Copyright © 2016年 NCKU_hospital. All rights reserved.
//

import Foundation

extension String{
    
    var noHTMLtag: String { return  self.stringByReplacingOccurrencesOfString("<[^>]+>", withString: "", options: .RegularExpressionSearch, range: nil) }
    
    
}