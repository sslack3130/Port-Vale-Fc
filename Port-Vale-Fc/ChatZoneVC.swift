//
//  ChatZoneVC.swift
//  Port-Vale-Fc
//
//  Created by Steve Slack on 23/01/2016.
//  Copyright © 2016 Steve Slack. All rights reserved.
//

import UIKit
import Firebase

class ChatZoneVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var postTextField: DesignTextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var selectImgBtn: UIImageView!
    var posts = [Posts]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        DataService.ds.REF_POSTS.observeEventType(.Value, withBlock: { snapshot in
         print(snapshot.value)
            
            self.posts = []
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                
                for snap in snapshots {
                    print("SNAP:\(snap)")
                    
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        
                        let key = snap.key
                        let post = Posts(postKey: key, dictionary: postDict)
                        self.posts.append(post)
                        
                    }
                    
                }
            }
            
            self.tableView.reloadData()
        })

    }
    
    @IBAction func postBtn(sender: AnyObject) {
        
        if let txt = postTextField.text where txt != "" {
            
            self.postToFirebase()
            
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let post = posts[indexPath.row]
       
        if let cell = tableView.dequeueReusableCellWithIdentifier("ChatCells") as? ChatCell {
            
            cell.configureCell(post)
            return cell
        }else
        {
            return ChatCell()
        }

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func postToFirebase(){
        
        let post: Dictionary<String, AnyObject> = [
        "description": postTextField.text!,
        "likes": 0]
        
        let firebasePost = DataService.ds.REF_POSTS.childByAutoId()
        firebasePost.setValue(post)
        
        postTextField.text = ""

        tableView.reloadData()
        
        }
            
}
        



