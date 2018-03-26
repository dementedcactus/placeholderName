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
        createEventButton.setTitle("Edit", for: .normal)
        bannerPhotoImageView.image = eventImage
        eventTitleTextField.text = event.eventName
        descriptionTextView.text = event.eventDescription
        searchBar.text = event.eventLocation
    }

}
