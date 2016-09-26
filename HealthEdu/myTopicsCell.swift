//
//  myTopicsCell.swift
//  HealthEdu
//
//  Created by Mac on 2016/9/18.
//  Copyright © 2016年 NCKU_hospital. All rights reserved.
//  本文件定義在topic顯示列中的prototype cell的一些形式

import UIKit

class myTopicsCell: UITableViewCell {
    
    
    @IBOutlet weak var opacityhalf: UIImageView!
    @IBOutlet weak var topicTitleIBO: UILabel!
    @IBOutlet weak var topicPhotoIBO: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
