//
//  ViewController.swift
//  Port-Vale-Fc
//
//  Created by Steve Slack on 19/01/2016.
//  Copyright © 2016 Steve Slack. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase

class ViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        if NSUserDefaults.standardUserDefaults().valueForKey(KEY_UID) != nil {
            
            self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
        
        }
    }
    
    func showErrorAlert(title: String, msg: String) {
        
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert,animated: true, completion: nil)
        
    }
    

    @IBAction func emailBtnPressed(sender: AnyObject) {
        
        if let email = emailField.text where email != "", let pwd = passwordField.text where pwd != "" {
            
            DataService.ds.REF_BASE.authUser(email, password: pwd, withCompletionBlock: {error, authData in
                
                if (error != nil) {
                    // an error occurred while attempting login
                    if let errorCode = FAuthenticationError(rawValue: error.code) {
                        
                        switch (errorCode) {
                            
                        case .UserDoesNotExist:
                            
                            DataService.ds.REF_BASE.createUser(email, password: pwd, withValueCompletionBlock: {error, result  in
                                if error != nil {
                                    self.showErrorAlert("Could not create account", msg: "Problem creating account!")
                                }else {
                                    
                                    NSUserDefaults.standardUserDefaults().setValue(result[KEY_UID], forKey: KEY_UID)
                                    
                                    DataService.ds.REF_BASE.authUser(email, password: pwd, withCompletionBlock: nil)
                                    self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
                                    
                                }
                            })
                        case .InvalidEmail:
                            print("Handle invalid email")
                        case .InvalidPassword:
                            self.showErrorAlert("Ooops", msg: "Close! Please check the password!")
                        case .NetworkError:
                            self.showErrorAlert("Ooops", msg: "I'm unable to connect to the Internet")
                        default:
                            print("Handle default situation")
                        }
                    }
                } else {
                    self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
                }
            })
   
        }else {
            showErrorAlert("Email and Password Required", msg: "You must enter an email and password")
            
        }
        
    }
    
    
    
    @IBAction func fbLoginBtnPressed(sender: AnyObject) {
        
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logInWithReadPermissions(["email"]) { (facebookResult: FBSDKLoginManagerLoginResult!, facebookError: NSError!) -> Void in
            
            if facebookError != nil {
                print("Facebook Login Failed \(facebookError)")
            } else {
                let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
                
                print("Logged in with Facebook \(accessToken)")
                
                DataService.ds.REF_BASE.authWithOAuthProvider("facebook" , token: accessToken, withCompletionBlock: { error, authData in
                    
                    if error != nil {
                        print("Login Failed")
                
                        
                    } else {
                        
                        print("Logged in")
                        NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: KEY_UID)
                        self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
                    }
                    
                })
                
                
            }
            
        }
        
    }

}

