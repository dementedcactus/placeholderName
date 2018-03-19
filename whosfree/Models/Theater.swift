//
//  Theater.swift
//  LuisWhosFreeViewControllers
//
//  Created by Luis Calle on 3/16/18.
//  Copyright © 2018 Lucho. All rights reserved.
//

import Foundation

struct Theater: Codable {
    let theatreId: String
    let name: String
    let location: TheaterLocationWrapper
}

struct TheaterLocationWrapper: Codable {
    let distance: Double
    let telephone: String?
    let geoCode: GeoCodeWrapper
    let address: TheaterAddressWrapper
}

struct GeoCodeWrapper: Codable {
    let latitude: String
    let longitude: String
}

struct TheaterAddressWrapper: Codable {
    let street: String
    let state: String
    let city: String
    let country: String
    let postalCode: String
}


