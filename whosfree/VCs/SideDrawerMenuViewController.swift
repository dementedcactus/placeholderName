//
//  SideDrawerMenuViewController.swift
//  whosfree
//
//  Created by Richard Crichlow on 3/16/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import Kingfisher
import FirebaseAuth

protocol dismissThenPresentChosenVC {
    func FriendListButtonPressed()
    func ProfileButtonPressed()
    func LogoutButtonPressed()
    func EventsButtonPressed()
}

class SideDrawerMenuViewController: UIViewController {
    
    var dismissThenPresentDelegate: dismissThenPresentChosenVC?
    
    private let sideDrawerMenuView = SideDrawerMenuView()
    
    let firebaseAuthService = FirebaseAuthService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firebaseAuthService.delegate = self
        setupView()
        self.view.backgroundColor = .clear
//        if FirebaseAuthService.getCurrentUser() != nil {
//            setupUserImageAndUsername()
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if FirebaseAuthService.getCurrentUser() != nil {
            setupUserImageAndUsername()
        }
    }
    
    private func setupUserImageAndUsername() {
        sideDrawerMenuView.usernameLabel.text = FirebaseAuthService.getCurrentUser()!.displayName
        DatabaseService.manager.getUserProfile(withUID: FirebaseAuthService.getCurrentUser()!.uid, completion: {
            self.sideDrawerMenuView.menuImageView.kf.setImage(with: URL(string: $0.profileImageUrl!), placeholder: nil, options: nil, progressBlock: nil, completionHandler: { (image, error, cache, url) in
            })
        })
    }
    
    private func setupView() {
        self.view.addSubview(sideDrawerMenuView)
        sideDrawerMenuView.dismissView.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        sideDrawerMenuView.eventButton.addTarget(self, action: #selector(eventsButtonAction), for: .touchUpInside)
        sideDrawerMenuView.profileButton.addTarget(self, action: #selector(profileButtonAction), for: .touchUpInside)
        sideDrawerMenuView.numFriendsButton.addTarget(self, action: #selector(numFriendsButtonAction), for: .touchUpInside)
        sideDrawerMenuView.logoutButton.addTarget(self, action: #selector(logoutButtonAction), for: .touchUpInside)
    }
    
    //Dismisses the SideDrawerMenuViewController
    @objc func dismissView() {
        
        // Dismiss Animation
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = kCATransitionReveal
        transition.subtype = kCATransitionFromRight
        transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        
        //Dismiss action
        dismiss(animated: true, completion: nil)
    }
    
    @objc func eventsButtonAction() {
        //TODO Present eventListViewController
        print("Event Button Works")
        
        self.dismissThenPresentDelegate?.EventsButtonPressed()
    }
    
    @objc func profileButtonAction() {
        //TODO Present profileViewController
        print("Profile Button Works")
        self.dismissThenPresentDelegate?.ProfileButtonPressed()
    }
    
    @objc func numFriendsButtonAction() {
        //TODO Present friendsViewController
        print("numFriends Button Works")
        
        self.dismissThenPresentDelegate?.FriendListButtonPressed()
        
    }
    
    @objc func logoutButtonAction() {
        //TODO Function for logout from firebase
        //TODO Pop all viewControllers and show SignInViewController
        //view.window?.rootViewController?.dismiss(animated: true, completion: nil)
        logout()
        print("logout Button Works")
        
    }
    
    private func logout() {
        let alertView = UIAlertController(title: "Are you sure you want to logout?", message: nil, preferredStyle: .alert)
        let yesOption = UIAlertAction(title: "Yes", style: .destructive) { (alertAction) in
            self.dismissThenPresentDelegate?.LogoutButtonPressed()
            self.firebaseAuthService.signOut()
        }
        let noOption = UIAlertAction(title: "No", style: .cancel, handler: nil)
        alertView.addAction(yesOption)
        alertView.addAction(noOption)
        present(alertView, animated: true, completion: nil)
    }
    
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { alert in }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
}

extension SideDrawerMenuViewController: FirebaseAuthServiceDelegate {
    func didSignOut(_ authService: FirebaseAuthService) {
        if FBSDKAccessToken.current() != nil {
            let loginManager = FBSDKLoginManager()
            loginManager.logOut()
        }
        sideDrawerMenuView.usernameLabel.text = ""
        sideDrawerMenuView.menuImageView.image = nil
        //view.window?.rootViewController?.dismiss(animated: true, completion: nil)
//        let signInVC = SignInViewController()
//        self.present(signInVC, animated: true, completion: nil)
    }
    func didFailSigningOut(_ authService: FirebaseAuthService, error: Error) {
        showAlert(title: "Error", message: error.localizedDescription)
    }
}

