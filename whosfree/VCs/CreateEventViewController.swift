//
//  CreateEventViewController.swift
//  whosfree
//
//  Created by Richard Crichlow on 3/16/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit
import MapKit

class CreateEventViewController: UIViewController {

    let createEventView = CreateEventView()
    var categories = ["Venue", "Movie", "Other"]
    var searchCompleter = MKLocalSearchCompleter()
    var searchResults = [MKLocalSearchCompletion]()
    var searchSource: [String]?
    
    let eventBannerImagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(createEventView)
        self.createEventView.tableView.dataSource = self
        self.createEventView.tableView.delegate = self
        self.createEventView.searchResultsTableView.dataSource = self
        self.createEventView.searchResultsTableView.delegate = self
        searchCompleter.delegate = self
        self.createEventView.searchBar.delegate = self
        eventBannerImagePicker.delegate = self
        setupNavBarButtons()
        setupViewButtons()
        setupBannerImageGestureRecognizer()
    }
    
    private func setupBannerImageGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(bannerImageTapped(tapGestureRecognizer:)))
        createEventView.bannerPhotoImageView.isUserInteractionEnabled = true
        createEventView.bannerPhotoImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func bannerImageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let profileImageAlertController = UIAlertController(title: "Add Event Image", message: nil, preferredStyle: .alert)
        let fromCameraRollAction = UIAlertAction(title: "From camera roll", style: .default) { (alertAction) in
            self.eventBannerImagePicker.allowsEditing = true
            self.eventBannerImagePicker.sourceType = .photoLibrary
            self.present(self.eventBannerImagePicker, animated: true, completion: nil)
        }
        let fromLaunchCameraAction = UIAlertAction(title: "Take a picture", style: .default) { (alertAction) in
            self.eventBannerImagePicker.allowsEditing = true
            self.eventBannerImagePicker.sourceType = .camera
            self.present(self.eventBannerImagePicker, animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        profileImageAlertController.addAction(fromCameraRollAction)
        profileImageAlertController.addAction(fromLaunchCameraAction)
        profileImageAlertController.addAction(cancelAction)
        present(profileImageAlertController, animated: true, completion: nil)
    }
    
    private func setupNavBarButtons() {
        self.title = "Create Event"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Create", style: .done, target: self, action: #selector(createButtonPressed))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(cancelButtonPressed))
    }
    
    private func setupViewButtons() {
        createEventView.inviteFriendsButton.addTarget(self, action: #selector(inviteFriendsButtonPressed), for: .touchUpInside)
        createEventView.eventTypeButton.addTarget(self, action: #selector(categoryButtonAction), for: .touchUpInside)
    }
    
    @objc private func createButtonPressed() {
        print("Create Event Button Pressed")
        let childByAutoId = DatabaseService.manager.getEvents().childByAutoId()
        let eventName = createEventView.eventTitleLabel.text!
        let ownerUserID = FirebaseAuthService.getCurrentUser()!.uid
        let eventDescription = createEventView.descriptionTextView.text!
        let eventLocation = createEventView.searchBar.text!
        // need to use datepicker delegate to get time and date
        let componenets = Calendar.current.dateComponents([.year, .month, .day], from: createEventView.datePicker.date)
        if let day = componenets.day, let month = componenets.month, let year = componenets.year {
            print("\(day) \(month) \(year)")
            // add this to db
        }
        let timestamp = Date.timeIntervalSinceReferenceDate
        let eventToAdd = Event(eventID: childByAutoId.key, eventName: eventName, ownerUserID: ownerUserID, eventDescription: eventDescription, eventLocation: eventLocation, timestamp: timestamp, eventBannerImgUrl: "")
        DatabaseService.manager.addEvent(eventToAdd, createEventView.bannerPhotoImageView.image ?? #imageLiteral(resourceName: "park"))
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
    
    @objc private func categoryButtonAction(sender: UIButton!) {
        print("Button tapped")
        if createEventView.tableView.isHidden == true {
            createEventView.tableView.isHidden = false
            animateCategoryTV()
        } else {
            createEventView.tableView.isHidden = true
        }
    }
    
    private func animateCategoryTV() {
        createEventView.tableView.reloadData()
        let cells = createEventView.tableView.visibleCells
        let tableViewHeight = createEventView.tableView.bounds.size.height
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: -tableViewHeight)
        }
        var delayCounter:Double = 0
        for cell in cells {
            UIView.animate(withDuration: 1.75, delay: delayCounter * 0.05, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 0.5
        }
    }
    
}
extension CreateEventViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == createEventView.tableView {
            return categories.count
        } else {
            return searchResults.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == createEventView.tableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EventTypeCell", for: indexPath) as! EventTypeTableViewCell
            let data = categories[indexPath.row]
            
            cell.eventTypeLabel.text = data
            return cell
        } else {
            let cell = createEventView.searchResultsTableView.dequeueReusableCell(withIdentifier: "SearchResultsCell", for: indexPath)
            let searchResult = searchResults[indexPath.row]
            cell.textLabel?.text = "\(searchResult.title) \(searchResult.subtitle)"
            return cell
            
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == createEventView.searchResultsTableView {
            let completion = searchResults[indexPath.row]
            let cellText = "\(completion.title) \(completion.subtitle)"
            let searchRequest = MKLocalSearchRequest(completion: completion)
            let search = MKLocalSearch(request: searchRequest)
            search.start{ (response, error) in
                let coordinate = response?.mapItems[0].placemark.coordinate
                //print(response?.mapItems)
                
                self.createEventView.searchBar.text = "\(cellText)"
            }
            searchResults = []
            self.createEventView.searchResultsTableView.reloadData()
            createEventView.searchResultsTableView.isHidden = true
            print("hidden")
        } else if tableView == createEventView.tableView {
            let category = categories[indexPath.row]
            createEventView.eventTypeButton.setTitle(category, for: .normal)
            createEventView.tableView.isHidden = true
            switch category {
            case "Venue":
                // seque venue
                print("Clicked Venue")
                let venueViewController = VenueViewController()
                navigationController?.pushViewController(venueViewController, animated: true)
            case "Movie":
                //segue movie
                print("Clicked Movie")
                let theatersViewController = TheatersViewController()
                navigationController?.pushViewController(theatersViewController, animated: true)
            case "Other":
                print("Clicked Other")
            default:
                print("Do nothing")
            }
        }
    }
    
    
}

extension CreateEventViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchCompleter.queryFragment = searchText
        createEventView.searchResultsTableView.isHidden = false
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        createEventView.searchResultsTableView.isHidden = true
        print("hidden textdidendediting")
    }
}

extension CreateEventViewController: MKLocalSearchCompleterDelegate {
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults =  completer.results
        createEventView.searchResultsTableView.reloadData()
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print(error)
    }
}

// MARK:- Image Picker delegate functions
extension CreateEventViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let imageSelected = info[UIImagePickerControllerEditedImage] as? UIImage else {
            print("Error selecting picture")
            return
        }
        createEventView.bannerPhotoImageView.image = imageSelected
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
}


