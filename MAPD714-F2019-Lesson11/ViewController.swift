//
//  ViewController.swift
//  MAPD714-F2019-Lesson11
//
//  Created by Pratiksha Kathiriya on 2019-11-20.
//  Copyright © 2019 CentennialCollege. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    
    //Login
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var showMessage: UILabel!
    
    //signUp
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var statusText: UILabel!
    
    @IBAction func signupButton(_ sender: Any)
    {
        guard let email = self.emailText.text, let password=self.passwordText.text
        else
        {
            self.statusText.text = "email/password can't be empty"
        return
        }
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
        // [START_EXCLUDE]
          guard let user = authResult?.user, error == nil else
          {
            self.statusText.text = error!.localizedDescription
            return
          }
            self.statusText.text = "\(user.email!) created"
        
        }
    }
    
    @IBAction func loginButton(_ sender: UIButton)
    {
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) { [weak self] authResult, error in
            
            //print(self!.email.text)
            //print(self!.password.text)
          //guard let strongSelf = self else { return }
          // [START_EXCLUDE]
         
            if let error = error
            {
                self!.showMessage.text = error.localizedDescription;              return
            }
            else
            {
                self!.showMessage.text = "Successful Login";
            }
        }
    }

    var handle: AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    
    
    
    func setTitleDisplay(_ user: User?) {
      if let name = user?.displayName {
        self.navigationItem.title = "Welcome \(name)"
      } else {
        self.navigationItem.title = "Authentication Example"
      }
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
      super.viewWillAppear(animated)
      // [START auth_listener]
      handle = Auth.auth().addStateDidChangeListener { (auth, user) in
      }
    }

    override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      // [START remove_auth_listener]
      Auth.auth().removeStateDidChangeListener(handle!)
      // [END remove_auth_listener]
    }
    
    
}

