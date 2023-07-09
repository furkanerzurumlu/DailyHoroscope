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
    
    @IBOutlet weak var twitterButton: UIButton!
    @IBOutlet weak var facbookButton: UIButton!
    @IBOutlet weak var githubButton: UIButton!
    
    
    @IBOutlet weak var signInButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setField(field: emailField, placeholder: "Email Address")
        setField(field: passwordField, placeholder: "Password")
        passwordField.isSecureTextEntry = true
        contiueButton.setTitle("Continue", for: UIControl.State.normal)
        signInButton.setTitle("Sign In", for: UIControl.State.normal)
        
//        twitterButton.setImage(UIImage(named: "twitter"), for: .normal)
//        twitterButton.setTitle("", for: UIControl.State.normal)
        setSocialMediaButton(button: twitterButton, name: "twitter")
        setSocialMediaButton(button: facbookButton, name: "facebook")
        setSocialMediaButton(button: githubButton, name: "github")
        
        setButton(button: signInButton)
        setButton(button: contiueButton)
        
        
        let backgroundColor = UIColor(rgb: 0xB799FF)
        self.view.backgroundColor = backgroundColor
        
        self.passwordField.setupLeftImage(imageName: "lock")
        self.emailField.setupLeftImage(imageName: "message")
        //        if FirebaseAuth.Auth.auth().currentUser != nil {
        //
        //        }
    }
    func setSocialMediaButton(button:UIButton,name:String){
        button.setImage(UIImage(named: name), for: UIControl.State.normal)
        button.setTitle("", for: UIControl.State.normal)
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

extension UITextField {
    
    //MARK:- Set Image on the right of text fields
    
    func setupRightImage(imageName:String){
        let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 20, height: 20))
        imageView.image = UIImage(named: imageName)
        let imageContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 55, height: 40))
        imageContainerView.addSubview(imageView)
        rightView = imageContainerView
        rightViewMode = .always
        self.tintColor = .lightGray
    }
    
    //MARK:- Set Image on left of text fields
    
    func setupLeftImage(imageName:String){
        let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 20, height: 20))
        imageView.image = UIImage(named: imageName)
        let imageContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 40))
        imageContainerView.addSubview(imageView)
        leftView = imageContainerView
        leftViewMode = .always
        self.tintColor = .lightGray
    }
    
}
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
