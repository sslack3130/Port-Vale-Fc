//
//  Posts.swift
//  Port-Vale-Fc
//
//  Created by Steve Slack on 24/01/2016.
//  Copyright © 2016 Steve Slack. All rights reserved.
//

import Foundation
import Firebase

class Posts {
    
    private var _postDescription: String!
    private var _likes: Int!
    private var _username: String!
    private var _postKey: String!
    private var _postRef: Firebase!
    
    
    var postDescription: String {
        
        return _postDescription
        
    }
    
    var likes: Int {
        
        return _likes
    }
    
    var username: String {
        
        return _username
    }
    
    var postKey: String {
        
        return _postKey
    }
    
    init(description: String, username: String) {
        
        self._postDescription = description
        self._username = username
    }
    
    init(postKey: String, dictionary: Dictionary<String, AnyObject>) {
        
        self._postKey = postKey
        
        if let likes = dictionary["likes"] as? Int {
            self._likes = likes
            
        }
        
        if let description = dictionary["description"] as? String {
            self._postDescription = description
        }
        
        self._postRef = DataService.ds.REF_POSTS.childByAppendingPath(self._postKey)
    }
    
    func adjustLikes(addLike: Bool){
        
        if addLike {
            _likes = _likes + 1
        }else {
            _likes = _likes - 1
        }
        
        _postRef.childByAppendingPath("likes").setValue(_likes)
    }
    
    
}