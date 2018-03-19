//
//  InviteFriendsViewController.swift
//  whosfree
//
//  Created by Richard Crichlow on 3/16/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Invite Friends"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(presentMenu))
        setupViews()
        //Delegates
        inviteFriendsView.tableView.delegate = self
        inviteFriendsView.tableView.dataSource = self
        inviteFriendsView.tableView.estimatedRowHeight = 80
        inviteFriendsView.tableView.rowHeight = UITableViewAutomaticDimension
        inviteFriendsView.friendSearchbBar.delegate = self
    }
    
    private func setupViews(){
        self.view.addSubview(inviteFriendsView)
    }
    
    @objc private func presentMenu() {
        let sideMenu = SideDrawerMenuViewController()
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
        return sampleArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExistingFriendsTableViewCell", for: indexPath) as! ExistingFriendsTableViewCell
        let testData = sampleArray[indexPath.row]
        cell.usernameLabel.text = "username \(testData)"
        cell.setNeedsLayout()
        return cell
    }
}

