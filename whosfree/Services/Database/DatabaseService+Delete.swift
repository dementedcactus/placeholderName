//
//  DatabaseService+Delete.swift
//  mansnothot
//
//  Created by C4Q on 2/6/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import Foundation
import FirebaseDatabase

extension DatabaseService {
    public func deleteEvent(withPostID postID: String) {
        eventsRef.child(postID).removeValue { (error, _) in
            if let error = error {
                self.delegate?.didFailDeletingPost?(self, error: error.localizedDescription)
            } else {
                self.delegate?.didDeletePost?(self, withPostID: postID)
            }
        }
    }
    
    public func clickedRSVPNotGoing(to eventID: String) {
        let theEventRef = DatabaseService.manager.eventsRef.child(eventID)
        theEventRef.observeSingleEvent(of: .value) { (snapshot) in
            if snapshot.hasChild("friendsGoing") {
                let friendsGoingRef = theEventRef.child("friendsGoing")
                var updatedFriendsGoing = [String]()
                DatabaseService.manager.getUserFriendsGoing(eventID: eventID) { (currentFriendsGoing) in
                    guard let currentFriendsGoing = currentFriendsGoing else {
                        print("Could not get current friends going")
                        return
                    }
                    updatedFriendsGoing = currentFriendsGoing
                    if !updatedFriendsGoing.contains(FirebaseAuthService.getCurrentUser()!.email!) {
                        print("Havent rsvpd yet!")
                        return
                    } else {
                        updatedFriendsGoing = currentFriendsGoing.filter{ $0 != FirebaseAuthService.getCurrentUser()!.email!}
                    }
                    friendsGoingRef.setValue(updatedFriendsGoing) { (error, dbRef) in
                        if let error = error {
                            print("error not going- \(error.localizedDescription)")
                        } else {
                            print("not going successfully")
                        }
                    }
                }
            }
        }
    }
    
    
    
}
