//
//  Comment.swift
//  whosfree
//
//  Created by Richard Crichlow on 3/14/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import Foundation

class Comment: NSObject {
    let eventID: String //so we can identify specific comments from the user
    let commentID: String //this should be the unique comment id
    let userID: String
    var text: String
    var timestamp: Double = Date.timeIntervalSinceReferenceDate
    
    
    static func ==(lhs: Comment, rhs: Comment) -> Bool {
        return lhs.eventID == rhs.eventID && lhs.commentID == rhs.commentID && lhs.userID == rhs.userID
    }
    
    init(eventID: String, commentID: String, userID: String, text: String) {
        self.eventID = eventID
        self.commentID = commentID
        self.userID = userID
        self.text = text
    }
    
    init(eventID: String, commentID: String, userID: String, text: String, timestamp: Double) {
        self.eventID = eventID
        self.commentID = commentID
        self.userID = userID
        self.text = text
        self.timestamp = timestamp
    }
}

extension Array where Element == Comment {
    func sortedByTimestamp() -> [Comment] {
        return self.sorted {$0.timestamp < $1.timestamp}
    }
}
