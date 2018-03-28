//
//  EditEventViewController.swift
//  whosfree
//
//  Created by Richard Crichlow on 3/25/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit
import MapKit

protocol EditDelegate {
    func passEditedEventBackToEventDetailVC(event: Event, eventImage: UIImage)
}

class EditEventViewController: UIViewController {

    var editDelegate: EditDelegate?
    
    let editEventView = EditEventView()
    var categories = ["Place", "Movie"]
    var searchCompleter = MKLocalSearchCompleter()
    var searchResults = [MKLocalSearchCompletion]()
    var searchSource: [String]?
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
    
    let eventBannerImagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(editEventView)
        
        // Delegates
        self.editEventView.tableView.dataSource = self
        self.editEventView.tableView.delegate = self
        self.editEventView.searchResultsTableView.dataSource = self
        self.editEventView.searchResultsTableView.delegate = self
        self.editEventView.descriptionTextView.delegate = self
        searchCompleter.delegate = self
        self.editEventView.searchBar.delegate = self
        eventBannerImagePicker.delegate = self
        
        // Setup Functions
        setupNavBarButtons()
        setupViewButtons()
        setupBannerImageGestureRecognizer()
        editEventView.prefillEventFields(event: event, eventImage: eventImage)
    }
    
    private func setupBannerImageGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(bannerImageTapped(tapGestureRecognizer:)))
        editEventView.bannerPhotoImageView.isUserInteractionEnabled = true
        editEventView.bannerPhotoImageView.addGestureRecognizer(tapGestureRecognizer)
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
        self.title = "Edit Event"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .done, target: self, action: #selector(editButtonPressed))
    }
    
    private func setupViewButtons() {
        editEventView.inviteFriendsButton.addTarget(self, action: #selector(inviteFriendsButtonPressed), for: .touchUpInside)
        editEventView.eventTypeButton.addTarget(self, action: #selector(categoryButtonAction), for: .touchUpInside)
    }
    
    @objc private func editButtonPressed() {
        print("Edit Event Button Pressed")
        let eventId = event.eventID
        let eventName = editEventView.eventTitleTextField.text!
        let ownerUserID = event.ownerUserID //FirebaseAuthService.getCurrentUser()!.uid
        let eventDescription = editEventView.descriptionTextView.text!
        let eventLocation = editEventView.searchBar.text!
        let componenets = Calendar.current.dateComponents([.year, .month, .day], from: editEventView.datePicker.date)
        if let day = componenets.day, let month = componenets.month, let year = componenets.year {
            print("\(day) \(month) \(year)")
        }
        let timestamp = event.timestamp //Date.timeIntervalSinceReferenceDate
        let editedEventToAdd = Event(eventID: eventId, eventName: eventName, ownerUserID: ownerUserID, eventDescription: eventDescription, eventLocation: eventLocation, timestamp: timestamp, eventBannerImgUrl: "")
        DatabaseService.manager.editEvent(editedEventToAdd, editEventView.bannerPhotoImageView.image ?? #imageLiteral(resourceName: "park"))
        
        //TODO: Pass Event object back to EventDetailVC
        self.editDelegate?.passEditedEventBackToEventDetailVC(event: editedEventToAdd, eventImage: editEventView.bannerPhotoImageView.image ?? #imageLiteral(resourceName: "park"))
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func inviteFriendsButtonPressed() {
        print("invite friends button pressed")
        // TODO: Present User's Contacts and let user send a text to selected contacts
        
        let inviteFriendsVC = InviteFriendsViewController()
        let inviteFriendsNavCon = UINavigationController(rootViewController: inviteFriendsVC)
        present(inviteFriendsNavCon, animated: true, completion: nil)
    }
    
    @objc private func categoryButtonAction(sender: UIButton!) {
        print("Button tapped")
        if editEventView.tableView.isHidden == true {
            editEventView.tableView.isHidden = false
            animateCategoryTV()
            editEventView.datePicker.isEnabled = false
        } else {
            editEventView.tableView.isHidden = true
            editEventView.datePicker.isEnabled = true
        }
    }
    
    private func animateCategoryTV() {
        editEventView.tableView.reloadData()
        let cells = editEventView.tableView.visibleCells
        let tableViewHeight = editEventView.tableView.bounds.size.height
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: -tableViewHeight)
        }
        var delayCounter:Double = 0
        for cell in cells {
            UIView.animate(withDuration: 1.25, delay: delayCounter * 0.05, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 0.5
        }
    }
    
}
extension EditEventViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == editEventView.tableView {
            return categories.count
        } else {
            return searchResults.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == editEventView.tableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EventTypeCell", for: indexPath) as! EventTypeTableViewCell
            let data = categories[indexPath.row]
            
            cell.eventTypeLabel.text = data
            return cell
        } else {
            let cell = editEventView.searchResultsTableView.dequeueReusableCell(withIdentifier: "SearchResultsCell", for: indexPath)
            let searchResult = searchResults[indexPath.row]
            cell.textLabel?.text = "\(searchResult.title) \(searchResult.subtitle)"
            return cell
            
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == editEventView.searchResultsTableView {
            let completion = searchResults[indexPath.row]
            let cellText = "\(completion.title) \(completion.subtitle)"
            let searchRequest = MKLocalSearchRequest(completion: completion)
            let search = MKLocalSearch(request: searchRequest)
            search.start{ (response, error) in
                let coordinate = response?.mapItems[0].placemark.coordinate
                //print(response?.mapItems)
                
                self.editEventView.searchBar.text = "\(cellText)"
            }
            searchResults = []
            self.editEventView.searchResultsTableView.reloadData()
            editEventView.searchResultsTableView.isHidden = true
            print("hidden")
        } else if tableView == editEventView.tableView {
            let category = categories[indexPath.row]
            editEventView.eventTypeButton.setTitle(category, for: .normal)
            editEventView.tableView.isHidden = true
            editEventView.datePicker.isEnabled = true
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

extension EditEventViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchCompleter.queryFragment = searchText
        editEventView.searchResultsTableView.isHidden = false
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        editEventView.searchResultsTableView.isHidden = true
        print("hidden textdidendediting")
    }
}

extension EditEventViewController: MKLocalSearchCompleterDelegate {
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults =  completer.results
        editEventView.searchResultsTableView.reloadData()
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print(error)
    }
}

// MARK:- Image Picker delegate functions
extension EditEventViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let imageSelected = info[UIImagePickerControllerEditedImage] as? UIImage else {
            print("Error selecting picture")
            return
        }
        editEventView.bannerPhotoImageView.image = imageSelected
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
extension EditEventViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        becomeFirstResponder()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        resignFirstResponder()
    }
}



