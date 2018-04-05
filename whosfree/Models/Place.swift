//
//  Venue.swift
//  LuisWhosFreeViewControllers
//
//  Created by Luis Calle on 3/17/18.
//  Copyright © 2018 Lucho. All rights reserved.
//

import Foundation

struct YelpResponse: Codable {
    let businesses: [Place]
}

struct Place: Codable {
    let id: String
    let name: String
    let image_url: String
    let is_closed: Bool
    let url: String
    let review_count: Int
    let categories: [CategoriesWrapper]
    let rating: Double
    let coordinates: CoordinatesWrapper
    let transactions: [String]
    let price: String?
    let location: LocationWrapper
    let phone: String
    let display_phone: String
    let distance: Double
}

struct CategoriesWrapper: Codable {
    let alias: String
    let title: String
}

struct CoordinatesWrapper: Codable {
    let latitude: Double
    let longitude: Double
}

struct LocationWrapper: Codable {
    let address1: String?
    let address2: String?
    let address3: String?
    let city: String
    let zip_code: String
    let country: String
    let state: String
    let display_address: [String]
}


