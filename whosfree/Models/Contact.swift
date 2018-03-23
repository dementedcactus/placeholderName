//
//  Contact.swift
//  whosfree
//
//  Created by Luis Calle on 3/23/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import Foundation

struct Contact {
    let givenName: String
    let middleName: String
    let familyName: String
    let nameSuffix: String
    let location: String?
    let birthday: String?
    let emailAddress: String?
    let phoneNumber: String?
    let imageData: Data?
    
    static func ==(lhs: Contact, rhs: Contact) -> Bool {
        return lhs.phoneNumber == rhs.phoneNumber
    }
}
