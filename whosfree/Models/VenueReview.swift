//
//  VenueReview.swift
//  LuisWhosFreeViewControllers
//
//  Created by Luis Calle on 3/17/18.
//  Copyright © 2018 Lucho. All rights reserved.
//

import Foundation

struct YelpReviewsResponse: Codable {
    let reviews: [Review]
}

struct Review: Codable {
    let id: String
    let url: String
    let text: String
    let rating: Int
    let user: UserWrapper
    let time_created: String
}

struct UserWrapper: Codable {
    let image_url: String?
    let name: String
}

