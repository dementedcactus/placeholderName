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
    
    var sampleArray = [1,2,3,4,5]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "EventListVC"
        
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
        // TODO: Logout function here
        
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


