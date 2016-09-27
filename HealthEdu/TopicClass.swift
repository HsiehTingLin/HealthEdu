//
//  TopicClass.swift
//  本文件定義 topic 這個class
//  HealthEdu
//
//  Created by Yu-Ju Lin, Hsieh-Ting Lin.
//  Copyright © 2016年 衛教成大. All rights reserved.


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