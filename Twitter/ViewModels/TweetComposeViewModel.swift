//
//  TweetComposeViewModel.swift
//  Twitter
//
//  Created by Mikhail Kostylev on 06.01.2023.
//

import Foundation
import Combine
import FirebaseAuth

final class TweetComposeViewModel: ObservableObject {
    
    @Published var isValidToTweet: Bool = false
    @Published var error: String = ""
    
    var tweetContent: String = ""
    private var subscriptions: Set<AnyCancellable> = []
    private var user: TwitterUser?
    
    func getUserData() {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        DatabaseManager.shared.collectionUsers(retrieve: userID)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.error = error.localizedDescription
                }
            } receiveValue: { [weak self] twitterUser in
                self?.user = twitterUser
            }
            .store(in: &subscriptions)
    }
    
    func validateToTweet() {
        isValidToTweet = !tweetContent.isEmpty
    }
}
