//
//  ConverstionsViewController.swift
//  Chat
//
//  Created by Somia on 22/07/2024.
//

import UIKit

class ConverstionsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        view.backgroundColor = .red
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let isLoggedIn = UserDefaults.standard.bool(forKey:"logged_in")
        
        if !isLoggedIn{
            directToLoginViewController()
        }
    }
    
    private func directToLoginViewController() {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginVC") as? LoginViewController {
                loginVC.modalPresentationStyle = .fullScreen 
                present(loginVC, animated: true, completion: nil)
            }
        }

}
