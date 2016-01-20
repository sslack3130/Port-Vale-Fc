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
        
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.whiteColor()], forState:.Normal)
        
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.whiteColor()], forState:.Selected)
        
    }
    
}