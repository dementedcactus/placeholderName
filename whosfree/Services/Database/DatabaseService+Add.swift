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
     Adds a comment to the current post.
     
     - Parameters:
     - text: The comment text.
     - postID: The ID of the current, selected post.
     */
//    public func addComment(withText text: String, andEventID eventID: String) {
//        guard let userID = AuthUserService.manager.getCurrentUser()?.uid else {
//            print("Error: could not get current user id, please exit the app and log back in.")
//            return
//        }
//        let ref = chatRef.child(eventID).childByAutoId()
//        let comment = Comment(eventID: eventID, commentID: ref.key, userID: userID, text: text)
//        
//        ref.setValue(["eventID": eventID,
//                      "commentID": comment.commentID,
//                      "userID": comment.userID,
//                      "text": comment.text,
//                      "timestamp": comment.timestamp
//        ]) { (error, _) in
//            if let error = error {
//                self.delegate?.didFailAddingComment?(self, error: error.localizedDescription)
//            } else {
//                self.delegate?.didAddComment?(self)
//            }
//        }
//        
//        print("new comment added to database!!")
//    }
    
    /**
     Stores a UserProfile object in the database after account creation.
     
     - Parameter userProfile: The UserProfile object passed in.
     */
    public func addUserProfile(_ userProfile: UserProfile) {
        
        let ref = usersRef.child(userProfile.userID)
        
        ref.setValue(["email": userProfile.email,
                      "userID": userProfile.userID,
                      "displayName" : userProfile.displayName,
                      "firstName": userProfile.firstName,
                      "lastName": userProfile.lastName
            
        ]) { (error, _) in
            if let error = error {
                self.delegate?.didFailAddingUserProfile?(self, error: error.localizedDescription)
                print("\(userProfile) not added to firebase")
            } else {
                print("new user added to database!!")
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
                            print("user added @ database reference: \(dbRef)")
                        }
        }
    }
    
    
    public func addEvent(_ eventToSave: Event) {
        //1. find ref
        let ref = eventsRef.child(eventToSave.eventID)
        
        //2. call set value with completion handler
        ref.setValue(["eventID": eventToSave.eventID,
                      "eventName": eventToSave.eventName,
                      "ownerUserID": eventToSave.ownerUserID,
                      "text": eventToSave.text,
                      "timestamp": eventToSave.timestamp,
                      "rsvpNo": eventToSave.rsvpNo ?? "Empty",
                      "rsvpMaybe": eventToSave.rsvpMaybe ?? "Empty",
                      "rsvpYes": eventToSave.rsvpYes ?? "Empty"
        ]) { (error, nil) in
            if let error = error {
                print(error)
            } else {
                print("Event Saved")
                self.refreshDelegate?.refreshTableView()
                self.showAlertDelegate?.showAlertDelegate(nameOfWhatYoureSaving: "Event")
            }
        }
    }
 
 
}
