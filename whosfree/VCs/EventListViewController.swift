//
//  EventListViewController.swift
//  whosfree
//
//  Created by Richard Crichlow on 3/16/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import Contacts
import MessageUI

class EventListViewController: UIViewController {
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(EventListViewController.handleRefresh(_:)), for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor.red
        return refreshControl
    }()
    
    let firebaseAuthService =  FirebaseAuthService()
    
    @objc private func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.eventListView.tableView.reloadData()
        refreshControl.endRefreshing() //TODO: This should trigger at the end of any API calls
    }
    
    let eventListView = EventListView()
    
    var sampleArray = [1,2,3,4,5]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "EventListVC"
        self.firebaseAuthService.delegate = self
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addEventButtonAction))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(logoutAction))
        setupViews()
        //Delegates
        eventListView.tableView.delegate = self
        eventListView.tableView.dataSource = self
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
        let createEventVC = CreateEventViewController()
        let createEventNavCon = UINavigationController(rootViewController: createEventVC)
        self.present(createEventNavCon, animated: true, completion: nil)
    }
    
    @objc private func logoutAction() {
        print("Logout Button Pressed")
        logout()
        
    }
    
    private func logout() {
        let alertView = UIAlertController(title: "Are you sure you want to logout?", message: nil, preferredStyle: .alert)
        let yesOption = UIAlertAction(title: "Yes", style: .destructive) { (alertAction) in
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

extension EventListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //TODO: segue to EventDetailViewController using dependency injection
        let eventDetailVC = EventDetailViewController()
        navigationController?.pushViewController(eventDetailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
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

extension EventListViewController: FirebaseAuthServiceDelegate {
    func didSignOut(_ authService: FirebaseAuthService) {
        if FBSDKAccessToken.current() != nil {
            let loginManager = FBSDKLoginManager()
            loginManager.logOut()
        }
        // TODO: reset Array of event to empty
        let signInVC = SignInViewController()
        self.present(signInVC, animated: true, completion: nil)
    }
    func didFailSigningOut(_ authService: FirebaseAuthService, error: Error) {
        showAlert(title: "Error", message: error.localizedDescription)
    }
}


