//
//  LoginViewController.swift
//  Chat
//
//  Created by Somia on 22/07/2024.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTF.isSecureTextEntry = true
        
    }
    
    
    @IBAction func loginBtn(_ sender: Any) {
        guard let email = emailTF.text, !email.isEmpty,
                     let password = passwordTF.text, !password.isEmpty else {
                   showAlert()
                   return
               }
    }
    
    @IBAction func registerBtn(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let registerVC = storyboard.instantiateViewController(withIdentifier: "RegisterVC") as? RegisterViewController {
            registerVC.modalPresentationStyle = .fullScreen
            present(registerVC, animated: true, completion: nil)
        }
    }
    
    private func showAlert() {
           let alert = UIAlertController(title: "OOPS!!!", message: "Email or password cannot be empty.", preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
           present(alert, animated: true, completion: nil)
       }
}
