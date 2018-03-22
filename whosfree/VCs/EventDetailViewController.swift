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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(eventDetailView)
        //self.eventDetailView.tableView.dataSource = self
        //self.eventDetailView.tableView.delegate = self
        self.eventDetailView.collectionView.dataSource = self
        self.eventDetailView.collectionView.delegate = self
        self.eventDetailView.rsvpButton.addTarget(self, action: #selector(rsvp), for: .touchUpInside)
        configureNavBar()
    }
    
    @objc private func rsvp() {
        showAlert(title: "RSVP", message: "Please RSVP")
    }
    
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let goingAction = UIAlertAction(title: "Going", style: .default) {(alert) in
            print("pressed Going")
        }
        let notGoingAction = UIAlertAction(title: "Not Going", style: .default) {(alert) in
            print("pressed Not Going")
        }
        alertController.addAction(goingAction)
        alertController.addAction(notGoingAction)
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
