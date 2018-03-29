//
//  CreateEventViewController.swift
//  whosfree
//
//  Created by Richard Crichlow on 3/16/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//
import UIKit
import MapKit
import MessageUI
import SwiftMailgun

class CreateEventViewController: UIViewController {
    
    var keyboardAdjusted = false
    var lastKeyboardOffset: CGFloat = 0.0
    
    let createEventView = CreateEventView()
    let placeViewController = PlaceViewController()
    var categories = ["Place", "Movie"]
    var searchCompleter = MKLocalSearchCompleter()
    var searchResults = [MKLocalSearchCompletion]()
    var searchSource: [String]?
    let mailgun = MailgunAPI(apiKey: "key-bf07275afe8c378ffe986d09c7b6f8a2", clientDomain: "sandbox5df72c43c441463fa8f7bcfdc4139162.mailgun.org")
    var invitedFriendsEmails = [String]() {
        didSet {
            dump(invitedFriendsEmails)
        }
    }
    
    var invitedFriendsFullInfo = [Contact]()
    
    let childByAutoId = DatabaseService.manager.getEvents().childByAutoId()
    
    let eventBannerImagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(createEventView)
        
        // Delegates
        self.createEventView.tableView.dataSource = self
        self.createEventView.tableView.delegate = self
        self.createEventView.searchResultsTableView.dataSource = self
        self.createEventView.searchResultsTableView.delegate = self
        self.createEventView.descriptionTextView.delegate = self
        self.createEventView.eventTitleTextField.delegate = self
        self.searchCompleter.delegate = self
        self.createEventView.searchBar.delegate = self
        self.eventBannerImagePicker.delegate = self
        self.createEventView.friendsGoingCollectionView.delegate = self
        self.createEventView.friendsGoingCollectionView.dataSource = self
        self.placeViewController.selectVenueDelegate = self
        
        // Setup Functions
        setupNavBarButtons()
        setupViewButtons()
        setupBannerImageGestureRecognizer()
        // adds toolbar on top of textfied with done button to resing first responder
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 44))
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        toolBar.setItems([flexibleSpace, doneButton], animated: true)
        createEventView.descriptionTextView.inputAccessoryView = toolBar
    }
    
    @objc func doneButtonTapped() -> Void {
        createEventView.descriptionTextView.resignFirstResponder()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if keyboardAdjusted == false {
            lastKeyboardOffset = getKeyboardHeight(notification: notification)
            view.frame.origin.y -= lastKeyboardOffset
            keyboardAdjusted = true
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if keyboardAdjusted == true {
            view.frame.origin.y += lastKeyboardOffset
            keyboardAdjusted = false
        }
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
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
        //createEventView.sendInvitesButton.addTarget(self, action: #selector(sendInvitesAction), for: .touchUpInside)
    }
    
    @objc private func createButtonPressed() {
        print("Create Event Button Pressed")
//        let childByAutoId = DatabaseService.manager.getEvents().childByAutoId()
        let eventName = createEventView.eventTitleTextField.text!
        let ownerUserID = FirebaseAuthService.getCurrentUser()!.uid
        let eventDescription = createEventView.descriptionTextView.text!
        let eventLocation = createEventView.searchBar.text!
        //let componenets = Calendar.current.dateComponents([.year, .month, .day], from: createEventView.datePicker.date)
        let timestamp = formatDate(with: createEventView.datePicker.date)
//        if let day = components.day, let month = components.month, let year = components.year {
//            print("\(day) \(month) \(year)")
//            timestamp = "\(day) \(month) \(year)"
//        }
        let eventToAdd = Event(eventID: childByAutoId.key, eventName: eventName, ownerUserID: ownerUserID, eventDescription: eventDescription, eventLocation: eventLocation, timestamp: timestamp, eventBannerImgUrl: "", allFriendsInvited: invitedFriendsEmails)
        DatabaseService.manager.addEvent(eventToAdd, createEventView.bannerPhotoImageView.image ?? #imageLiteral(resourceName: "placeholder"))
        if !invitedFriendsEmails.isEmpty { sendEmailInvites(event: eventToAdd) }
        dismiss(animated: true, completion: nil)
    }
    
    public func formatDate(with date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, YYYY @ h:mm a"
        return dateFormatter.string(from: date)
    }
    
    private func sendEmailInvites(event: Event) {
        let emails = invitedFriendsEmails
        for email in emails {
            DatabaseService.manager.getUserProfile(withUID: FirebaseAuthService.getCurrentUser()!.uid, completion: { (user) in
                self.mailgun.sendEmail(to: email, from: "WYT The App <whosfreetheapp@gmail.com>", subject: "You have been invited!", bodyHTML: "Hi!, \(user.firstName) \(user.lastName) invited you to an event.<br /> \(event.description) Please click <a href=\"https://httpbin.org/redirect-to?url=wyd://\(self.childByAutoId.key)/\(email)\">RSVP</a> to accept the invite") { mailgunResult in
                    if mailgunResult.success{
                        print("Email was sent")
                    }
                }
            })
        }
    }
    
    @objc private func cancelButtonPressed() {
        self.dismiss(animated: true, completion: nil)
        print("Cancel create event pressed")
    }
    
    @objc private func inviteFriendsButtonPressed() {
        print("invite friends button pressed")
        let inviteFriendsVC = InviteFriendsViewController()
        inviteFriendsVC.delegate = self
        let inviteFriendsNavCon = UINavigationController(rootViewController: inviteFriendsVC)
        present(inviteFriendsNavCon, animated: true, completion: nil)
    }
    
//    @objc private func sendInvitesAction() {
//        if invitedFriendsEmails.isEmpty {
//            showAlert(title: "Error", message: "You need to invite some friends first!")
//            return
//        }
//        let mailComposeViewController = self.configuredMailComposeViewController()
//        if MFMailComposeViewController.canSendMail() {
//            self.present(mailComposeViewController, animated: true, completion: nil)
//        } else {
//            //self.showAlert(service: "Email") //MailController pops up its own alert with no email service
//        }
//    }
//
//    private func configuredMailComposeViewController() -> MFMailComposeViewController {
//        let mailComposerVC = MFMailComposeViewController()
//        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
//        mailComposerVC.setBccRecipients(["luiscalle@ac.c4q.nyc", "lcalle101qc@gmail.com"])
//        mailComposerVC.setSubject("You have been invited!")
//        mailComposerVC.setMessageBody("Hi!, USER has invited you <a href=\"https://www.w3schools.com/html/\">RSVP</a> to blah blah blah", isHTML: true)
//
//        return mailComposerVC
//    }
    
    @objc private func categoryButtonAction(sender: UIButton!) {
        print("Button tapped")
        if createEventView.tableView.isHidden == true {
            createEventView.tableView.isHidden = false
            animateCategoryTV()
            createEventView.datePicker.isEnabled = false
        } else {
            createEventView.tableView.isHidden = true
            createEventView.datePicker.isEnabled = true
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
            UIView.animate(withDuration: 1.25, delay: delayCounter * 0.05, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 0.5
        }
    }
    
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { alert in }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
}

//extension CreateEventViewController: MFMailComposeViewControllerDelegate {
//    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
//        self.dismiss(animated: true, completion: nil)
//    }
//}

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
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == createEventView.searchResultsTableView {
            let completion = searchResults[indexPath.row]
            let cellText = "\(completion.title) \(completion.subtitle)"
            let searchRequest = MKLocalSearchRequest(completion: completion)
            let search = MKLocalSearch(request: searchRequest)
            search.start{ (response, error) in
                _ = response?.mapItems[0].placemark.coordinate
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
            createEventView.datePicker.isEnabled = true
            switch category {
            case "Place":
                // segue Place
                print("Clicked Place")
                
        navigationController?.pushViewController(placeViewController, animated: true)
            case "Movie":
                //segue movie
                print("Clicked Movie")
                let theatersViewController = TheatersViewController()
                navigationController?.pushViewController(theatersViewController, animated: true)
            default:
                print("Do nothing")
            }
        }
    }
    
}

extension CreateEventViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
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
extension CreateEventViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        becomeFirstResponder()
        textView.text = ""
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        resignFirstResponder()
    }
}

extension CreateEventViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension CreateEventViewController: InviteFriendsViewControllerDelegate {
    func didFinishAddingFriendsToEvent(_ friendsGoing: [Contact]) {
        self.invitedFriendsFullInfo = friendsGoing
        self.createEventView.friendsGoingCollectionView.reloadData()
        self.invitedFriendsEmails = friendsGoing.map{$0.emailAddress!}
    }
}


extension CreateEventViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return invitedFriendsFullInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "user going cell", for: indexPath) as! FriendsCollectionViewCell
        let currentFriend = invitedFriendsFullInfo[indexPath.row]
        cell.friendLabel.text = "\(currentFriend.givenName)"
        cell.friendImage.image = UIImage(data: currentFriend.imageData!)
        return cell
    }
    
    
}
extension CreateEventViewController: SelectVenueDelegate {
    func passSelectedVenueAddressToCreateEventSearchBar(addrsss: String) {
        self.createEventView.searchBar.text = addrsss
    }
    
    
}
