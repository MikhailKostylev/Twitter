//
//  DatabaseManager.swift
//  Twitter
//
//  Created by Mikhail Kostylev on 18.11.2022.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreCombineSwift
import Combine

final class DatabaseManager {
    static let shared = DatabaseManager()
    
    private let db = Firestore.firestore()
    private let usersPath = "users"
    private let tweetsPath = "tweets"
    
    private init() {}
    
    // MARK: -  Public
    
    public func collectionUsers(add user: User) -> AnyPublisher<Bool, Error> {
        let twitterUser = TwitterUser(from: user)
        return db.collection(usersPath).document(twitterUser.id).setData(from: twitterUser)
            .map { return true }
            .eraseToAnyPublisher()
    }
    
    public func collectionUsers(retrieve id: String) -> AnyPublisher<TwitterUser, Error> {
        db.collection(usersPath).document(id).getDocument()
            .tryMap { try $0.data(as: TwitterUser.self) }
            .eraseToAnyPublisher()
    }
    
    public func collectionUsers(updateFields: [String: Any], for id: String) -> AnyPublisher<Bool, Error> {
        db.collection(usersPath).document(id).updateData(updateFields)
            .map { true }
            .eraseToAnyPublisher()
    }
    
    public func collectionTweets(dispatch tweet: Tweet) ->  AnyPublisher<Bool, Error> {
        db.collection(tweetsPath).document(tweet.id).setData(from: tweet)
            .map { true }
            .eraseToAnyPublisher()
    }
    
    public func collectionTweets(retrieveTweetsFor userID: String) -> AnyPublisher<[Tweet], Error> {
        db.collection(tweetsPath).whereField("authorID", isEqualTo: userID)
            .getDocuments()
            .tryMap(\.documents)
            .tryMap { snapshots in
                try snapshots.map {
                    try $0.data(as: Tweet.self)
                }
            }
            .eraseToAnyPublisher()
    }
}
