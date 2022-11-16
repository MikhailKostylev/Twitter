//
//  AuthManager.swift
//  Twitter
//
//  Created by Mikhail Kostylev on 16.11.2022.
//

import Foundation
import FirebaseAuth

final class AuthManager {
    static let shared = AuthManager()
    
    public var isUserSignedIn: Bool {
        return Auth.auth().currentUser != nil
    }
    
    private init() {}
}
