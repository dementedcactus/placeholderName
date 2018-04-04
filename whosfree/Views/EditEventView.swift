//
//  EditEventView.swift
//  whosfree
//
//  Created by Richard Crichlow on 3/25/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit

class EditEventView: CreateEventView {
    public func prefillEventFields(event: Event, eventImage: UIImage) {

        UIView.animate(withDuration: 1.75, delay: 0.05, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            
            self.bannerPhotoImageView.image = eventImage
            self.eventTitleTextField.text = event.eventName
            self.descriptionTextView.text = event.eventDescription
            self.searchBar.text = event.eventLocation
            self.datePicker.date = Date(timeIntervalSince1970: event.timestampDouble)
            self.backgroundColor = Stylesheet.Colors.SuperLightBlue
            let editEventViewObjects = [self.bannerPhotoImageView, self.eventTitleTextField, self.descriptionTextView, self.friendsGoingCollectionView] as [UIView]
            
            editEventViewObjects.forEach{($0).layer.cornerRadius = 10.0}
    
        }, completion: nil)
        
    }
}
