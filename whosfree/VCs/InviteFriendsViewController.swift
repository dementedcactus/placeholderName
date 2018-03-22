//
//  InviteFriendsViewController.swift
//  whosfree
//
//  Created by Richard Crichlow on 3/16/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit
import Kingfisher

class InviteFriendsViewController: UIViewController {
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(InviteFriendsViewController.handleRefresh(_:)), for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor.red
        return refreshControl
    }()
    
    @objc private func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.inviteFriendsView.tableView.reloadData()
        refreshControl.endRefreshing() //TODO: This should trigger at the end of any API calls
    }
    
    let inviteFriendsView = InviteFriendsView()
    
    var sampleArray = [1,2,3,4,5]
    
    var myFriendsIDs = [String]() {
        didSet {
            DispatchQueue.main.async {
                self.inviteFriendsView.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Invite Friends"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Finish", style: .done, target: self, action: #selector(finishedAddingFriends))
        setupViews()
        //Delegates
        inviteFriendsView.tableView.delegate = self
        inviteFriendsView.tableView.dataSource = self
        inviteFriendsView.tableView.estimatedRowHeight = 80
        inviteFriendsView.tableView.rowHeight = UITableViewAutomaticDimension
        inviteFriendsView.friendSearchbBar.delegate = self
        if FirebaseAuthService.getCurrentUser() != nil {
            loadAllUserFriends()
        }
    }
    
    private func loadAllUserFriends() {
        DatabaseService.manager.getUserFriendIDs { (friendIDs) in
            guard let friendIDs = friendIDs else {
                print("error retrieving user friends")
                return
            }
            self.myFriendsIDs = friendIDs
        }
    }
    
    private func setupViews(){
        self.view.addSubview(inviteFriendsView)
    }
    
    @objc private func finishedAddingFriends() {
        print("Finished adding friends button pressed")
        self.dismiss(animated: true, completion: nil)
    }
    
}
extension InviteFriendsViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        inviteFriendsView.friendSearchbBar.placeholder = "Search for a Friend"
        return true
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        inviteFriendsView.friendSearchbBar.becomeFirstResponder()
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        inviteFriendsView.friendSearchbBar.resignFirstResponder()
    }
}

extension InviteFriendsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //TODO: segue to userProfile. Bonus.
    }
}
extension InviteFriendsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myFriendsIDs.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExistingFriendsTableViewCell", for: indexPath) as! ExistingFriendsTableViewCell
        //let testData = sampleArray[indexPath.row]
        //cell.usernameLabel.text = "username \(testData)"
        //cell.setNeedsLayout()
        let friend = myFriendsIDs[indexPath.row]
        cell.userPhotoImageView.kf.indicatorType = .activity
        DatabaseService.manager.getUserProfile(withUID: friend) { (user) in
            cell.usernameLabel.text = user.displayName
            cell.userPhotoImageView.kf.setImage(with: URL(string: user.profileImageUrl), placeholder: #imageLiteral(resourceName: "profileImagePlaceholder"), options: nil, progressBlock: nil, completionHandler: { (image, error, cache, url) in
            })
        }
        return cell
    }
}

