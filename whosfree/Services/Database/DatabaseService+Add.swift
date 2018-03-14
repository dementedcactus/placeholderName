//
//  DatabaseService+Add.swift
//  AC-iOS-Final
//
//  Created by Richard Crichlow on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseAuth

extension DatabaseService {
    
    /**
     Adds a comment to the current post.
     
     - Parameters:
     - text: The comment text.
     - postID: The ID of the current, selected post.
     */
    public func addComment(withText text: String, andEventID eventID: String) {
        guard let userID = AuthUserService.manager.getCurrentUser()?.uid else {
            print("Error: could not get current user id, please exit the app and log back in.")
            return
        }
        let ref = chatRef.child(eventID).childByAutoId()
        let comment = Comment(eventID: eventID, commentID: ref.key, userID: userID, text: text)
        
        ref.setValue(["eventID": eventID,
                      "commentID": comment.commentID,
                      "userID": comment.userID,
                      "text": comment.text,
                      "timestamp": comment.timestamp
        ]) { (error, _) in
            if let error = error {
                self.delegate?.didFailAddingComment?(self, error: error.localizedDescription)
            } else {
                self.delegate?.didAddComment?(self)
            }
        }
        
        print("new comment added to database!!")
    }
    
    /**
     Stores a UserProfile object in the database after account creation.
     
     - Parameter userProfile: The UserProfile object passed in.
     */
    public func addUserProfile(_ userProfile: UserProfile) {
        
        let ref = usersRef.child(userProfile.userID)
        
        ref.setValue(["email": userProfile.email,
                      "userID": userProfile.userID,
                      "address" : userProfile.address
            
        ]) { (error, _) in
            if let error = error {
                self.delegate?.didFailAddingUserProfile?(self, error: error.localizedDescription)
                print("\(userProfile) not added to firebase")
            } else {
                print("new user added to database!!")
            }
        }
    }
    
    /*
    public func addEvent(_ eventToSave: Event) {
        //1. find ref
        let ref = eventsRef.child(eventToSave.job_id)
        
        //2. call set value with completion handler
        ref.setValue(["additional_information": eventToSave.additional_information,
        "agency": eventToSave.agency,
        "business_title": eventToSave.business_title,
        "civil_service_title": eventToSave.civil_service_title,
        "division_work_unit": eventToSave.division_work_unit,
        "full_time_part_time_indicator": eventToSave.full_time_part_time_indicator,
        "hours_shift": eventToSave.hours_shift,
        "job_category": eventToSave.job_category,
        "job_description": eventToSave.job_description,
        "job_id": eventToSave.job_id,
        "minimum_qual_requirements": eventToSave.minimum_qual_requirements ?? "",
        "post_until": eventToSave.post_until ?? "",
        "posting_date": eventToSave.posting_date,
        "posting_type": eventToSave.posting_type,
        "posting_updated": eventToSave.posting_updated,
        "preferred_skills": eventToSave.preferred_skills,
        "process_date": eventToSave.process_date,
        "residency_requirement": eventToSave.residency_requirement ?? "",
        "salary_frequency": eventToSave.salary_frequency,
        "salary_range_from": eventToSave.salary_range_from,
        "salary_range_to": eventToSave.salary_range_to,
        "title_code_no": eventToSave.title_code_no,
        "to_apply": eventToSave.to_apply,
        "work_location": eventToSave.work_location,
        "work_location_1": eventToSave.work_location_1,
                      ]) { (error, nil) in
                        if let error = error {
                            print(error)
                        } else {
                            print("Event Saved")
                            self.refreshDelegate?.refreshTableView()
                            self.showAlertDelegate?.showAlertDelegate(nameOfWhatYoureSaving: "Event")
                        }
        }
    }
 */
 
}
