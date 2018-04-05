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
    var eventDescription: String
    var eventLocation: String
//    var timestamp: Double = Date.timeIntervalSinceReferenceDate //nicely format date for Richard
    var timestamp: String
    var timestampDouble: Double
    var eventBannerImgUrl: String
    var friendsGoing: [String]?
    var invitedFriendsEmails: [String]
    //var rsvpNo: String? //[String of user ids]
    //var rsvpMaybe: String? //[String of All invited user ids]
    //var rsvpYes: String? //[String of user ids]
    //var eventType: String
    
    override var description: String {
        return """
        Event Name: \(self.eventName)<br />
        Event Description: \(self.eventDescription)<br />
        Where? \(self.eventLocation)<br />
        When? \(self.timestamp)<br />
        """
    }
    
    static func ==(lhs: Event, rhs: Event) -> Bool {
        return lhs.eventID == rhs.eventID && lhs.eventName == rhs.eventName && lhs.ownerUserID == rhs.ownerUserID
    }
    
//    init(eventID: String, commentID: String, userID: String, text: String) {
//        self.eventID = eventID
//        self.eventName = commentID
//        self.ownerUserID = userID
//        self.eventDescription = text
//    }
//
//    init(eventID: String, commentID: String, userID: String, text: String, timestamp: Double) {
//        self.eventID = eventID
//        self.eventName = commentID
//        self.ownerUserID = userID
//        self.eventDescription = text
//        self.timestamp = timestamp
//    }
    
//    init(eventID: String, eventName: String, ownerUserID: String, eventDescription: String, timestamp: Double, rsvpNo: String?, rsvpMaybe: String?, rsvpYes: String?) {
//        self.eventID = eventID
//        self.eventName = eventName
//        self.ownerUserID = ownerUserID
//        self.eventDescription = text
//        self.timestamp = timestamp
//        self.rsvpNo = rsvpNo
//        self.rsvpMaybe = rsvpMaybe
//        self.rsvpYes = rsvpYes
//    }
    
    init(eventID: String, eventName: String, ownerUserID: String, eventDescription: String, eventLocation: String, timestamp: String, eventBannerImgUrl: String, invitedFriendsEmails: [String], timestampDouble: Double) {
        self.eventID = eventID
        self.eventName = eventName
        self.ownerUserID = ownerUserID
        self.eventDescription = eventDescription
        self.eventLocation = eventLocation
        self.timestamp = timestamp
        self.timestampDouble = timestampDouble
        self.eventBannerImgUrl = eventBannerImgUrl
        self.invitedFriendsEmails = invitedFriendsEmails
    }
    
    init(dict: [String : Any]) {
        eventID = dict["eventID"] as? String ?? ""
        eventName = dict["eventName"] as? String ?? ""
        ownerUserID = dict["ownerUserID"] as? String ?? ""
        eventDescription = dict["eventDescription"] as? String ?? ""
        eventLocation = dict["eventLocation"] as? String ?? ""
        timestamp = dict["timestamp"] as? String ?? ""
        eventBannerImgUrl = dict["eventBannerImgUrl"] as? String ?? ""
        friendsGoing = dict["friendsGoing"] as? [String] ?? []
        invitedFriendsEmails = dict["invitedFriendsEmails"] as? [String] ?? []
        timestampDouble = dict["timestampDouble"] as? Double ?? 0.0
    }
}

extension Array where Element == Event {
    func sortedByTimestamp() -> [Event] {
        return self.sorted {$0.timestampDouble < $1.timestampDouble}
    }
}
