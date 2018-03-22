//
//  Showtime.swift
//  LuisWhosFreeViewControllers
//
//  Created by Luis Calle on 3/17/18.
//  Copyright © 2018 Lucho. All rights reserved.
//

import Foundation

struct MovieShowtimes: Codable {
    let tmsId: String
    let rootId: String
    let subType: String
    let title: String
    let releaseYear: Int?
    let releaseDate: String
    let titleLang: String
    let descriptionLang: String
    let entityType: String
    let genres: [String]
    let longDescription: String
    let shortDescription: String
    let topCast: [String]
    let directors: [String]
    let officialUrl: String?
    let qualityRating: QualityRatingWrapper?
    let ratings: [RatingsWrapper]
    let advisories: [String]?
    let runTime: String
    let preferredImage: PreferredImageWrapper
    let showtimes: [Showtime]
}

struct QualityRatingWrapper: Codable {
    let ratingsBody: String
    let value: String
}

struct RatingsWrapper: Codable {
    let body: String
    let code: String
}

struct PreferredImageWrapper: Codable {
    let width: String
    let height: String
    let caption: CaptionWrapper?
    let uri: String
    let category: String
    let text: String
    let primary: String?
}

struct CaptionWrapper: Codable {
    let content: String
    let lang: String
}

struct Showtime: Codable {
    let theatre: TheatreWrapper
    let dateTime: String
    let quals: String?
    let barg: Bool
    let ticketURI: String?
}

struct TheatreWrapper: Codable {
    let id: String
    let name: String
}

