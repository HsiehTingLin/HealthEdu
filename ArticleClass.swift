//
//  ArticleClass.swift
//  HealthEdu
//
//  Created by Mac on 2016/9/11.
//  Copyright © 2016年 NCKU_hospital. All rights reserved.
//  目前還有 division、time的 var還沒加，如果要幫每個文章加的話就要

import Foundation
import UIKit

class article {
    
    var id : String
    // 新增id，String先用Int好了，因為我很懶惰，到時候要轉 int 也不難就是了
    
    var title : String
    var photo : String
    var photoUIImage : UIImage
    // 新增 photoUIImage 因為在 未來圖片是當場從網路下載，下載完成會立刻將它轉換成 UIImage
    // 所以需要有一個變數儲存這個
    
    var author : String
    var body : String
    var time : String
    var division : String
    
    init (id: String, title: String, photoUIImage : UIImage, photo : String, author : String, body : String, time: String, division: String){
        
        self.id = id
        self.title = title
        self.photo = photo
        self.photoUIImage = photoUIImage
        self.author = author
        self.body = body
        self.time = time
        self.division = division
    }
    
}
