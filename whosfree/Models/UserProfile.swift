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
    
    
    override var description: String {
        return """
        - email: \(self.email)
        - userID: \(self.userID)
        - displayName: \(self.displayName)
        - firstName: \(self.firstName)
        - lastName: \(self.lastName)
        """
    }
    
    static func ==(lhs: UserProfile, rhs: UserProfile) -> Bool {
        return lhs.userID == rhs.userID
    }
    
    init(email: String, userID: String, displayName: String, firstName: String, lastName: String) {
        self.email = email
        self.userID = userID
        self.displayName = displayName
        self.firstName = firstName
        self.lastName = lastName
    }
}
