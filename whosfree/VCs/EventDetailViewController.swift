//
//  EventDetailViewController.swift
//  whosfree
//
//  Created by Richard Crichlow on 3/16/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit

class EventDetailViewController: UIViewController {

    let eventDetailView = EventDetailView()
    let dummyData = ["test1 title", "test2 title", "test3 title", "test4 title", "test5 title"]
    private let cellSpacing: CGFloat =  5.0
    
    var event: Event!
    var eventImage: UIImage!
    
    init(event: Event, eventImage: UIImage) {
        self.event = event
        self.eventImage = eventImage
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(eventDetailView)
        //self.eventDetailView.tableView.dataSource = self
        //self.eventDetailView.tableView.delegate = self
        self.eventDetailView.collectionView.dataSource = self
        self.eventDetailView.collectionView.delegate = self
        self.eventDetailView.rsvpButton.addTarget(self, action: #selector(rsvp), for: .touchUpInside)
        self.eventDetailView.deleteButton.addTarget(self, action: #selector(deleteEvent), for: .touchUpInside)
        configureNavBar()
        eventDetailView.configureView(event: event, eventImage: eventImage)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // TODO
        // if current userID == event's owner userID, change RSVP to EDIT, and change rsvpButton's addTarget to presentEditEventVC
        
        self.eventDetailView.locationButton.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
    }
    
    @objc private func deleteEvent() {
        deleteAction(title: "Delete", message: "Are you sure you want to delete event?")
    }
    
    private func deleteAction(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) {(alert) in
            print("pressed Delete")
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) {(alert) in
            print("pressed Cancel")
        }
        
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @objc private func rsvp() {
        rsvpAction(title: "RSVP", message: "Please RSVP")
    }
    
    private func rsvpAction(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let goingAction = UIAlertAction(title: "Going", style: .default) {(alert) in
            print("pressed Going")
        }
        let notGoingAction = UIAlertAction(title: "Not Going", style: .default) {(alert) in
            print("pressed Not Going")
        }
        let maybeAction = UIAlertAction(title: "Maybe", style: .default) {(alert) in
            print("pressed Maybe")
        }
        alertController.addAction(goingAction)
        alertController.addAction(notGoingAction)
        alertController.addAction(maybeAction)
        present(alertController, animated: true, completion: nil)
    }
    
    private func configureNavBar() {
        //let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editEvent))
        let chatButton = UIBarButtonItem(image: #imageLiteral(resourceName: "chatBubble"), style: .plain, target: self, action: #selector(segueToChatViewController))
        navigationItem.rightBarButtonItem = chatButton
        //TODO: edit button is only visible to creator of event
        //if user.id == event creator.id {
        //navigationItem.leftBarButtonItem = editButton
        //} else {
        //navigationItem.leftBarButtonItem = nil
        
        //}
    }
    
    
    
    @objc private func editEvent() {
        
    }
    
    @objc private func segueToChatViewController() {
        // TODO: dependency injection of the eventID so we know which chat corresponds to the event
        let chatVC = ChatViewController()
        chatVC.specificEventIDsChat = event.eventID
        navigationController?.pushViewController(chatVC, animated: true)
    }
    
}

//extension EventDetailViewController: UITableViewDataSource, UITableViewDelegate {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return dummyData.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let data = dummyData[indexPath.row]
//        let cell = tableView.dequeueReusableCell(withIdentifier: "EventTypeCell", for: indexPath)
//        cell.textLabel?.text = data
//        return cell
//    }
//}

extension EventDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dummyData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InvitedFriendsCollectionViewCell", for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
    
    
}

extension EventDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let numCells: CGFloat = 3
        let numSpaces: CGFloat = numCells + 1
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        return CGSize(width: (screenWidth - (cellSpacing * numSpaces)) / numCells, height: screenHeight * 0.15)
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
