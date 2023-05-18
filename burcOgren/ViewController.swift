//
//  ViewController.swift
//  burcOgren
//
//  Created by Furkan Erzurumlu on 18.05.2023.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var contiueButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setField(field: emailField, placeholder: "Email Address")
        setField(field: passwordField, placeholder: "Password")
        contiueButton.setTitle("Başla", for: UIControl.State.normal)
        setButton(button: contiueButton)
    }
    
    func setField(field:UITextField,placeholder:String){
        field.layer.cornerRadius = 20
        field.layer.borderWidth = 0.5
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = placeholder
        
    }
    
    func setButton(button:UIButton){
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.lightGray.cgColor
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        emailField.becomeFirstResponder()
    }
    
    @IBAction func nextPageAction(_ sender: Any) {
        print("Action")
        guard let email = emailField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty else{
            print("Missing field data")
            return
        }
        
        //Get auth instance
        //attempt sign in
        //if failure, present alert to create account
        //if user continues, create account
        
        //check sign in on app launch
        //allow user to sign out with button
        
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password,completion: { [weak self] result,error in
            guard let strongSelf = self else {
                return
            }
            guard error == nil else {
                // show account creation
                strongSelf.showCreateAccont()
                return
            }
            print("You have signed in")
        })
        
    }
    func showCreateAccont(){
        
    }
}

