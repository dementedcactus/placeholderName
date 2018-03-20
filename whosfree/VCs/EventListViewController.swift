//
//  EventListViewController.swift
//  whosfree
//
//  Created by Richard Crichlow on 3/16/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit

class EventListViewController: UIViewController {
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(EventListViewController.handleRefresh(_:)), for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor.red
        return refreshControl
    }()
    
    @objc private func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.eventListView.tableView.reloadData()
        refreshControl.endRefreshing() //TODO: This should trigger at the end of any API calls
    }
    
    let eventListView = EventListView()
    let sideMenu = SideDrawerMenuViewController()
    
    var sampleArray = [1,2,3,4,5]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "EventListVC"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(presentMenu))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addEventButtonAction))
        setupViews()
        //TBV Delegates
        eventListView.tableView.delegate = self
        eventListView.tableView.dataSource = self
        eventListView.tableView.estimatedRowHeight = 80
        eventListView.tableView.rowHeight = UITableViewAutomaticDimension
        
        sideMenu.friendListDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if FirebaseAuthService.getCurrentUser() == nil {
            let signInVC = SignInViewController()
            self.present(signInVC, animated: false, completion: nil)
        } else {
            // load events for user here
        }
    }
    
    private func setupViews(){
        self.view.addSubview(eventListView)
        self.eventListView.tableView.addSubview(self.refreshControl)
    }
    
    @objc private func addEventButtonAction() {
        print("Add Event Button Pressed")
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
extension EventListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //TODO: segue to EventDetailViewController
        //navigationController?.pushViewController(EventDetailViewController, animated: true)
    }
}
extension EventListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sampleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! EventTableViewCell
        
        let testData = sampleArray[indexPath.row]
        
        cell.eventDateAndTimeLabel.text = "Date \(testData): Time \(testData)"
        cell.eventTitleLabel.text = "Event \(testData)"
        cell.setNeedsLayout()
        return cell
    }
}
extension EventListViewController: dismissThenPresentFriendListVC {
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

