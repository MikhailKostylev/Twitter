//
//  ProfileDataFormViewModel.swift
//  Twitter
//
//  Created by Mikhail Kostylev on 18.11.2022.
//

import UIKit
import Combine
import FirebaseStorage
import FirebaseStorageCombineSwift

final class ProfileDataFormViewModel: ObservableObject {
    
    @Published var displayName: String?
    @Published var username: String?
    @Published var bio: String?
    @Published var avatarPath: String?
    @Published var imageData: UIImage?
    @Published var url: URL?
    @Published var isFormValid: Bool = false
    @Published var error: String = ""
    
    private var subscriptions: Set<AnyCancellable> = []
    
    // MARK: - Public
    
    public func validateUserProfileForm() {
        guard
            let displayName = displayName,
            let username = username,
            let bio = bio,
            displayName.count > 2,
            username.count > 2,
            bio.count > 2,
            imageData != nil
        else {
            isFormValid = false
            return
        }
        
        isFormValid = true
    }
    
    public func uploadAvatar() {
        let id = UUID().uuidString
        guard let imageData = imageData?.jpegData(compressionQuality: 0.5) else { return }
        let metaData = StorageMetadata()
        metaData.contentType = "image.jpeg"
        
        StorageManager.shared.uploadProfilePhoto(with: id, image: imageData, metaData: metaData)
            .flatMap { metaData in
                StorageManager.shared.getDownloadUrl(for: metaData.path)
            }
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.error = error.localizedDescription
                }
            } receiveValue: { [weak self] url in
                self?.url = url
            }
            .store(in: &subscriptions)
    }
}
