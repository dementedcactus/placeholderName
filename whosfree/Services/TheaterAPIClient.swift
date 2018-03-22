//
//  TheaterAPIClient.swift
//  LuisWhosFreeViewControllers
//
//  Created by Luis Calle on 3/16/18.
//  Copyright © 2018 Lucho. All rights reserved.
//

import Foundation
import Alamofire

enum AppErrors: Error {
    case noData
    case couldNotParseJSON(rawError: Error)
    case badURL(str: String)
    case noResponse
}

struct TheaterAPIClient {
    
    let apiKey = "3s6en9dcrzwvfzgw3mnvbvmk"
    
    private init() { }
    static let manager = TheaterAPIClient()
    
    func getTheaters(with zipCode: String, and distanceInMiles: String, success: @escaping ([Theater]) -> Void, failure: @escaping (Error) -> Void) {
        let urlStr = "https://data.tmsapi.com/v1.1/theatres?zip=\(zipCode)&radius=\(distanceInMiles)&api_key=\(apiKey)"
        guard let url = URL(string: urlStr) else {
            failure(AppErrors.badURL(str: urlStr))
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        Alamofire.request(urlRequest).responseJSON { response in
            if response.value != nil {
                guard let data = response.data else {
                    failure(AppErrors.noData)
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let theaters = try decoder.decode([Theater].self, from: data)
                    success(theaters)
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

