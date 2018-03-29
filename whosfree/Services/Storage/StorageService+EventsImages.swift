//
//  StorageService+EventsImages.swift
//  whosfree
//
//  Created by Luis Calle on 3/20/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import Foundation
//import Toucan
import UIKit
import FirebaseStorage

extension StorageService {
    public func storeEventImage(image: UIImage, eventID: String) {
        
//        guard let resizedImage = Toucan(image: image).resize(CGSize(width: 800, height: 800)).image, let imageData = UIImagePNGRepresentation(resizedImage) else {
//            return nil
//        }
        
        guard let data = UIImageJPEGRepresentation(image, 1.0) else { print("image is nil"); return }
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        let uploadTask = StorageService.manager.getEventsImagesRef().child(eventID).putData(data, metadata: metadata) { (storageMetadata, error) in
            if let error = error {
                print("uploadTask error: \(error)")
            } else if let storageMetadata = storageMetadata {
                print("storageMetadata: \(storageMetadata)")
            }
        }
        
        // Listen for state changes, errors, and completion of the upload.
        uploadTask.observe(.resume) { snapshot in
            // Upload resumed, also fires when the upload starts
        }
        
        uploadTask.observe(.pause) { snapshot in
            // Upload paused
        }
        
        uploadTask.observe(.progress) { snapshot in
            // Upload reported progress
            let percentProgress = 100.0 * Double(snapshot.progress!.completedUnitCount)
                / Double(snapshot.progress!.totalUnitCount)
            print(percentProgress)
        }
        
        uploadTask.observe(.success) { snapshot in
            // Upload completed successfully
            
            // set event's imageURL
            let imageURL = String(describing: snapshot.metadata!.downloadURL()!)
            DatabaseService.manager.getEvents().child("\(eventID)/eventBannerImgUrl").setValue(imageURL)
        }
        
        uploadTask.observe(.failure) { snapshot in
            if let error = snapshot.error as NSError? {
                switch (StorageErrorCode(rawValue: error.code)!) {
                case .objectNotFound:
                    // File doesn't exist
                    break
                case .unauthorized:
                    // User doesn't have permission to access file
                    break
                case .cancelled:
                    // User canceled the upload
                    break
                    
                    /* ... */
                    
                case .unknown:
                    // Unknown error occurred, inspect the server response
                    break
                default:
                    // A separate error occurred. This is a good place to retry the upload.
                    break
                }
            }
        }
    }
    
    
    
}

