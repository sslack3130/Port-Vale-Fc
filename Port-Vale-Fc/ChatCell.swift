//
//  ChatCell.swift
//  Port-Vale-Fc
//
//  Created by Steve Slack on 23/01/2016.
//  Copyright © 2016 Steve Slack. All rights reserved.
//

import UIKit
import Firebase

class ChatCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var descriptionTxt: UITextView!
    @IBOutlet weak var likesLbl: UILabel!
    @IBOutlet weak var likeImg: UIImageView!
    
    var post: Posts!
    var likeRefs: Firebase!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tap = UITapGestureRecognizer(target: self, action: "likeTapped:" )
        tap.numberOfTapsRequired = 1
        likeImg.addGestureRecognizer(tap)
        likeImg.userInteractionEnabled = true
        
    }
    
    override func drawRect(rect: CGRect) {
        
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
        profileImage.clipsToBounds = true
    }

    func configureCell(post: Posts) {
        self.post = post
        likeRefs = DataService.ds._REF_USER_CURRENT.childByAppendingPath("likes").childByAppendingPath(post.postKey)
        
        self.descriptionTxt.text = post.postDescription
        self.likesLbl.text = "\(post.likes)"
        
        let likeRef = DataService.ds._REF_USER_CURRENT.childByAppendingPath("likes").childByAppendingPath(post.postKey)
        likeRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
        
            // In firebase if there is no data it returns NSNULL
            
            if let doesNotExist = snapshot.value as? NSNull {
                
                self.likeImg.image = UIImage(named: "Like-Empty")
            } else{
                self.likeImg.image = UIImage(named:"Like-full")
            }
        })
  
    }
    
    func likeTapped(sender: UITapGestureRecognizer) {
        likeRefs.observeSingleEventOfType(.Value, withBlock: { snapshot in

        if let doesNotExist = snapshot.value as? NSNull {

             self.likeImg.image = UIImage(named:"Like-full")
            self.post.adjustLikes(true)
            self.likeRefs.setValue(true)
        } else {
            self.likeImg.image = UIImage(named: "Like-Empty")
            self.post.adjustLikes(false)
            self.likeRefs.removeValue()
        }
        
    })
    
    
            
        }

}

