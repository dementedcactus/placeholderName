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
                print("error user email getting from db")
                return
            }
            guard let displayName = dataSnapshot.childSnapshot(forPath: "displayName").value as? String else {
                print("error user displayname getting from db")
                return
            }
            guard let firstName = dataSnapshot.childSnapshot(forPath: "firstName").value as? String else {
                print("error user firstName getting from db")
                return
            }
            guard let lastName = dataSnapshot.childSnapshot(forPath: "lastName").value as? String else {
                print("error user lastName getting from db")
                return
            }
            guard let profileImageUrl = dataSnapshot.childSnapshot(forPath: "profileImageUrl").value as? String else {
                print("error user profileImageUrl getting from db")
                return
            }
            guard let friendsIDs = dataSnapshot.childSnapshot(forPath: "friendsIDs").value as? [String] else {
                print("user \(displayName) has no friends")
                let currentUserProfile = UserProfile(email: email, userID: uid, displayName: displayName, firstName: firstName, lastName: lastName, profileImageUrl: profileImageUrl)
                completion(currentUserProfile)
                return
            }
            
            let currentUserProfile = UserProfile(email: email, userID: uid, displayName: displayName, firstName: firstName, lastName: lastName, profileImageUrl: profileImageUrl)
            currentUserProfile.friendsIDs = friendsIDs
            completion(currentUserProfile)
        }
    }
    
    // gets all users in database except the current logged in user
    func loadAllUsers(completionHandler: @escaping ([UserProfile]?) -> Void) {
        let ref = DatabaseService.manager.getUsers()
        ref.observe(.value) { (snapshot) in
            var allUsers = [UserProfile]()
            for child in snapshot.children {
                let dataSnapshot = child as! DataSnapshot
                if let dict = dataSnapshot.value as? [String: Any] {
                    let user = UserProfile.init(dict: dict)
                    if user.userID == FirebaseAuthService.getCurrentUser()!.uid { continue }
                    allUsers.append(user)
                }
            }
            completionHandler(allUsers)
        }
    }
    
    func getUserFriendIDs(completionHandler: @escaping ([String]?) -> Void) {
        let userRef = DatabaseService.manager.usersRef.child(FirebaseAuthService.getCurrentUser()!.uid)
        let userFriendsRef = userRef.child("friendsIDs")
        userFriendsRef.observeSingleEvent(of: .value) { (snapshot) in
            var allFriendIDs = [String]()
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let friendID = snap.value as! String
                allFriendIDs.append(friendID)
            }
            completionHandler(allFriendIDs)
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
        chatsRef.child(withEventID).observeSingleEvent(of: .value) { (dataSnapshot) in
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
