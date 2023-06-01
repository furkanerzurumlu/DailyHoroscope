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
    @IBOutlet weak var titleNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setField(field: emailField, placeholder: "Email Address")
        setField(field: passwordField, placeholder: "Password")
        passwordField.isSecureTextEntry = true
        contiueButton.setTitle("Continue", for: UIControl.State.normal)
        setButton(button: contiueButton)
        
//        if FirebaseAuth.Auth.auth().currentUser != nil {
//
//        }
    }
    
    func setField(field:UITextField,placeholder:String){
        field.layer.cornerRadius = 20
        field.layer.borderWidth = 0.5
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = placeholder
        field.autocapitalizationType = .none
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        
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
                strongSelf.showCreateAccont(email: email, password: password)
//                Router.shared.showHomeFlow(navigationController: self?.navigationController)
                return
            }
            print("You have signed in")
//            strongSelf.emailField.isHidden = true
//            strongSelf.passwordField.isHidden = true
//            strongSelf.contiueButton.isHidden = true
        })
        
    }
    func showCreateAccont(email: String, password: String){
        let alert = UIAlertController(title: "Create Account", message: "Would you like to create an account", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { _ in
            FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: { [weak self] result, error in
                guard let strongSelf = self else {
                    return
                }
                guard error == nil else {
                    // show account creation
                    print("Account creation failed")
                    return
                }
                print("You have signed in")
                // lets go new page
                self?.performSegue(withIdentifier: "deneme", sender: nil)
                
//                strongSelf.emailField.isHidden = true
//                strongSelf.passwordField.isHidden = true
//                strongSelf.contiueButton.isHidden = true
//                strongSelf.titleNameLabel.isHidden = true
                self?.tabBarController?.tabBar.isHidden = false
            })
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel,handler: { _ in
            
        }))
        present(alert,animated: true)
    }
}

