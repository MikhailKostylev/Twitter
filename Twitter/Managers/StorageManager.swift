//
//  StorageManager.swift
//  Twitter
//
//  Created by Mikhail Kostylev on 26.11.2022.
//

import Foundation
import Combine
import FirebaseStorage
import FirebaseStorageCombineSwift

final class StorageManager {
    static let shared = StorageManager()
    
    private let storage = Storage.storage()
    
    enum StorageError: Error {
        case invalidImageId
    }
    
    private init() {}
    
    // MARK: - Public
    
    public func uploadProfilePhoto(
        with id: String,
        image: Data,
        metaData: StorageMetadata
    ) -> AnyPublisher<StorageMetadata, Error> {
        return storage
            .reference()
            .child("images/\(id).jpg")
            .putData(image, metadata: metaData)
            .eraseToAnyPublisher()
    }
    
    public func getDownloadUrl(for id: String?) -> AnyPublisher<URL, Error> {
        guard let id = id else {
            return Fail(error: StorageError.invalidImageId)
                .eraseToAnyPublisher()
        }
        
        return storage
            .reference(withPath: id)
            .downloadURL()
            .eraseToAnyPublisher()
    }
}
