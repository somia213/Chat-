//
//  RegisterViewController.swift
//  Chat
//
//  Created by Somia on 22/07/2024.
//

import UIKit

class RegisterViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var userFName: UITextField!
    
    @IBOutlet weak var userLName: UITextField!
    
    @IBOutlet weak var userEmail: UITextField!
    
    @IBOutlet weak var userPassword: UITextField!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        view.backgroundColor = .white
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(userImageTapped))
        userImage.isUserInteractionEnabled = true
        userImage.addGestureRecognizer(tapGesture)
    }
    
    @IBAction func registerBtn(_ sender: Any) {
        if !isValidName(userFName.text) {
            showAlert(message: "First name must contain only letters and spaces.")
            return
        }
        
        if !isValidName(userLName.text) {
            showAlert(message: "Last name must contain only letters and spaces.")
            return
        }
        
        if !isValidEmail(userEmail.text) {
            showAlert(message: "Email not correct.")
            return
        }
        
        if !isValidPassword(userPassword.text) {
            showAlert(message: "Password must contain letters, numbers, special characters, and be less than 9 characters.")
            return
        }
    }
    
    private func isValidName(_ name: String?) -> Bool {
        guard let name = name else { return false }
        let nameRegex = "^[a-zA-Z ]*$"
        let namePredicate = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        return namePredicate.evaluate(with: name)
    }
    
    private func isValidEmail(_ email: String?) -> Bool {
        guard let email = email else { return false }
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    private func isValidPassword(_ password: String?) -> Bool {
        guard let password = password else { return false }
        if password.count >= 9 { return false }
        
        let hasLetter = password.range(of: "[a-zA-Z]", options: .regularExpression) != nil
        let hasNumber = password.range(of: "[0-9]", options: .regularExpression) != nil
        let hasSpecialCharacter = password.range(of: "[^a-zA-Z0-9]", options: .regularExpression) != nil
        
        return hasLetter && hasNumber && hasSpecialCharacter
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "OOPS!!!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @objc func userImageTapped() {
        let actionSheet = UIAlertController(title: "Choose Source", message: nil, preferredStyle: .actionSheet)

        actionSheet.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { [weak self] _ in
            self?.takePhoto()
        }))

        actionSheet.addAction(UIAlertAction(title: "Choose from Gallery", style: .default, handler: { [weak self] _ in
            self?.chooseFromGallery()
        }))

        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        // For iPad: Set the sourceView and sourceRect
        if let popoverController = actionSheet.popoverPresentationController {
            popoverController.sourceView = self.userImage
            popoverController.sourceRect = self.userImage.bounds
        }

        present(actionSheet, animated: true, completion: nil)
    }

    func takePhoto() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            present(imagePicker, animated: true, completion: nil)
        } else {
            showAlert(message: "Camera not available.")
        }
    }

    func chooseFromGallery() {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }

    // MARK: - UIImagePickerControllerDelegate Methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[.editedImage] as? UIImage {
            userImage.image = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            userImage.image = originalImage
        }
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
