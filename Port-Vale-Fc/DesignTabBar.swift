//
//  DesignTabBar.swift
//  Port-Vale-Fc
//
//  Created by Steve Slack on 20/01/2016.
//  Copyright © 2016 Steve Slack. All rights reserved.
//

import Foundation
import UIKit

class DesignTabBar: UITabBarItem {

    override func awakeFromNib() {
        
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.grayColor()], forState:.Normal)
        
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor(red: 227 / 255, green: 158 / 225, blue: 16 / 255, alpha: 1.0)], forState:.Selected)
        
    }
    
}