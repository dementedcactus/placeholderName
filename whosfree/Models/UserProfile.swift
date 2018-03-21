//
//  UserProfile.swift
//  AC-iOS-Final
//
//  Created by Richard Crichlow on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation
import FirebaseAuth

class UserProfile: NSObject{
    let email: String
    let userID: String
    var displayName: String
    let firstName: String
    let lastName: String
    var profileImageUrl: String
    var friendsIDs: [String]? //of userIds
    
    override var description: String {
        return """
        - email: \(self.email)
        - userID: \(self.userID)
        - displayName: \(self.displayName)
        - firstName: \(self.firstName)
        - lastName: \(self.lastName)
        - profileImageUrl:  \(self.profileImageUrl)
        - friendsIDs: \(self.friendsIDs ?? [])
        """
    }
    
    static func ==(lhs: UserProfile, rhs: UserProfile) -> Bool {
        return lhs.userID == rhs.userID
    }
    
    init(email: String, userID: String, displayName: String, firstName: String, lastName: String, profileImageUrl: String) {
        self.email = email
        self.userID = userID
        self.displayName = displayName
        self.firstName = firstName
        self.lastName = lastName
        self.profileImageUrl = profileImageUrl
        //self.friendsIDs = friendsIDs
    }
    
    init(dict: [String : Any]) {
        email = dict["email"] as? String ?? ""
        userID = dict["userID"] as? String ?? ""
        displayName = dict["displayName"] as? String ?? ""
        firstName = dict["firstName"] as? String ?? ""
        lastName = dict["lastName"] as? String ?? ""
        profileImageUrl = dict["profileImageUrl"] as? String ?? ""
        friendsIDs = dict["friendsIDs"] as? [String] ?? []
    }
}
