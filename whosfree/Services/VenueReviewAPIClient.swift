//
//  VenueReviewAPIClient.swift
//  LuisWhosFreeViewControllers
//
//  Created by Luis Calle on 3/17/18.
//  Copyright © 2018 Lucho. All rights reserved.
//

import Foundation
import Alamofire

struct VenueReviewAPIClient {
    
    let apiKey = "Ew-J-_X0F6h3sV1PtV1NklkETdOdxx2kOUr2t0nWUAT8YnKoqndMXMGU8rSZBznNj4khTsyKvVbvAvVW-Jvj0Yv-W69VvPvg2gmW3DyDwNt4JaszzqWnY5hHxwliWnYx"
    
    private init() { }
    static let manager = VenueReviewAPIClient()
    
    private let urlSession = URLSession(configuration: URLSessionConfiguration.default)
    
    func getVenueReviews(with id: String, success: @escaping ([Review]) -> Void, failure: @escaping (Error) -> Void) {
        let urlStr = "https://api.yelp.com/v3/businesses/\(id)/reviews"
        guard let url = URL(string: urlStr) else {
            failure(AppErrors.badURL(str: urlStr))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        Alamofire.request(urlRequest).responseJSON { response in
            
            if response.value != nil {
                guard let data = response.data else {
                    failure(AppErrors.noData)
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let yelpReviewsResponse = try decoder.decode(YelpReviewsResponse.self, from: data)
                    success(yelpReviewsResponse.reviews)
                } catch let error {
                    failure(AppErrors.couldNotParseJSON(rawError: error))
                    return
                }
            } else {
                failure(AppErrors.noResponse)
            }
        }
    }
    
}


