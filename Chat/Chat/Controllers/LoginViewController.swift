//
//  LoginViewController.swift
//  Chat
//
//  Created by Somia on 22/07/2024.
//

import UIKit
import FirebaseAuth

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
            showAlert(title: "OOPS!!!", message: "Email or password cannot be empty.")
            return
        }
        
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else {
                return
            }
            if let error = error {
                strongSelf.showAlert(title: "Login Failed", message: "Email or password is incorrect. Please try again.")
                print("Login error: \(error.localizedDescription)")
            } else {
                strongSelf.showAlert(title: "Success", message: "You have logged in successfully!")
                strongSelf.navigationController?.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func registerBtn(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let registerVC = storyboard.instantiateViewController(withIdentifier: "RegisterVC") as? RegisterViewController {
            registerVC.modalPresentationStyle = .fullScreen
            present(registerVC, animated: true, completion: nil)
        }
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
