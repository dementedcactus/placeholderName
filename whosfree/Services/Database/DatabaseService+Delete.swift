//
//  DatabaseService+Delete.swift
//  mansnothot
//
//  Created by C4Q on 2/6/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import Foundation
import FirebaseDatabase

extension DatabaseService {
    public func deleteEvent(withPostID postID: String) {
        eventsRef.child(postID).removeValue { (error, _) in
            if let error = error {
                self.delegate?.didFailDeletingPost?(self, error: error.localizedDescription)
            } else {
                self.delegate?.didDeletePost?(self, withPostID: postID)
            }
        }
    }
}
