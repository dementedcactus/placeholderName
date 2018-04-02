//
//  InviteFriendsViewController.swift
//  whosfree
//
//  Created by Richard Crichlow on 3/23/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit
import Kingfisher
import Contacts
import MessageUI


protocol InviteFriendsViewControllerDelegate: class {
    func didFinishAddingFriendsToEvent(_ friendsGoing: [Contact])
}

class InviteFriendsViewController: UIViewController {
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(InviteFriendsViewController.handleRefresh(_:)), for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor.red
        return refreshControl
    }()
    
    @objc private func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.inviteFriendsView.tableView.reloadData()
        refreshControl.endRefreshing() //TODO: This should trigger at the end of any API calls
    }
    
    weak var delegate: InviteFriendsViewControllerDelegate?
    
    let inviteFriendsView = InviteFriendsView()
    
    let contactStore = CNContactStore()
    var contacts = [Contact]()
    var invitedContacts = [Contact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Invite Friends"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Finish", style: .done, target: self, action: #selector(finishedAddingFriends))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(cancelAddFriendsToEvent))
        setupViews()
        //Delegates
        inviteFriendsView.tableView.delegate = self
        inviteFriendsView.tableView.dataSource = self
        //inviteFriendsView.tableView.estimatedRowHeight = 80
        //inviteFriendsView.tableView.rowHeight = UITableViewAutomaticDimension
        inviteFriendsView.friendSearchbBar.delegate = self
        loadContactsFromPhone()
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
                if theContact.emailAddress == FirebaseAuthService.getCurrentUser()?.email {
                    return
                }
                self.contacts.append(theContact)
                self.contacts.sort{$0.givenName < $1.givenName}
            }
            inviteFriendsView.tableView.reloadData()
        }
        catch {
            print("unable to fetch contacts")
        }
    }
    
    private func setupViews(){
        self.view.addSubview(inviteFriendsView)
    }
    
    @objc private func finishedAddingFriends() {
        print("Finished adding friends button pressed")
        delegate?.didFinishAddingFriendsToEvent(invitedContacts)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @objc private func cancelAddFriendsToEvent() {
        self.dismiss(animated: true, completion: nil)
        print("Cancel create event pressed")
    }
    
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { alert in }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
}

extension InviteFriendsViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        inviteFriendsView.friendSearchbBar.placeholder = "Search for a Friend"
        return true
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        inviteFriendsView.friendSearchbBar.becomeFirstResponder()
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        inviteFriendsView.friendSearchbBar.resignFirstResponder()
    }
}

extension InviteFriendsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //TODO: segue to userProfile. Bonus.
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
extension InviteFriendsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExistingFriendsTableViewCell", for: indexPath) as! ExistingFriendsTableViewCell
        let friend = contacts[indexPath.row]
        cell.delegate = self
        cell.tag = indexPath.row
        cell.usernameLabel.text = "\(friend.givenName) \(friend.familyName)"
        guard let friendImageData = friend.imageData else {
            cell.userPhotoImageView.image = #imageLiteral(resourceName: "profileImagePlaceholder")
            return cell
        }
        cell.userPhotoImageView.image = UIImage(data: friendImageData)
        return cell
    }
}

extension InviteFriendsViewController: ExistingFriendsTableViewCellDelegate {
    func addedFriendToInviteList(_ tag: Int) {
        let contactToAddToEvent = contacts[tag]
        if invitedContacts.contains(where: { (contact) -> Bool in
            return contact == contactToAddToEvent
        }) {
            invitedContacts = invitedContacts.filter{ $0.phoneNumber != contactToAddToEvent.phoneNumber }
            return
        }

        invitedContacts.append(contactToAddToEvent)
    }
}


