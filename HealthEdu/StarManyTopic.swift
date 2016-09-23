//
//  StarManyTopic.swift
//  HealthEdu
//
//  Created by Yu-Ju Lin on 2016/9/21.
//  Copyright © 2016年 NCKU_hospital. All rights reserved.
//

import Foundation

class StarManyTopic {
    
    static func getTopicArray() -> [topic] {
        
        var topicArray = [topic]()
        
        let topic1 = topic(topicId: 1, topicTitle: "如何吃出健康人生？", topicPhoto: "Drug.jpg",  topicTime: "2016-09-19")
        
        let topic2 = topic(topicId: 2, topicTitle: "預防勝於治療，成醫教你免於生病", topicPhoto: "StemCell.jpg", topicTime: "2016-09-10")
        
        let topic3 = topic(topicId: 3, topicTitle: "你知道你的「家庭醫師」是誰嗎？", topicPhoto: "organ119.jpg" , topicTime: "2016-09-13")
        
        
        topicArray.append(topic1)
        topicArray.append(topic2)
        topicArray.append(topic3)
        
        return topicArray
        
    }
    
}