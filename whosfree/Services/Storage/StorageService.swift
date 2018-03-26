//
//  StorageService.swift
//  AC-iOS-Final
//
//  Created by Richard Crichlow on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation
import FirebaseStorage

protocol StorageServiceDelegate: class {
    /**
     This method is called when the image is successfully stored in Firebase Storage.
     
     - Parameters:
     - storageService: The Firebase/Storage API client.
     */
    func didStoreImage(_ storageService: StorageService)
    /**
     This method returns when the Firebase/Storage API client fails to store the given image.
     
     - Parameters:
     - storageService: The Firebase/Storage API client.
     - error: The error message received when the the Firebase/Storage API client fails to store the given image.
     */
    func didFailStoreImage(_ storageService: StorageService, error: String)
}

/** This API client is responsible for storing objects in the Firebase Cloud Storage.
 */

class StorageService {
    
    let firebaseAuthService = FirebaseAuthService()
    
    private init(){
        storage = Storage.storage()
        storageRef = storage.reference()
        usersImagesRef = storageRef.child("usersImages")
        eventsImagesRef = storageRef.child("eventsImages")
    }
    static let manager = StorageService()
    
    private var storage: Storage!
    private var storageRef: StorageReference!
    private var usersImagesRef: StorageReference!
    private var eventsImagesRef: StorageReference!
    
    public func getStorageRef() -> StorageReference { return storageRef }
    public func getUserImagesRef() -> StorageReference { return usersImagesRef }
    public func getEventsImagesRef() -> StorageReference { return eventsImagesRef }
}
