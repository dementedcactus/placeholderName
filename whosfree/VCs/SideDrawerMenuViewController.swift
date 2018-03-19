//
//  SideDrawerMenuViewController.swift
//  whosfree
//
//  Created by Richard Crichlow on 3/16/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit

class SideDrawerMenuViewController: UIViewController {
    
    let sideDrawerMenuView = SideDrawerMenuView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        self.view.backgroundColor = .clear
    }
    
    private func setupView() {
        self.view.addSubview(sideDrawerMenuView)
        sideDrawerMenuView.dismissView.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
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
    
    @objc func profileButtonAction() {
        //TODO Present profileViewController
        print("Profile Button Works")
    }
    
    @objc func numFriendsButtonAction() {
        //TODO Present friendsViewController
        print("numFriends Button Works")
    }
    
    @objc func logoutButtonAction() {
        //TODO Function for logout from firebase
        //TODO Pop all viewControllers and show SignInViewController
        print("logout Button Works")
    }
}
