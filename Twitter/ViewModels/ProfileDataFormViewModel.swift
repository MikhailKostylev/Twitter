//
//  ProfileDataFormViewModel.swift
//  Twitter
//
//  Created by Mikhail Kostylev on 18.11.2022.
//

import UIKit
import Combine
import FirebaseAuth
import FirebaseStorage
import FirebaseStorageCombineSwift

final class ProfileDataFormViewModel: ObservableObject {
    
    @Published var displayName: String?
    @Published var username: String?
    @Published var location: String?
    @Published var bio: String?
    @Published var avatarPath: String?
    @Published var imageData: UIImage?
    @Published var isFormValid: Bool = false
    @Published var error: String = ""
    @Published var isOnboardingFinished: Bool = false
    
    private var subscriptions: Set<AnyCancellable> = []
    
    // MARK: - Public
    
    public func validateUserProfileForm() {
        guard
            let displayName = displayName,
            let username = username,
            let location = location,
            let bio = bio,
            displayName.count > 2,
            username.count > 2,
            location.count >= 2,
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
                switch completion {
                case .finished:
                    self?.updateUserData()
                case .failure(let error):
                    self?.error = error.localizedDescription
                }
            } receiveValue: { [weak self] url in
                self?.avatarPath = url.absoluteString
            }
            .store(in: &subscriptions)
    }
    
    // MARK: - Private
    
    private func updateUserData() {
        guard
            let displayName,
            let username,
            let location,
            let bio,
            let avatarPath,
            let id = Auth.auth().currentUser?.uid
        else { return }
        
        let updatedFields: [String: Any] = [
            "displayName": displayName,
            "username": username,
            "location": location,
            "bio": bio,
            "avatarPath": avatarPath,
            "isUserOnboarded": true
        ]
        
        DatabaseManager.shared.collectionUsers(updateFields: updatedFields, for: id)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.error = error.localizedDescription
                }
            } receiveValue: { [weak self] onboardingState in
                self?.isOnboardingFinished = onboardingState
            }
            .store(in: &subscriptions)
    }
}
