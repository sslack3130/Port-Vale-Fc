//
//  SignUPVC.swift
//  Port-Vale-Fc
//
//  Created by Steve Slack on 22/01/2016.
//  Copyright © 2016 Steve Slack. All rights reserved.
//

import UIKit
import Firebase

class SignUPVC: UIViewController {

    @IBOutlet weak var activityMonitor: UIActivityIndicatorView!
    @IBOutlet weak var fullNameTxt: DesignTextField!
    @IBOutlet weak var emailAddrTxt: DesignTextField!
    @IBOutlet weak var passwordTxt: DesignTextField!
    @IBOutlet weak var confirmPasswordTxt: DesignTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
    }
    
    override func viewDidAppear(animated: Bool) {
        activityMonitor.hidden = true
    }
    
    func showErrorAlert(title: String, msg: String) {
        
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert,animated: true, completion: nil)
        
    }
    
    
    @IBAction func submitBtnPressed(sender: AnyObject) {
        activityMonitor.hidden = false
        activityMonitor.startAnimating()
        
        if let email = emailAddrTxt.text where email != "", let fullname = fullNameTxt.text where fullname != "", let passwrd = passwordTxt.text where passwrd != "", let confirmpasswrd = confirmPasswordTxt.text where confirmpasswrd != "" {
            
            if let password = passwordTxt.text where password != confirmPasswordTxt.text {
                
                self.showErrorAlert("Error", msg: "You're passwords do not match!")
                
            }
            
            DataService.ds.REF_BASE.createUser(email, password: passwrd, withValueCompletionBlock: {error, result  in
                
                if error != nil {
                    self.showErrorAlert("Could not create account", msg: "Problem creating account!")
                }else {
                    
                    NSUserDefaults.standardUserDefaults().setValue(result[KEY_UID], forKey: KEY_UID)
                    
                    DataService.ds.REF_BASE.authUser(email, password: passwrd, withCompletionBlock: {error, authData in
                        
//                    let user = [
//                        "provider": authData.provider!,
//                        "displayName": self.fullNameTxt.text]
                        
                        let user = ["provider": authData.provider!]
                        DataService.ds.createNewUser(authData.uid, user: user)
                       
                        
                        })
                    
                    self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
                    self.activityMonitor.stopAnimating()
                    
                }
            })

            
        } else {
        
        print("NEED FIELDS")
            print(emailAddrTxt.text)
            print(fullNameTxt.text)
        }
    }

    
}
