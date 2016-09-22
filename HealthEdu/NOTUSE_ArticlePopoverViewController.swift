//
//  ArticlePopoverViewController.swift
//  HealthEdu
//
//  Created by Yu-Ju Lin on 2016/9/22.
//  Copyright © 2016年 NCKU_hospital. All rights reserved.
//

import Foundation
import UIKit

protocol PopoverDelegate {
    func changeFontSizePop(fontSize: Int)
}

class ArticlePopoverViewController: UIViewController {
    
    var delegate: PopoverDelegate?
    
    @IBOutlet var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func changeFontSizePop(sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            delegate?.changeFontSizePop(19)
            
        case 1:
            delegate?.changeFontSizePop(21)
            
        case 2:
            delegate?.changeFontSizePop(25)
            
        default:
            break;
        }
        
    }



    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
