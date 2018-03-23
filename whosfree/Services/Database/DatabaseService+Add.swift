//
//  DatabaseService+Add.swift
//  AC-iOS-Final
//
//  Created by Richard Crichlow on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseAuth

extension DatabaseService {
    
    /**
     Stores a UserProfile object in the database after account creation.
     
     - Parameter userProfile: The UserProfile object passed in.
     */
    public func addUserProfile(_ userProfile: UserProfile, _ userProfileImage: UIImage) {
        
        //let ref = usersRef.child(userProfile.userID)
        let ref = DatabaseService.manager.getUsers().child(userProfile.userID)
        
        ref.setValue(["email": userProfile.email,
                      "userID": userProfile.userID,
                      "displayName" : userProfile.displayName,
                      "firstName": userProfile.firstName,
                      "lastName": userProfile.lastName,
                      "profileImageUrl": userProfile.profileImageUrl]) { (error, dbRef) in
                        if let error = error {
                            self.delegate?.didFailAddingUserProfile?(self, error: error.localizedDescription)
                            print("\(userProfile) not added to firebase")
                        } else {
                            print("new user added @ database reference: \(dbRef)")
                            StorageService.manager.storeUserImage(image: userProfileImage, userID: userProfile.userID)
                        }
        }
    }
    
    public func addFacebookUser() {
        let userRef = DatabaseService.manager.usersRef.child(FirebaseAuthService.getCurrentUser()!.uid)
        userRef.setValue(["email"  : "",
                       "userID"    : FirebaseAuthService.getCurrentUser()!.uid,
                       "displayName"  : FirebaseAuthService.getCurrentUser()!.displayName!,
                       "firstName"  : "",
                       "lastName": ""]) { (error, dbRef) in
                        if let error = error {
                            print("addUser error: \(error.localizedDescription)")
                        } else {
                            print("facebook user added @ database reference: \(dbRef)")
                        }
        }
    }
    
    public func addFriend(newFriendID: String) {
        let theUserRef = DatabaseService.manager.usersRef.child(FirebaseAuthService.getCurrentUser()!.uid)
        theUserRef.observeSingleEvent(of: .value) { (snapshot) in
            if snapshot.hasChild("friendsIDs") {
                let userFriendsRef = theUserRef.child("friendsIDs")
                var updatedFriendsIDs = [String]()
                DatabaseService.manager.getUserFriendIDs { (currentFriendIDs) in
                    guard let currentFriendIDs = currentFriendIDs else {
                        print("Could not get current friends")
                        self.addFriendDelegate?.didFailAddFriend(newFriendID, message: "could not get current friends")
                        return
                    }
                    updatedFriendsIDs = currentFriendIDs
                    if !updatedFriendsIDs.contains(newFriendID) {
                        updatedFriendsIDs.append(newFriendID)
                    } else {
                        print("You are already friends with this user")
                        self.addFriendDelegate?.didFailAddFriend(newFriendID, message: "You are already friends with this user")
                        return
                    }
                    userFriendsRef.setValue(updatedFriendsIDs) { (error, dbRef) in
                        if let error = error {
                            print("error adding friend with UID: \(newFriendID) - \(error.localizedDescription)")
                            self.addFriendDelegate?.didFailAddFriend(newFriendID, message: "Could not add new friend")
                        } else {
                            self.addFriendDelegate?.didAddFriend(newFriendID, message: "New friend added")
                            print("New friend Added!")
                        }
                    }
                }
            } else {
                theUserRef.child("friendsIDs").setValue([newFriendID], withCompletionBlock: { (error, dbRef) in
                    if let error = error {
                        print("error adding friend with UID: \(newFriendID) - \(error.localizedDescription)")
                        self.addFriendDelegate?.didFailAddFriend(newFriendID, message: "Could not add new friend")
                    } else {
                        self.addFriendDelegate?.didAddFriend(newFriendID, message: "New friend Added!")
                        print("New friend Added!")
                    }
                })
            }
        }
    }
    
    public func addEvent(_ eventToSave: Event, _ eventImage: UIImage) {
        //1. find ref
        let ref = eventsRef.child(eventToSave.eventID)
        //let childByAutoId = DatabaseService.manager.getEvents().childByAutoId()
        //2. call set value with completion handler
        ref.setValue(["eventID": eventToSave.eventID,
                      "eventName": eventToSave.eventName,
                      "ownerUserID": eventToSave.ownerUserID,
                      "eventDescription": eventToSave.eventDescription,
                      "eventLocation": eventToSave.eventLocation,
                      "timestamp": eventToSave.timestamp,
                      "eventBannerImgUrl": eventToSave.eventBannerImgUrl
                      //"rsvpNo": eventToSave.rsvpNo ?? "Empty",
                      //"rsvpMaybe": eventToSave.rsvpMaybe ?? "Empty",
                      //"rsvpYes": eventToSave.rsvpYes ?? "Empty"
        ]) { (error, dbRef) in
            if let error = error {
                //TODO: delegates for letting the user know fail/success saving event
                print(error)
            } else {
                print("Event added @ database reference: \(dbRef)")
                StorageService.manager.storeEventImage(image: eventImage, eventID: eventToSave.eventID)
                //self.refreshDelegate?.refreshTableView()
                //self.showAlertDelegate?.showAlertDelegate(nameOfWhatYoureSaving: "Event")
            }
        }
    }
    
    /**
     Adds a comment to the current event.
     
     - Parameters:
     - text: The comment text.
     - eventID: The ID of the current, selected event.
     */
    public func addComment(eventID: String, userID: String, phoneNumber: String, email: String, text: String) {

            let ref = chatsRef.child(eventID).childByAutoId()
            
            let comment = Comment(eventID: eventID, userID: userID, phoneNumber: phoneNumber, email: email, commentID: ref.key, timestamp: Date.timeIntervalSinceReferenceDate, text: text)
    
            ref.setValue(["eventID": eventID,
                          "userID": comment.userID ?? "NoUserID",
                          "phoneNumber": comment.phoneNumber ?? "NoNumber",
                          "email": comment.email ?? "NoEmail",
                          "commentID": comment.commentID,
                          "timestamp": comment.timestamp,
                          "text": comment.text
            ]) { (error, _) in
                if let error = error {
                    self.delegate?.didFailAddingComment?(self, error: error.localizedDescription)
                } else {
                    self.delegate?.didAddComment?(self)
                }
            }
    
            print("new comment added to database!!")
        }
 
 
}
