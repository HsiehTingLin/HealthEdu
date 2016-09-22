//
//  TopicClass.swift
//  HealthEdu
//
//  Created by Mac on 2016/9/18.
//  Copyright © 2016年 NCKU_hospital. All rights reserved.
// 本文件定義 topic 這個class

import Foundation

class topic {
    
    var topicId : Int
    var topicTitle : String
    var topicPhoto : String
    var topicTime : String
    
    
    init (topicId: Int, topicTitle: String, topicPhoto : String, topicTime: String){
        
        self.topicId = topicId
        self.topicTitle = topicTitle
        self.topicPhoto = topicPhoto
        self.topicTime = topicTime
        
    }
    
}