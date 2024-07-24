//
//  LoginViewController.swift
//  Chat
//
//  Created by Somia on 22/07/2024.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func registerBtn(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let registerVC = storyboard.instantiateViewController(withIdentifier: "RegisterVC") as? RegisterViewController {
            registerVC.modalPresentationStyle = .fullScreen
            present(registerVC, animated: true, completion: nil)
        }
    }
}
