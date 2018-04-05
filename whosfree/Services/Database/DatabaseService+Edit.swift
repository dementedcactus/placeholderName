//
//  DatabaseService+Edit.swift
//  mansnothot
//
//  Created by C4Q on 2/2/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit
import FirebaseDatabase

extension DatabaseService {
    
    public func editEvent(_ eventToSave: Event, _ eventImage: UIImage) {
        //1. find ref
        let ref = eventsRef.child(eventToSave.eventID)
        //let childByAutoId = DatabaseService.manager.getEvents().childByAutoId()
        //2. call set value with completion handler
        ref.setValue(["eventID": eventToSave.eventID,
                      "eventName": eventToSave.eventName,
                      "ownerUserID": eventToSave.ownerUserID,
                      "eventDescription": eventToSave.eventDescription,
                      "eventLocation": eventToSave.eventLocation,
                      "timestamp": eventToSave.timestamp,
                      "eventBannerImgUrl": eventToSave.eventBannerImgUrl,
                      "invitedFriendsEmails": eventToSave.invitedFriendsEmails,
                      "timestampDouble": eventToSave.timestampDouble
            //"rsvpNo": eventToSave.rsvpNo ?? "Empty",
            //"rsvpMaybe": eventToSave.rsvpMaybe ?? "Empty",
            //"rsvpYes": eventToSave.rsvpYes ?? "Empty"
        ]) { (error, dbRef) in
            if let error = error {
                //TODO: delegates for letting the user know fail/success saving event
                print(error)
            } else {
                print("Event added @ database reference: \(dbRef)")
                StorageService.manager.storeEventImage(image: eventImage, eventID: eventToSave.eventID)
                //self.refreshDelegate?.refreshTableView()
                //self.showAlertDelegate?.showAlertDelegate(nameOfWhatYoureSaving: "Event")
            }
        }
    }
    
//    public func editProfileImage(withUserID userID: String, image: UIImage) {
//        StorageService.manager.storeUserImage(image: image, withUserID: userID) { (errorMessage, imageURL) in
//            if let errorMessage = errorMessage {
//                self.delegate?.didFailChangingUserImage?(self, error: errorMessage)
//                print("couldn't change user iamge")
//            } else if let imageURL = imageURL {
//                self.delegate?.didChangeUserImage?(self, toImageURL: imageURL)
//                print("changed user image")
//            }
//        }
//    }
    
    
}
