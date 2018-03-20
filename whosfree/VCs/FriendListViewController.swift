//
//  FriendListViewController.swift
//  whosfree
//
//  Created by Richard Crichlow on 3/16/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit

class FriendListViewController: UIViewController {
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(FriendListViewController.handleRefresh(_:)), for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor.red
        return refreshControl
    }()
    
    @objc private func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.friendListView.tableView.reloadData()
        refreshControl.endRefreshing() //TODO: This should trigger at the end of any API calls
    }
    
    let friendListView = FriendListView()
    let sideMenu = SideDrawerMenuViewController()
    
    var sampleArray = [1,2,3,4,5]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "FriendListVC"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(presentMenu))
        setupViews()
        //Delegates
        friendListView.tableView.delegate = self
        friendListView.tableView.dataSource = self
        friendListView.tableView.estimatedRowHeight = 80
        friendListView.tableView.rowHeight = UITableViewAutomaticDimension
        friendListView.friendSearchbBar.delegate = self
        sideMenu.dismissThenPresentDelegate = self
    }
    
    private func setupViews(){
        self.view.addSubview(friendListView)
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

extension FriendListViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        friendListView.friendSearchbBar.placeholder = "Search for a Friend"
        return true
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        friendListView.friendSearchbBar.becomeFirstResponder()
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        friendListView.friendSearchbBar.resignFirstResponder()
    }
}

extension FriendListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //TODO: segue to userProfile. Bonus.
    }
}
extension FriendListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sampleArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as! FriendTableViewCell
        let testData = sampleArray[indexPath.row]
        cell.usernameLabel.text = "username \(testData)"
        cell.setNeedsLayout()
        return cell
    }
}

extension FriendListViewController: dismissThenPresentChosenVC {
    func ProfileButtonPressed() {
        sideMenu.dismissView()
        let profileVC = ProfileViewController()
        profileVC.modalTransitionStyle = .crossDissolve
        profileVC.modalPresentationStyle = .overCurrentContext
        navigationController?.pushViewController(profileVC, animated: true)
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
        //Do nothing else since you're already on the FriendListVC
    }
}

