//
//  TopicClass.swift
//  HealthEdu
//
//  Created by Mac on 2016/9/18.
//  Copyright © 2016年 NCKU_hospital. All rights reserved.
// 本文件定義 topic 這個class 

import Foundation

import Foundation
class topic {
    var topicTitle : String
    var topicPhoto : String
    var topicAuthor : String
    var topicBody : String
    var topicTime : String
    var topicDivision : String
    init (topicTitle: String, topicPhoto : String, topicAuthor : String, topicBody : String, topicTime: String, topicDivision: String){
        self.topicTitle = topicTitle
        self.topicPhoto = topicPhoto
        self.topicAuthor = topicAuthor
        self.topicBody = topicBody
        self.topicTime = topicTime
        self.topicDivision = topicDivision
    }
    
}