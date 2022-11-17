//
//  AuthenticationViewModel.swift
//  Twitter
//
//  Created by Mikhail Kostylev on 17.11.2022.
//

import Foundation
import Firebase
import Combine

final class AuthenticationViewModel: ObservableObject {
    @Published var email: String?
    @Published var password: String?
    @Published var isAuthenticationFormValid: Bool = false
    @Published var user: User?
    @Published var error: String?
    
    private var subscriptions: Set<AnyCancellable> = []
    
    // MARK: - Public
    
    public func validateAuthenticationForm() {
        guard let email = email, let password = password else {
            isAuthenticationFormValid = false
            return
        }
        isAuthenticationFormValid = email.isValidEmail && password.count >= 8
    }
    
    public func registerUser() {
        guard let email = email, let password = password else { return }
        AuthManager.shared.registerUser(with: email, password: password)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.error = error.localizedDescription
                }
            } receiveValue: { [weak self] user in
                self?.user = user
            }
            .store(in: &subscriptions)
    }
    
    public func loginUser() {
        guard let email = email, let password = password else { return }
        AuthManager.shared.loginUser(with: email, password: password)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.error = error.localizedDescription
                } 
            } receiveValue: { [weak self] user in
                self?.user = user
            }
            .store(in: &subscriptions)
    }
}
