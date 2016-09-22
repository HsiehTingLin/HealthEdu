//
//  SearchResultCell.swift
//  HealthEdu
//
//  Created by Mac on 2016/9/18.
//  Copyright © 2016年 NCKU_hospital. All rights reserved.
//

import UIKit

class SearchResultCell: UITableViewCell {

    @IBOutlet weak var searchResultCellPhoto: UIImageView!
    
    @IBOutlet weak var searchResultCellTitle: UILabel!
    
    @IBOutlet weak var searchResultCellAuthor: UILabel!
    
    
    @IBOutlet weak var searchResultCellBody: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
