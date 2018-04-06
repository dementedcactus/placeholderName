//
//  EventListViewController.swift
//  whosfree
//
//  Created by Richard Crichlow on 3/16/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit
import Kingfisher
import FBSDKLoginKit
import FBSDKCoreKit

class EventListViewController: UIViewController {
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(EventListViewController.handleRefresh(_:)), for: UIControlEvents.valueChanged)
        refreshControl.tintColor = Stylesheet.Colors.azure
        return refreshControl
    }()
    
    let firebaseAuthService =  FirebaseAuthService()
    
    let emptyView = EmptyStateView(emptyText: "No events yet!")
    
    @objc private func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.eventListView.tableView.reloadData()
        refreshControl.endRefreshing() //TODO: This should trigger at the end of any API calls
    }
    
    let eventListView = EventListView()
    
    var sampleArray = [1,2,3,4,5]
    
    var events = [Event]() {
        didSet {
            DispatchQueue.main.async {
                self.eventListView.tableView.reloadData()
                self.emptyStateFunc()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.title = "Events"
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 70, height: 23))
        let titleImageView = UIImageView(image: #imageLiteral(resourceName: "WYD"))
        titleImageView.frame = CGRect(x: 5, y: 0, width: titleView.frame.width, height: titleView.frame.height)
        titleView.addSubview(titleImageView)
        navigationItem.titleView = titleView
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
            loadEvents()
        }
    }
    
    private func loadEvents() {
//        DatabaseService.manager.getAllEvents { (theEvents) in
//            guard let theEvents = theEvents else  {
//                print("could not get events")
//                return
//            }
//            self.events = theEvents.sortedByTimestamp()
//        }
        DatabaseService.manager.getMyEvents { (theEvents) in
            guard let theEvents = theEvents else  {
                print("could not get events")
                return
            }
            self.events = theEvents.sortedByTimestamp()
        }
    }
    
    private func emptyStateFunc(){
        if events.isEmpty {
            self.view.addSubview(emptyView)
            
            emptyView.translatesAutoresizingMaskIntoConstraints = false
            emptyView.topAnchor.constraint(equalTo: eventListView.safeAreaLayoutGuide.topAnchor).isActive = true
            emptyView.bottomAnchor.constraint(equalTo: eventListView.safeAreaLayoutGuide.bottomAnchor).isActive = true
            emptyView.leadingAnchor.constraint(equalTo: eventListView.safeAreaLayoutGuide.leadingAnchor).isActive = true
            emptyView.trailingAnchor.constraint(equalTo: eventListView.safeAreaLayoutGuide.trailingAnchor).isActive = true
        } else {
            emptyView.removeFromSuperview()
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
        let event = events[indexPath.row]
        let eventCell = tableView.cellForRow(at: indexPath) as! EventTableViewCell
        let eventImage = eventCell.eventBannerPhotoImageView.image
        let eventDetailVC = EventDetailViewController(event: event, eventImage: eventImage ?? #imageLiteral(resourceName: "park"))
        navigationController?.pushViewController(eventDetailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}
extension EventListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! EventTableViewCell
        
        //let testData = sampleArray[indexPath.row]
        let event = events[indexPath.row]
//        cell.eventDateAndTimeLabel.text = "Date \(testData): Time \(testData)"
//        cell.eventTitleLabel.text = "Event \(testData)"
        
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = UIColor.darkText.cgColor
        cell.selectionStyle = .none
        cell.eventDateAndTimeLabel.text = "\(event.timestamp.description)  "
        cell.eventTitleLabel.text = " \(event.eventName)"
        DatabaseService.manager.getUserFriendsGoing(eventID: event.eventID) { (going) in
            DatabaseService.manager.getAllUserFriendsInvited(eventID: event.eventID, completionHandler: { (invited) in
                cell.goingNotGoingLabel.text = "\(going!.count)/\(invited!.count)"
            })
        }
        //cell.goingNotGoingLabel.text = "\(event.friendsGoing?.count.description ?? "1")/\(event.invitedFriendsEmails.count)"
        cell.eventBannerPhotoImageView.kf.indicatorType = .activity
        cell.eventBannerPhotoImageView.kf.setImage(with: URL(string: event.eventBannerImgUrl), placeholder: #imageLiteral(resourceName: "placeholder"), options: nil, progressBlock: nil) { (image, error, cache, url) in
            cell.setNeedsLayout()
        }

        return cell
    }
}

extension EventListViewController: FirebaseAuthServiceDelegate {
    func didSignOut(_ authService: FirebaseAuthService) {
        if FBSDKAccessToken.current() != nil {
            let loginManager = FBSDKLoginManager()
            loginManager.logOut()
        }
        events.removeAll()
        let signInVC = SignInViewController()
        self.present(signInVC, animated: true, completion: nil)
    }
    func didFailSigningOut(_ authService: FirebaseAuthService, error: Error) {
        showAlert(title: "Error", message: error.localizedDescription)
    }
}


