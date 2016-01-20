//
//  Login.swift
//  Port-Vale-Fc
//
//  Created by Steve Slack on 19/01/2016.
//  Copyright © 2016 Steve Slack. All rights reserved.
//

import Foundation

class Login {
    
    private var _userName: String!
    private var _password: String!
    
    
    var username: String {
        return _userName
    }
    
    var password: String {
        return _password
    }
    
    init(username: String, pass: String) {
        self._password = pass
        self._userName = username
    }
    
    
}
