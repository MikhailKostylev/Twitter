//
//  RegisterViewModel.swift
//  Twitter
//
//  Created by Mikhail Kostylev on 17.11.2022.
//

import Foundation
import Firebase
import Combine

final class RegisterViewModel: ObservableObject {
    @Published var email: String?
    @Published var password: String?
    @Published var isRegistrationFormValid: Bool = false
    @Published var user: User?
    
    private var subscriptions: Set<AnyCancellable> = []
    
    // MARK: - Public
    
    func validateRegistrationForm() {
        guard let email = email, let password = password else {
            isRegistrationFormValid = false
            return
        }
        isRegistrationFormValid = email.isValidEmail && password.count >= 8
    }
    
    func createUser() {
        guard let email = email, let password = password else { return }
        AuthManager.shared.registerUser(with: email, password: password)
            .sink { _ in } receiveValue: { [weak self] user in
                self?.user = user
            }
            .store(in: &subscriptions)
    }
}
