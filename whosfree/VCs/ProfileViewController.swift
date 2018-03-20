//
//  ProfileViewController.swift
//  whosfree
//
//  Created by Richard Crichlow on 3/16/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let friendsArr = ["Bob", "Maryann", "Lisa", "Luis", "Richard"]
    
    let profileView = ProfileView()
    //    let friendCollectionViewCells = ProfileCollectionViewCells()
    
    let sideMenu = SideDrawerMenuViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(profileView)
        self.profileView.friendsCollectionView.dataSource = self
        self.profileView.friendsCollectionView.delegate = self
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(presentMenu))
        sideMenu.dismissThenPresentDelegate = self
        //setupNavBar()
    }
    
    private func setupNavBar() {
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.tintColor = UIColor.white
        let navBarWidth = navigationController?.navigationBar.bounds.width ?? 75
        let navBarHeight = navigationController?.navigationBar.bounds.height ?? 75
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: (navBarWidth), height: (navBarHeight)))
        let titleImageView = UIImageView()
        titleImageView.frame = CGRect(x: 0, y: 0, width: titleView.frame.width, height: titleView.frame.height)
        titleImageView.contentMode = .scaleAspectFit
        titleImageView.image = #imageLiteral(resourceName: "appTextLogoOriginal")
        titleView.addSubview(titleImageView)
        navigationItem.titleView = titleView
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editProfileItems))
    }
    
    @objc private func editProfileItems() {
        //editProfileItems
    }
    
    @objc private func presentMenu() {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = kCATransitionMoveIn
        transition.subtype = kCATransitionFromLeft
        transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        sideMenu.modalTransitionStyle = .crossDissolve
        sideMenu.modalPresentationStyle = .overCurrentContext
        present(sideMenu, animated: false, completion: nil)
    }
    
    
}

extension ProfileViewController: dismissThenPresentChosenVC {
    func ProfileButtonPressed() {
        sideMenu.dismissView()
    }
    
    func EventsButtonPressed() {
        sideMenu.dismissView()
        let eventListVC = EventListViewController()
        eventListVC.modalTransitionStyle = .crossDissolve
        eventListVC.modalPresentationStyle = .overCurrentContext
        navigationController?.pushViewController(eventListVC, animated: true)
    }
    
    func LogoutButtonPressed() {
        sideMenu.dismissView()
        let signInVC = SignInViewController()
        self.present(signInVC, animated: true, completion: nil)
    }
    
    func FriendListButtonPressed() {
        print("Delegate Working")
        sideMenu.dismissView()
        let friendListVC = FriendListViewController()
        friendListVC.modalTransitionStyle = .crossDissolve
        friendListVC.modalPresentationStyle = .overCurrentContext
        navigationController?.pushViewController(friendListVC, animated: true)
    }
}

extension ProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return friendsArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let friendCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendsCollectionViewCell", for: indexPath) as! FriendsCollectionViewCell
        let friendInfo = friendsArr[indexPath.row]
        friendCell.friendLabel.text = friendInfo
        return friendCell
    }
    
}

private let cellSpacing: CGFloat =  5.0

extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let numCells: CGFloat = 3
        let numSpaces: CGFloat = numCells + 1
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        return CGSize(width: (screenWidth - (cellSpacing * numSpaces)) / numCells, height: screenHeight * 0.25)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: cellSpacing, left: cellSpacing, bottom: 0, right: cellSpacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
    
}

