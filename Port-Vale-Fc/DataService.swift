//
//  DataService.swift
//  Port-Vale-Fc
//
//  Created by Steve Slack on 20/01/2016.
//  Copyright © 2016 Steve Slack. All rights reserved.
//

import Foundation
import Firebase

let URL_BASE = "https://port-vale-fc.firebaseio.com"

class DataService {

    static let ds = DataService()
    
    private var _REF_BASE = Firebase(url: "\(URL_BASE)")
    private var _REF_POSTS = Firebase(url: "\(URL_BASE)/posts")
    private var _REF_USERS = Firebase(url: "\(URL_BASE)/users")
    
    
    
    var REF_BASE: Firebase {
        
        return _REF_BASE
    }
    
    var REF_POSTS: Firebase {
        return _REF_POSTS
    }
    
    var REF_USERS: Firebase {
        
        return _REF_USERS
    }
    
    var _REF_USER_CURRENT: Firebase {
        
        let uid = NSUserDefaults.standardUserDefaults().valueForKey(KEY_UID) as! String
        
            let user = Firebase(url: "\(URL_BASE)").childByAppendingPath("users").childByAppendingPath(uid)
            return user!
        
    }
    
    func createNewUser(uid: String, user: Dictionary<String, String>) {
        
        REF_USERS.childByAppendingPath(uid).setValue(user)
        
    }
    
}