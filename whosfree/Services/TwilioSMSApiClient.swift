//
//  TwilioSMSApiClient.swift
//  whosfree
//
//  Created by Luis Calle on 4/2/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import Foundation
import Alamofire

struct TwilioSMSApiClient {
    
    let url = "https://api.twilio.com/2010-04-01/Accounts/ACfcb28e3efc189f9b0eeb100b7c117bbe/Messages"
    let accountSID = "ACfcb28e3efc189f9b0eeb100b7c117bb"
    let authToken = "52679b0d629761358f53fe9adc42d97f"
    
    private init() { }
    static let manager = TwilioSMSApiClient()
    
    func sendSMS(to contactsPhoneNumbers: [String], eventID: String) {
        
        for phone in contactsPhoneNumbers {
            let parameters: Parameters = [
                "From": "9143807941",
                "To": "\(phone)",
                "Body": "Test"
            ]
            
            Alamofire.request(url, method: .post, parameters: parameters)
                .authenticate(user: accountSID, password: authToken)
                .responseString { response in
                    print(response)
            }
        }

    }  
    
}
