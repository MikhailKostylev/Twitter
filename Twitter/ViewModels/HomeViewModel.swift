//
//  HomeViewModel.swift
//  Twitter
//
//  Created by Mikhail Kostylev on 18.11.2022.
//

import Foundation
import Combine
import FirebaseAuth

final class HomeViewModel: ObservableObject {
    
    @Published var user: TwitterUser?
    @Published var error: String?
    @Published var tweets: [Tweet] = []
    
    private var subscriptions: Set<AnyCancellable> = []
    
    // MARK: - Public
    
    public func retrieveUser() {
        guard let id = Auth.auth().currentUser?.uid else { return }
        DatabaseManager.shared.collectionUsers(retrieve: id)
            .handleEvents(receiveOutput: { [weak self] user in
                self?.user = user
                self?.fetchTweets()
            })
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.error = error.localizedDescription
                }
            } receiveValue: { [weak self] user in
                self?.user = user
            }
            .store(in: &subscriptions)
    }
    
    func fetchTweets() {
        guard let userID = user?.id else { return }
        DatabaseManager.shared.collectionTweets(retrieveTweetsFor: userID)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.error = error.localizedDescription
                }
            } receiveValue: { [weak self] tweets in
                self?.tweets = tweets
            }
            .store(in: &subscriptions)
    }
}
