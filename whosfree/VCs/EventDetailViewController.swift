//
//  EventDetailViewController.swift
//  whosfree
//
//  Created by Richard Crichlow on 3/16/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit
import MapKit
import Contacts

class EventDetailViewController: UIViewController {

    let eventDetailView = EventDetailView()
    lazy var editVC = EditEventViewController(event: event, eventImage: eventImage)
    let dummyData = ["test1 title", "test2 title", "test3 title", "test4 title", "test5 title"]
    private let cellSpacing: CGFloat =  5.0
    var coordinate: CLLocationCoordinate2D?
    var goingFriends = [String]()
    
    var event: Event!
    var eventImage: UIImage!
    
    let contactStore = CNContactStore()
    var allContacts = [Contact]()
    var filteredContacts = [Contact]()
    
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
        
        self.eventDetailView.collectionView.dataSource = self
        self.eventDetailView.collectionView.delegate = self
        self.eventDetailView.rsvpButton.addTarget(self, action: #selector(rsvp), for: .touchUpInside)
        self.eventDetailView.deleteButton.addTarget(self, action: #selector(deleteEvent), for: .touchUpInside)
        self.eventDetailView.editButton.addTarget(self, action: #selector(editEvent), for: .touchUpInside)
        eventDetailView.mapImageView.delegate = self
        let _ = LocationService.manager.checkForLocationServices()
        configureNavBar()
        eventDetailView.configureView(event: event, eventImage: eventImage)
        configureScrollView(event: event)
        editVC.editDelegate = self
        loadContactsFromPhone()
        eventDetailView.goingButton.addTarget(self, action: #selector(showGoing), for: .touchUpInside)
        eventDetailView.notGoingButton.addTarget(self, action: #selector(showNotGoing), for: .touchUpInside)
        eventDetailView.allInvitedButton.addTarget(self, action: #selector(allInvited), for: .touchUpInside)
        showGoing()
    }
    
    @objc private func showGoing() {
        opacityWhenGoingClicked()
        filteredContacts.removeAll()
        DatabaseService.manager.getUserFriendsGoing(eventID: event.eventID) { (going) in
            guard let going = going else {
                print("could not get friends going")
                return
            }
            for contact in self.allContacts {
                guard let email = contact.emailAddress else {
                    continue
                }
                if going.contains(email) {
                    self.filteredContacts.append(contact)
                }
            }
            self.eventDetailView.collectionView.reloadData()
        }
    }
    
    
    @objc private func showNotGoing() {
        opacityWhenNotGoingClicked()
        filteredContacts.removeAll()
        DatabaseService.manager.getAllUserFriendsInvited(eventID: event.eventID) { (allInvited) in
            DatabaseService.manager.getUserFriendsGoing(eventID: self.event.eventID, completionHandler: { (allGoing) in
                guard let allInvited = allInvited, let allGoing = allGoing else {
                    print("Error getting data")
                    return
                }
                let all = Set(allInvited)
                let notGoing = all.subtracting(Set(allGoing))
                for contact in self.allContacts {
                    guard let email = contact.emailAddress else {
                        continue
                    }
                    if notGoing.contains(email) {
                        self.filteredContacts.append(contact)
                    }
                }
                self.eventDetailView.collectionView.reloadData()
            })
        }
    }
    
    @objc private func allInvited() {
        opacityWhenAllInvitedClicked()
        filteredContacts.removeAll()
        DatabaseService.manager.getAllUserFriendsInvited(eventID: event.eventID) { (invited) in
            guard let invited = invited else {
                print("Could not get invited list")
                return
            }
            for contact in self.allContacts {
                guard let email = contact.emailAddress else {
                    continue
                }
                if invited.contains(email) {
                    self.filteredContacts.append(contact)
                }
            }
            self.eventDetailView.collectionView.reloadData()
            
        }
    }
    
    private func opacityWhenGoingClicked() {
        eventDetailView.goingButton.alpha = 1.0
        eventDetailView.notGoingButton.alpha = 0.5
        eventDetailView.allInvitedButton.alpha = 0.5
    }
    
    private func opacityWhenNotGoingClicked() {
        eventDetailView.goingButton.alpha = 0.5
        eventDetailView.notGoingButton.alpha = 1.0
        eventDetailView.allInvitedButton.alpha = 0.5
    }
    
    private func opacityWhenAllInvitedClicked() {
        eventDetailView.goingButton.alpha = 0.5
        eventDetailView.notGoingButton.alpha = 0.5
        eventDetailView.allInvitedButton.alpha = 1.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        eventDetailView.configureView(event: event, eventImage: eventImage)
        configureScrollView(event: event)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.eventDetailView.locationButton.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
    }
    public func configureScrollView(event: Event) {
        turnAddressIntoCoordinates(address: event.eventLocation, completionHandler: { (coordinate) in
            self.configureMapView(coordinate: coordinate)
        }) { (error) in
            
        }
    }
    
    private func loadContactsFromPhone() {
        let keys = [CNContactGivenNameKey, CNContactMiddleNameKey, CNContactFamilyNameKey, CNContactNameSuffixKey, CNContactPostalAddressesKey, CNContactBirthdayKey,  CNContactEmailAddressesKey, CNContactTypeKey, CNContactPhoneNumbersKey,CNContactDepartmentNameKey, CNContactImageDataKey]
        let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
        do {
            try contactStore.enumerateContacts(with: request) {
                (contact, stop) in
                let givenName = contact.givenName
                let middleName = contact.middleName
                let familyName = contact.familyName
                let nameSuffix = contact.nameSuffix
                var location: String?
                if let firstLocation = contact.postalAddresses.first {
                    location = "\(firstLocation.value.street) \(firstLocation.value.city) \(firstLocation.value.state) \(firstLocation.value.postalCode)"
                }
                var birthday: String?
                if let birthdayUnwrapped = contact.birthday, let day = birthdayUnwrapped.day, let month = birthdayUnwrapped.month, let year = birthdayUnwrapped.year {
                    birthday = "\(day) \(month) \(year)"
                }
                var emailAddress: String?
                if let firstEmailAddress = contact.emailAddresses.first {
                    emailAddress = firstEmailAddress.value.description
                }
                var phoneNumber: String?
                if let firstPhoneNumber = contact.phoneNumbers.first {
                    phoneNumber = firstPhoneNumber.value.stringValue
                }
                var imageData: Data?
                if let imageDataUnwrapped =  contact.imageData {
                    imageData = imageDataUnwrapped
                }
                let theContact = Contact(givenName: givenName, middleName: middleName, familyName: familyName, nameSuffix: nameSuffix, location: location, birthday: birthday, emailAddress: emailAddress, phoneNumber: phoneNumber, imageData: imageData)
                self.allContacts.append(theContact)
                self.allContacts.sort{$0.givenName < $1.givenName}
            }
        }
        catch {
            print("unable to fetch contacts")
        }
    }
    
    
    private func configureMapView(coordinate: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        eventDetailView.mapImageView.addAnnotation(annotation)
        let region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        eventDetailView.mapImageView.setRegion(region, animated: true)
    }
    
    private func turnAddressIntoCoordinates(address: String,
                                            completionHandler: @escaping (CLLocationCoordinate2D) -> Void,
                                            errorHandler: @escaping (Error) -> Void) {
        CLGeocoder().geocodeAddressString(address) { (placemarks, error) in
            if let error = error {
                errorHandler(error)
            }
            if let placemarks = placemarks {
                let placemark = placemarks.first
                self.coordinate = placemark?.location?.coordinate
                completionHandler(self.coordinate!)
            }
        }
    }
    
    @objc private func deleteEvent() {
        deleteAction(title: "Delete", message: "Are you sure you want to delete event?")
    }
    
    private func deleteAction(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) {(alert) in
            print("pressed Delete")
            DatabaseService.manager.deleteEvent(withPostID: self.event.eventID)
            self.navigationController?.popViewController(animated: true)
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
            DatabaseService.manager.addInvitedUserThatAccepted(to: self.event.eventID, with: FirebaseAuthService.getCurrentUser()!.email!)
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
        navigationController?.pushViewController(editVC, animated: true)
    }
    
    @objc private func segueToChatViewController() {
        let chatVC = ChatViewController()
        chatVC.specificEventIDsChat = event.eventID
        navigationController?.pushViewController(chatVC, animated: true)
    }
}
extension EventDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredContacts.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "user going cell", for: indexPath) as! FriendsCollectionViewCell
        let contact = filteredContacts[indexPath.row]
        cell.friendLabel.text = "\(contact.givenName)"
        cell.friendImage.image = UIImage(data: contact.imageData!)
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
extension EventDetailViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation { return nil }
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "annotationView") as? MKMarkerAnnotationView
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "annotationView")
            annotationView?.canShowCallout = true
            annotationView?.animatesWhenAdded = true
            annotationView?.markerTintColor = Stylesheet.Colors.azure
            annotationView?.isHighlighted = true
        } else {
            annotationView?.annotation = annotation
        }
        return annotationView
    }
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("User tapped on annotation")
        openAppleMaps()
        //        let annotation = MKPointAnnotation()
        //        if let coordinate = coordinate {
        //            annotation.coordinate = coordinate
        //        }
        
    }
    private func openAppleMaps() {
        //        guard let latAndLong = venue.location.labeledLatLngs else {
        //            // alert controller there is no lat and long
        //            return
        //        }
        if LocationService.manager.checkForLocationServices() == .denied {
            guard let validSettings: URL = URL(string: UIApplicationOpenSettingsURLString) else { return }
            UIApplication.shared.open(validSettings, options: [:], completionHandler: nil)
            return
        }
        let userCoordinate = CLLocationCoordinate2D(latitude: LocationService.manager.getCurrentLatitude()!, longitude: LocationService.manager.getCurrentLongitude()!)
        let placeCoordinate = CLLocationCoordinate2D(latitude: (coordinate?.latitude)!, longitude: (coordinate?.longitude)!)
        let directionsURLString = "http://maps.apple.com/?saddr=\(userCoordinate.latitude),\(userCoordinate.longitude)&daddr=\(placeCoordinate.latitude),\(placeCoordinate.longitude)"
        UIApplication.shared.open(URL(string: directionsURLString)!, options: [:]) { (done) in
            print("launched apple maps")
        }
    }
}
extension EventDetailViewController: EditDelegate {
    func passEditedEventBackToEventDetailVC(event: Event, eventImage: UIImage, date: Date) {
        self.event = event
        self.eventDetailView.bannerPhotoImageView.image = eventImage
        self.eventDetailView.datePicker.date = date
    }
}
