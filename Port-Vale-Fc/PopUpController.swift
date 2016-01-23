//
//  PopUpController.swift
//  Port-Vale-Fc
//
//  Created by Steve Slack on 22/01/2016.
//  Copyright © 2016 Steve Slack. All rights reserved.
//

import Foundation
import UIKit

class PopUpController {
    
    private var _title: String
    private var _msg: String
    
    var title: String {
        
        get {
            return _title
        }
        
        set {
            self.title = _title
        }
    }
    
    var msg: String {
        
        return _msg
    }
    
    
    init(title: String, msg: String) {
        
        self._title = title
        self._msg = msg
        
    }
    
    
    func showAlertmsg(title: String ,msg: String ) {
    
        let alert = UIAlertController(title: _title, message: _msg, preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        alert.addAction(action)
        
    }

    
    
}