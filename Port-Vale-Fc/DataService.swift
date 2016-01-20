//
//  DataService.swift
//  Port-Vale-Fc
//
//  Created by Steve Slack on 20/01/2016.
//  Copyright © 2016 Steve Slack. All rights reserved.
//

import Foundation
import Firebase

class DataService {
    
    static let ds = DataService()
    
    private var _REF_BASE = Firebase(url: FIREBASE_URL)
    
    var REF_BASE: Firebase {
        
        return _REF_BASE
    }
    
}