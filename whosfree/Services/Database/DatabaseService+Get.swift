//
//  DatabaseService+Get.swift
//  AC-iOS-Final
//
//  Created by Richard Crichlow on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation
import FirebaseDatabase

extension DatabaseService {
    
    public func getUserProfile(withUID uid: String, completion: @escaping (_ userProfile: UserProfile) -> Void) {
        let ref = usersRef.child(uid)
        ref.observe(.value) { (dataSnapshot) in
            guard let email = dataSnapshot.childSnapshot(forPath: "email").value as? String else {
                return
            }
            guard let displayName = dataSnapshot.childSnapshot(forPath: "displayName").value as? String else {
                return
            }
            guard let firstName = dataSnapshot.childSnapshot(forPath: "firstName").value as? String else {
                return
            }
            guard let lastName = dataSnapshot.childSnapshot(forPath: "lastName").value as? String else {
                return
            }
            
            let currentUserProfile = UserProfile(email: email, userID: uid, displayName: displayName, firstName: firstName, lastName: lastName)
            completion(currentUserProfile)
        }
    }
 
    func getAllEvents(completion: @escaping ([Event]?) -> Void) {
        eventsRef.observeSingleEvent(of: .value) { (dataSnapshot) in
            guard let arrayOfAllEventsSnapshot = dataSnapshot.children.allObjects as? [DataSnapshot] else {
                print("could not get children snapshots")
                completion(nil)
                return
            }
            var eventArrayToReturn: [Event] = [] // This is the empty events array that will be filled by the completion handler
            for postSnapshot in arrayOfAllEventsSnapshot {
                guard let savedEventDictionary = postSnapshot.value as? [String : Any] else {
                    print("could not get saved jobs dict")
                    completion(nil)
                    return
                }
                guard let eventID = savedEventDictionary["eventID"] as? String else {
                    completion(nil)
                    return
                }
                guard let eventName = savedEventDictionary["eventName"] as? String else {
                    completion(nil)
                    return
                }
                guard let ownerUserID = savedEventDictionary["ownerUserID"] as? String else {
                    completion(nil)
                    return
                }
                guard let text = savedEventDictionary["text"] as? String else {
                    completion(nil)
                    return
                }
                guard let timestamp = savedEventDictionary["timestamp"] as? Double else {
                    completion(nil)
                    return
                }
                guard let rsvpNo = savedEventDictionary["rsvpNo"] as? String else {
                    completion(nil)
                    return
                }
                guard let rsvpMaybe = savedEventDictionary["rsvpMaybe"] as? String else {
                    completion(nil)
                    return
                }
                guard let rsvpYes = savedEventDictionary["rsvpYes"] as? String else {
                    completion(nil)
                    return
                }
                
                let event = Event(eventID: eventID, eventName: eventName, ownerUserID: ownerUserID, text: text, timestamp: timestamp, rsvpNo: rsvpNo, rsvpMaybe: rsvpMaybe, rsvpYes: rsvpYes)
                eventArrayToReturn.append(event)
            }
            completion(eventArrayToReturn)
        }
    }
    
    func getChat(withEventID: String, completion: @escaping ([Comment]?) -> Void) {
        chatRef.child(withEventID).observeSingleEvent(of: .value) { (dataSnapshot) in
            guard let arrayOfAllCommentsSnapshot = dataSnapshot.children.allObjects as? [DataSnapshot] else {
                print("could not get children snapshots")
                completion(nil)
                return
            }
            var commentsArrayToReturn: [Comment] = [] // This is the empty comments array that will be filled by the completion handler
            for postSnapshot in arrayOfAllCommentsSnapshot {
                guard let commentDictionary = postSnapshot.value as? [String : Any] else {
                    print("could not get comments dict")
                    completion(nil)
                    return
                }
                guard let eventID = commentDictionary["eventID"] as? String else {
                    completion(nil)
                    return
                }
                guard let commentID = commentDictionary["commentID"] as? String else {
                    completion(nil)
                    return
                }
                guard let userID = commentDictionary["userID"] as? String else {
                    completion(nil)
                    return
                }
                guard let text = commentDictionary["text"] as? String else {
                    completion(nil)
                    return
                }
                guard let timestamp = commentDictionary["timestamp"] as? Double else {
                    completion(nil)
                    return
                }
                
                let comment = Comment(eventID: eventID, commentID: commentID, userID: userID, text: text, timestamp: timestamp)
                commentsArrayToReturn.append(comment)
            }
            completion(commentsArrayToReturn)
        }
    }
 
}
