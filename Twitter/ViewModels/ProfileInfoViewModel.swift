//
//  ProfileInfoViewModel.swift
//  Twitter
//
//  Created by Mikhail Kostylev on 18.11.2022.
//

import Foundation
import Combine

final class ProfileInfoViewModel: ObservableObject {
    
    @Published var displayName: String?
    @Published var username: String?
    @Published var bio: String?
    @Published var avatarPath: String?
    @Published var location: String = ""
        
    private var subscriptions: Set<AnyCancellable> = []
    
    // MARK: - Public
    
    public func abc() {
        
    }
}
