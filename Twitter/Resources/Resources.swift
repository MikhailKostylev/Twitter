//
//  Resources.swift
//  Twitter
//
//  Created by Mikhail Kostylev on 12.11.2022.
//

import UIKit

typealias R = Resources

enum Resources {
    enum Text {
        enum Profile {
            static let edit = "Edit"
            static let following = "Following"
            static let followers = "Followers"
            static let tab1 = "Tweets"
            static let tab2 = "Tweet & Replies"
            static let tab3 = "Media"
            static let tab4 = "Likes"
        }
    }
    
    enum Color {
        static let twitterBlue = UIColor(named: "twitterBlue")
    }
    
    enum Font {
        enum ProfileHeader {
            static let displayName = UIFont.systemFont(ofSize: 22, weight: .bold)
            static let username = UIFont.systemFont(ofSize: 18, weight: .regular)
            static let edit = UIFont.systemFont(ofSize: 14, weight: .bold)
            static let userBio = UIFont.systemFont(ofSize: 16, weight: .medium)
            static let location = UIFont.systemFont(ofSize: 14, weight: .regular)
            static let joinDate = UIFont.systemFont(ofSize: 14, weight: .regular)
            static let followingCount = UIFont.systemFont(ofSize: 14, weight: .bold)
            static let followingText = UIFont.systemFont(ofSize: 14, weight: .regular)
            static let followersCount = UIFont.systemFont(ofSize: 14, weight: .bold)
            static let followersText = UIFont.systemFont(ofSize: 14, weight: .regular)
            static let tabs = UIFont.systemFont(ofSize: 16, weight: .semibold)
        }
        
        enum TweetCell {
            static let displayName = UIFont.systemFont(ofSize: 18, weight: .bold)
            static let username = UIFont.systemFont(ofSize: 16, weight: .regular)
        }
    }
    
    enum Image {
        enum Profile {
            static let calendar = UIImage(named: "calendar")
            static let location = UIImage(named: "location")
        }
        
        enum Home {
            static let tweetCellAvatar = UIImage(systemName: "person.circle")
            static let tweetCellReply = UIImage(named: "replyIcon")
            static let tweetCellRetweet = UIImage(named: "retweetIcon")
            static let tweetCellLike = UIImage(named: "likeIcon")
            static let tweetCellShare = UIImage(named: "shareIcon")
            
            static let twitterLogoSmall = UIImage(named: "twitterLogoSmall")
            static let twitterLogoBig = UIImage(named: "twitterLogoBig")
            static let twitterLogoMedium = UIImage(named: "twitterLogoMedium")
        }
        
        enum TabBar {
            static let homeIcon = UIImage(named: "homeIcon")
            static let searchIcon = UIImage(named: "searchIcon")
            static let communitiesIcon = UIImage(named: "communitiesIcon")
            static let notificationsIcon = UIImage(named: "notificationsIcon")
            static let directMessagesIcon = UIImage(named: "directMessagesIcon")
            
            static let homeIconFill = UIImage(named: "homeIconFill")
            static let searchIconFill = UIImage(systemName: "text.magnifyingglass")
            static let communitiesIconFill = UIImage(named: "communitiesIconFill")
            static let notificationsIconFill = UIImage(named: "notificationsIconFill")
            static let directMessagesIconFill = UIImage(named: "directMessagesIconFill")
        }
    }
}

