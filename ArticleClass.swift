//
//  ArticleClass.swift
//  HealthEdu
//
//  Created by Mac on 2016/9/11.
//  Copyright © 2016年 NCKU_hospital. All rights reserved.
//  目前還有 division、time的 var還沒加，如果要幫每個文章加的話就要

import Foundation
class article {
    var title : String
    var photo : String
    var author : String
    var body : String
    init (title: String, photo : String, author : String, body : String){
        self.title = title
        self.photo = photo
        self.author = author
        self.body = body
    }
    
}
