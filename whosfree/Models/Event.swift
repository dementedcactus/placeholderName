//
//  Event.swift
//  whosfree
//
//  Created by Richard Crichlow on 3/14/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import Foundation

class Event: NSObject {
    let eventID: String
    let eventName: String
    let ownerUserID: String
    var text: String
    var timestamp: Double = Date.timeIntervalSinceReferenceDate //nicely format date for Richard
    var rsvpNo: String? //[String of user ids]
    var rsvpMaybe: String? //[String of All invited user ids]
    var rsvpYes: String? //[String of user ids]
    //var eventType: String
    //var location: String
    //var eventBannerImgUrl: String
    
    static func ==(lhs: Event, rhs: Event) -> Bool {
        return lhs.eventID == rhs.eventID && lhs.eventName == rhs.eventName && lhs.ownerUserID == rhs.ownerUserID
    }
    
    init(eventID: String, commentID: String, userID: String, text: String) {
        self.eventID = eventID
        self.eventName = commentID
        self.ownerUserID = userID
        self.text = text
    }
    
    init(eventID: String, commentID: String, userID: String, text: String, timestamp: Double) {
        self.eventID = eventID
        self.eventName = commentID
        self.ownerUserID = userID
        self.text = text
        self.timestamp = timestamp
    }
    
    init(eventID: String, eventName: String, ownerUserID: String, text: String, timestamp: Double, rsvpNo: String?, rsvpMaybe: String?, rsvpYes: String?) {
        self.eventID = eventID
        self.eventName = eventName
        self.ownerUserID = ownerUserID
        self.text = text
        self.timestamp = timestamp
        self.rsvpNo = rsvpNo
        self.rsvpMaybe = rsvpMaybe
        self.rsvpYes = rsvpYes
    }
}

extension Array where Element == Event {
    func sortedByTimestamp() -> [Event] {
        return self.sorted {$0.timestamp < $1.timestamp}
    }
}
