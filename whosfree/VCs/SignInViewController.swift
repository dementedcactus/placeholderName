//
//  SignInViewController.swift
//  LuisWhosFreeViewControllers
//
//  Created by Luis Calle on 3/16/18.
//  Copyright © 2018 Lucho. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit
import FBSDKCoreKit

class SignInViewController: UIViewController {
    
    let signInView = SignInView()
    
    let imagePicker = UIImagePickerController()
    
    let firebaseAuthService = FirebaseAuthService()
    
    // https://stackoverflow.com/questions/35561977/how-do-i-make-a-keyboard-push-the-view-up-when-it-comes-on-screen-xcode-swift
    // reference for keyboard handling
    var keyboardAdjusted = false
    var lastKeyboardOffset: CGFloat = 0.0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if keyboardAdjusted == false {
            lastKeyboardOffset = getKeyboardHeight(notification: notification)
            view.frame.origin.y -= lastKeyboardOffset
            keyboardAdjusted = true
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if keyboardAdjusted == true {
            view.frame.origin.y += lastKeyboardOffset
            keyboardAdjusted = false
        }
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(signInView)
        signInView.signUpContainerView.isHidden = true
        imagePicker.delegate = self
        firebaseAuthService.delegate = self
        setTextFieldsDelegates()
        setTextFieldTags()
        signInView.signInContainerView.facebookLoginButton.delegate = self
        setupButtonsActions()
        setupProfileImageGestureRecognizer()
    }
    
    private func setTextFieldsDelegates() {
        signInView.signInContainerView.emailLoginTextField.delegate = self
        signInView.signInContainerView.passwordTextField.delegate = self
        signInView.signUpContainerView.usernameTextField.delegate = self
        signInView.signUpContainerView.firstNameTextField.delegate = self
        signInView.signUpContainerView.lastNameTextField.delegate = self
        signInView.signUpContainerView.emailLoginTextField.delegate = self
        signInView.signUpContainerView.passwordTextField.delegate = self
        signInView.signUpContainerView.verifyPasswordTextField.delegate = self
    }
    
    private func setTextFieldTags() {
        signInView.signInContainerView.emailLoginTextField.tag = 0
        signInView.signInContainerView.passwordTextField.tag = 1
        signInView.signUpContainerView.usernameTextField.tag = 3
        signInView.signUpContainerView.firstNameTextField.tag = 4
        signInView.signUpContainerView.lastNameTextField.tag = 5
        signInView.signUpContainerView.emailLoginTextField.tag = 6
        signInView.signUpContainerView.passwordTextField.tag = 7
        signInView.signUpContainerView.verifyPasswordTextField.tag = 8
    }
    
    private func setupButtonsActions() {
        signInView.loginContainerButton.alpha = 1.0
        signInView.createAccountContainerButton.alpha = 0.35
        signInView.loginContainerButton.addTarget(self, action: #selector(showLogin), for: .touchUpInside)
        signInView.createAccountContainerButton.addTarget(self, action: #selector(showSignUp), for: .touchUpInside)
        signInView.signUpContainerView.signUpButton.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        signInView.signInContainerView.loginButton.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        signInView.signInContainerView.forgotPasswordButton.addTarget(self, action: #selector(forgotPassword), for: .touchUpInside)
    }
    
    @objc private func showLogin() {
        signInView.signUpContainerView.isHidden = true
        signInView.signInContainerView.isHidden = false
        signInView.loginContainerButton.alpha = 1.0
        signInView.createAccountContainerButton.alpha = 0.35
    }
    
    @objc private func showSignUp() {
        signInView.signInContainerView.isHidden = true
        signInView.signUpContainerView.isHidden = false
        signInView.createAccountContainerButton.alpha = 1.0
        signInView.loginContainerButton.alpha = 0.35
    }
    
    @objc private func signUp() {
        print("Sign up button pressed")
        guard let emailText = signInView.signUpContainerView.emailLoginTextField.text else {
            print("E-mail is nil")
            return
        }
        guard !emailText.isEmpty else {
            print("E-mail field is empty")
            return
        }
        guard let passwordText = signInView.signUpContainerView.passwordTextField.text else {
            print("Password is nil")
            return
        }
        guard !passwordText.isEmpty else {
            print("Password field is empty")
            return
        }
        guard let verifyPasswordText = signInView.signUpContainerView.verifyPasswordTextField.text else {
            print("Verify password is nil")
            return
        }
        guard !verifyPasswordText.isEmpty else {
            print("Verify password field is empty")
            return
        }
        guard passwordText == verifyPasswordText else {
            print("Password don't match")
            return
        }
        let username = signInView.signUpContainerView.usernameTextField.text
        let fName = signInView.signUpContainerView.firstNameTextField.text
        let lname = signInView.signUpContainerView.lastNameTextField.text
        let userImage = signInView.signUpContainerView.profileImageView.image
        firebaseAuthService.createUser(email: emailText, password: passwordText, firstName: fName ?? "", lastName: lname ?? "", username: username!, userImage: userImage ?? #imageLiteral(resourceName: "profilePlaceholder"))
    }
    
    @objc private func signIn() {
        print("Sign in button pressed")
        guard let passwordText = signInView.signInContainerView.passwordTextField.text else {
            print("password is nil")
            return
        }
        guard !passwordText.isEmpty else {
            print("Password field is empty")
            return
        }
        firebaseAuthService.signIn(email: signInView.signInContainerView.emailLoginTextField.text!, password: passwordText)
    }
    
    
    @objc private func forgotPassword() {
        let alertController = UIAlertController(title: "Reset Password", message: "Do you want to reset your password?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Reset", style: .destructive) { alert in
            self.firebaseAuthService.resetPassword(with: self.signInView.signInContainerView.emailLoginTextField.text!)
        }
        let noAction = UIAlertAction(title: "No", style: .default) { alert in }
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        present(alertController, animated: true, completion: nil)
    }
    
    private func setupProfileImageGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped(tapGestureRecognizer:)))
        signInView.signUpContainerView.profileImageView.isUserInteractionEnabled = true
        signInView.signUpContainerView.profileImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func profileImageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let profileImageAlertController = UIAlertController(title: "Add Profile Image", message: nil, preferredStyle: .alert)
        let fromCameraRollAction = UIAlertAction(title: "From camera roll", style: .default) { (alertAction) in
            self.imagePicker.allowsEditing = true
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        let fromLaunchCameraAction = UIAlertAction(title: "Take a picture", style: .default) { (alertAction) in
            self.imagePicker.allowsEditing = true
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        profileImageAlertController.addAction(fromCameraRollAction)
        profileImageAlertController.addAction(fromLaunchCameraAction)
        profileImageAlertController.addAction(cancelAction)
        present(profileImageAlertController, animated: true, completion: nil)
    }
    
    private func showAlert(title: String, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) {alert in }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    private func clearSignUpFields() {
        signInView.signUpContainerView.emailLoginTextField.text = ""
        signInView.signUpContainerView.passwordTextField.text = ""
        signInView.signUpContainerView.verifyPasswordTextField.text = ""
        signInView.signUpContainerView.firstNameTextField.text = ""
        signInView.signUpContainerView.lastNameTextField.text = ""
        signInView.signUpContainerView.profileImageView.image = #imageLiteral(resourceName: "profilePlaceholder")
    }
    
}


// MARK:- Firebase Auth delegate functions
extension SignInViewController: FirebaseAuthServiceDelegate {
    
    func didCreateUser(_ authService: FirebaseAuthService, user: User) {
        print("didCreateUser: \(user)")
        FirebaseAuthService.getCurrentUser()!.sendEmailVerification(completion: {(error) in
            if let error = error {
                print("Error sending email verification, \(error)")
                self.showAlert(title: "Error", message: "Error sending email verification")
            } else {
                print("E-mail verification sent")
                self.showAlert(title: "Verification Sent", message: "Please verify email")
                self.showLogin()
                self.clearSignUpFields()
            }
            //self.firebaseAuthService.signOut()
        })
    }
    
    func didFailCreatingUser(_ authService: FirebaseAuthService, error: Error) {
        showAlert(title: error.localizedDescription, message: nil)
    }
    
    func didSignIn(_ authService: FirebaseAuthService, user: User) {
        if FirebaseAuthService.getCurrentUser()!.isEmailVerified {
            self.dismiss(animated: true, completion: nil)
        } else {
            showAlert(title: "E-mail Verification Needed", message: "Please verify e-mail")
            firebaseAuthService.signOut()
        }
    }
    
    func didFailSignIn(_ authService: FirebaseAuthService, error: Error) {
        showAlert(title: error.localizedDescription, message: nil)
    }
    
    func didSignInFacebook(_ authService: FirebaseAuthService, user: User) {
        // TODO: Add facebook user info
        
        //        FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, email"]).start(completionHandler: { (connection, result, error) -> Void in
        //            if (error == nil){
        //                let fbDetails = result as! NSDictionary
        //                print(fbDetails)
        //            }
        //        })
        
        
        //TODO: uncomment to add facebook user
        DatabaseService.manager.addFacebookUser()
        self.dismiss(animated: true, completion: nil)
    }
    
    func didFailSignInFacebook(_ authService: FirebaseAuthService, error: Error) {
        showAlert(title: error.localizedDescription, message: nil)
    }
    
    func didSendResetPassword(_ authService: FirebaseAuthService) {
        showAlert(title: "Password Reset", message: "Reset e-mail sent, check spam inbox!")
    }
    
    func didFailSendResetPassword(_ authService: FirebaseAuthService, error: Error) {
        showAlert(title: "Error", message: error.localizedDescription)
    }
}

// MARK:- Image Picker delegate functions
extension SignInViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let imageSelected = info[UIImagePickerControllerEditedImage] as? UIImage else {
            print("Error selecting picture")
            return
        }
        signInView.signUpContainerView.profileImageView.image = imageSelected
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension SignInViewController: FBSDKLoginButtonDelegate {
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error?) {
        
        if (error == nil){
            let fbloginresult : FBSDKLoginManagerLoginResult = result
            if result.isCancelled {
                return
            }
            if(fbloginresult.grantedPermissions.contains("email")) {
                //self.getFBUserData()
            }
        }
        
        let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        firebaseAuthService.signInWithFacebook(with: credential)
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("logged out facebook")
    }
}

// https://stackoverflow.com/questions/31766896/switching-between-text-fields-on-pressing-return-key-in-swift
// reference for jumping through textfields using return key
extension SignInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
        }
        // Do not add a line break
        return false
    }
}


