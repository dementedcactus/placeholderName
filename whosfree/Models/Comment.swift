//
//  Comment.swift
//  whosfree
//
//  Created by Richard Crichlow on 3/14/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import Foundation

class Comment: NSObject {
    let eventID: String
    let userID: String?
    var phoneNumber: String?
    var email: String?
    let commentID: String
    var timestamp: Double = Date.timeIntervalSinceReferenceDate
    var text: String
    
    
    static func ==(lhs: Comment, rhs: Comment) -> Bool {
        return lhs.eventID == rhs.eventID && lhs.commentID == rhs.commentID && lhs.userID == rhs.userID && lhs.phoneNumber == rhs.phoneNumber && lhs.email == rhs.email
    }
    
    init(dict: [String : Any]) {
        eventID = dict["eventID"] as? String ?? ""
        userID = dict["userID"] as? String ?? ""
        phoneNumber = dict["phoneNumber"] as? String ?? ""
        email = dict["email"] as? String ?? ""
        commentID = dict["commentID"] as? String ?? ""
        timestamp = dict["timestamp"] as? Double ?? 0.0
        text = dict["text"] as? String ?? ""
    }
    
    init(eventID: String, userID: String?, phoneNumber: String?, email: String?, commentID: String, timestamp: Double, text: String) {
        self.eventID = eventID
        self.userID = userID
        self.phoneNumber = phoneNumber
        self.email = email
        self.commentID = commentID
        self.text = text
        self.timestamp = timestamp
    }
}

extension Array where Element == Comment {
    func sortedByTimestamp() -> [Comment] {
        return self.sorted {$0.timestamp < $1.timestamp}
    }
}
