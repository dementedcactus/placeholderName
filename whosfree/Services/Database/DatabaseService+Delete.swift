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
//        let theEventRef = DatabaseService.manager.eventsRef.child(eventID)
//        theEventRef.observeSingleEvent(of: .value) { (snapshot) in
//            if snapshot.hasChild("friendsGoing") {
//                let friendsGoingRef = theEventRef.child("friendsGoing")
//                var updatedFriendsGoing = [String]()
//                DatabaseService.manager.getUserFriendsGoing(eventID: eventID) { (currentFriendsGoing) in
//                    guard let currentFriendsGoing = currentFriendsGoing else {
//                        print("Could not get current friends going")
//                        return
//                    }
//                    updatedFriendsGoing = currentFriendsGoing
//                    if !updatedFriendsGoing.contains(userID) {
//                        updatedFriendsGoing.append(userID)
//                    } else {
//                        print("You are already friends with this user")
//                        return
//                    }
//                    friendsGoingRef.setValue(updatedFriendsGoing) { (error, dbRef) in
//                        if let error = error {
//                            print("error adding friend with UID: \(userID) - \(error.localizedDescription)")
//                        } else {
//                            print("New friend Added!")
//                        }
//                    }
//                }
//            } else {
//                theEventRef.child("friendsGoing").setValue([userID], withCompletionBlock: { (error, dbRef) in
//                    if let error = error {
//                        print("error adding friend \(userID) to event: - \(error.localizedDescription)")
//                    } else {
//                        print("Friend \(userID) added to event!")
//                    }
//                })
//            }
//        }
    }
    
    
    
}
