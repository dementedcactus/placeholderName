//
//  EditEventViewController.swift
//  whosfree
//
//  Created by Richard Crichlow on 3/25/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit
import MapKit
import MessageUI
import SwiftMailgun
import Kingfisher

protocol EditDelegate {
    func passEditedEventBackToEventDetailVC(event: Event, eventImage: UIImage, date: Date)
}

class EditEventViewController: UIViewController {
    
    var editDelegate: EditDelegate?
    let placeViewController = PlaceViewController()
    let editEventView = EditEventView()
    var categories = ["Place", "Movie"]
    var searchCompleter = MKLocalSearchCompleter()
    var searchResults = [MKLocalSearchCompletion]()
    var searchSource: [String]?
    var event: Event!
    var eventImage: UIImage!
    let mailgun = MailgunAPI(apiKey: "key-bf07275afe8c378ffe986d09c7b6f8a2", clientDomain: "sandbox5df72c43c441463fa8f7bcfdc4139162.mailgun.org")
    var invitedFriendsFullInfo = [Contact]()
    var invitedFriendsEmails = [String]() {
        didSet {
            dump(invitedFriendsEmails)
        }
    }
    
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
        self.placeViewController.selectVenueDelegate = self
        self.editEventView.deleteButton.addTarget(self, action: #selector(deleteEvent), for: .touchUpInside)
        // adds toolbar on top of textfied with done button to resing first responder
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 44))
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        toolBar.setItems([flexibleSpace, doneButton], animated: true)
        editEventView.descriptionTextView.inputAccessoryView = toolBar
    }
    
    @objc private func deleteEvent() {
        deleteAction(title: "Delete", message: "Are you sure you want to delete event?")
    }
    
    private func deleteAction(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) {(alert) in
            print("pressed Delete")
            DatabaseService.manager.deleteEvent(withPostID: self.event.eventID)
            self.navigationController?.popToRootViewController(animated: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) {(alert) in
            print("pressed Cancel")
        }
        
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func doneButtonTapped() -> Void {
        editEventView.descriptionTextView.resignFirstResponder()
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
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(editButtonPressed))
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
        let timestamp = CreateEventViewController().formatDate(with: editEventView.datePicker.date)
        
        let editedEventToAdd = Event(eventID: eventId, eventName: eventName, ownerUserID: ownerUserID, eventDescription: eventDescription, eventLocation: eventLocation, timestamp: timestamp, eventBannerImgUrl: "", invitedFriendsEmails: [], timestampDouble: editEventView.datePicker.date.timeIntervalSince1970)
        DatabaseService.manager.editEvent(editedEventToAdd, editEventView.bannerPhotoImageView.image ?? #imageLiteral(resourceName: "park"))
    
        self.editDelegate?.passEditedEventBackToEventDetailVC(event: editedEventToAdd, eventImage: editEventView.bannerPhotoImageView.image ?? #imageLiteral(resourceName: "park"), date: editEventView.datePicker.date)
        if !invitedFriendsEmails.isEmpty { sendEmailInvites(event: editedEventToAdd) }
        self.navigationController?.popViewController(animated: true)
    }
    
    private func sendEmailInvites(event: Event) {
        let emails = invitedFriendsEmails
        for email in emails {
            DatabaseService.manager.getUserProfile(withUID: FirebaseAuthService.getCurrentUser()!.uid, completion: { (user) in
                self.mailgun.sendEmail(to: email, from: "WYD The App <whosfreetheapp@gmail.com>", subject: "You have been invited!", bodyHTML: "Hi!, \(user.firstName) \(user.lastName) invited you to an event.<br /> \(event.description) Please click <a href=\"https://httpbin.org/redirect-to?url=wyd://\(event.eventID)/\(email)\">RSVP</a> to accept the invite") { mailgunResult in
                    if mailgunResult.success{
                        print("Email was sent")
                    }
                }
            })
        }
    }
    
    @objc private func inviteFriendsButtonPressed() {
        print("invite friends button pressed")
        let inviteFriendsVC = InviteFriendsViewController()
        let inviteFriendsNavCon = UINavigationController(rootViewController: inviteFriendsVC)
        present(inviteFriendsNavCon, animated: true, completion: nil)
    }
    
    @objc private func categoryButtonAction(sender: UIButton!) {
        print("Button tapped")
        navigationController?.pushViewController(placeViewController, animated: true)
    }
    
}
extension EditEventViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = editEventView.searchResultsTableView.dequeueReusableCell(withIdentifier: "SearchResultsCell", for: indexPath)
            let searchResult = searchResults[indexPath.row]
            cell.textLabel?.text = "\(searchResult.title) \(searchResult.subtitle)"
            return cell
            
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == editEventView.searchResultsTableView {
            let completion = searchResults[indexPath.row]
            let cellText = "\(completion.title) \(completion.subtitle)"
            let searchRequest = MKLocalSearchRequest(completion: completion)
            let search = MKLocalSearch(request: searchRequest)
            search.start{ (response, error) in
                _ = response?.mapItems[0].placemark.coordinate
                //print(response?.mapItems)
                
                self.editEventView.searchBar.text = "\(cellText)"
            }
            searchResults = []
            self.editEventView.searchResultsTableView.reloadData()
            editEventView.searchResultsTableView.isHidden = true
            print("hidden")
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
        if textView.textColor == Stylesheet.Colors.Gray {
            textView.text = ""
            textView.textColor = Stylesheet.Colors.Dark
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        resignFirstResponder()
    }
}

extension EditEventViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension EditEventViewController: InviteFriendsViewControllerDelegate {
    func didFinishAddingFriendsToEvent(_ friendsGoing: [Contact]) {
        self.invitedFriendsFullInfo = friendsGoing
        self.editEventView.friendsGoingCollectionView.reloadData()
        self.invitedFriendsEmails = friendsGoing.map{$0.emailAddress!}
    }
}


extension EditEventViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return invitedFriendsFullInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "user going cell", for: indexPath) as! FriendsCollectionViewCell
        let currentFriend = invitedFriendsFullInfo[indexPath.row]
        cell.friendLabel.text = "\(currentFriend.givenName)"
        guard let friendImageData = currentFriend.imageData else {
            cell.friendImage.image = #imageLiteral(resourceName: "profileImagePlaceholder")
            return cell
        }
        cell.friendImage.image = UIImage(data: friendImageData)
        return cell
    }
    
}
extension EditEventViewController: SelectVenueDelegate {
    func passSelectedVenueAddressToCreateEventSearchBar(addrsss: String, placeImageURL: String) {
        self.editEventView.searchBar.text = addrsss
        self.editEventView.bannerPhotoImageView.kf.setImage(with: URL(string: placeImageURL))
    }
}


