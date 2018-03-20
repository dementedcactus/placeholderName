//
//  CreateEventViewController.swift
//  whosfree
//
//  Created by Richard Crichlow on 3/16/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit

class CreateEventViewController: UIViewController {

    let createEventView = CreateEventView()
    var dummyData = ["test1 title", "test2 title", "test3 title"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(createEventView)
        self.createEventView.tableView.dataSource = self
        self.createEventView.tableView.delegate = self
        setupNavBarButtons()
        setupViewButtons()
        
    }
    
    private func setupNavBarButtons() {
        self.title = "Create Event"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Create", style: .done, target: self, action: #selector(createButtonPressed))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(cancelButtonPressed))
    }
    
    private func setupViewButtons() {
        createEventView.inviteFriendsButton.addTarget(self, action: #selector(inviteFriendsButtonPressed), for: .touchUpInside)
    }
    
    @objc private func createButtonPressed() {
        print("Create Event Button Pressed")
        // create event firebase func here
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func cancelButtonPressed() {
        self.dismiss(animated: true, completion: nil)
        print("Cancel create event pressed")
    }
    
    @objc private func inviteFriendsButtonPressed() {
        print("invite friends button pressed")
        let inviteFriendsVC = InviteFriendsViewController()
        let inviteFriendsNavCon = UINavigationController(rootViewController: inviteFriendsVC)
        present(inviteFriendsNavCon, animated: true, completion: nil)
    }
    
}
extension CreateEventViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = dummyData[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventTypeCell", for: indexPath)
        cell.textLabel?.text = data
        return cell
    }
    

}
