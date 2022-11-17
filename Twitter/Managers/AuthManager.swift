//
//  AuthManager.swift
//  Twitter
//
//  Created by Mikhail Kostylev on 16.11.2022.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseAuthCombineSwift
import Combine

final class AuthManager {
    static let shared = AuthManager()
    
    public var isUserSignedIn: Bool {
        return Auth.auth().currentUser != nil
    }
    
    private init() {}
    
    // MARK: - Public
    
    func registerUser(with email: String, password: String) -> AnyPublisher<User, Error> {
        return Auth.auth().createUser(withEmail: email, password: password)
            .map(\.user)
            .eraseToAnyPublisher()
    }
    
    func loginUser(with email: String, password: String) -> AnyPublisher<User, Error> {
        return Auth.auth().signIn(withEmail: email, password: password)
            .map(\.user)
            .eraseToAnyPublisher()
    }
    
    func logOut(completion: @escaping (Bool) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(true)
        } catch {
            completion(false)
        }
    }
}
