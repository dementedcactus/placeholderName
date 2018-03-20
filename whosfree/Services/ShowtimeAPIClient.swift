
//
//  ShowtimeAPIClient.swift
//  LuisWhosFreeViewControllers
//
//  Created by Luis Calle on 3/17/18.
//  Copyright © 2018 Lucho. All rights reserved.
//

import Foundation
import Alamofire

struct ShowtimeAPIClient {
    
    let apiKey = "3s6en9dcrzwvfzgw3mnvbvmk"
    
    private init() { }
    static let manager = ShowtimeAPIClient()
    
    func getShowtimes(with cinemaID: String, and startDate: String, and numberOfDays: String, success: @escaping ([MovieShowtimes]) -> Void, failure: @escaping (Error) -> Void) {
        let urlStr = "https://data.tmsapi.com/v1.1/theatres/\(cinemaID)/showings?startDate=\(startDate)&numDays=\(numberOfDays)&imageSize=Md&imageText=true&api_key=\(apiKey)"
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
                    let moviewShowtimes = try decoder.decode([MovieShowtimes].self, from: data)
                    success(moviewShowtimes)
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

