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
        
    }
    
    enum Color {
        
    }
    
    enum Font {
        static let displayName = UIFont.systemFont(ofSize: 18, weight: .bold)
        static let username = UIFont.systemFont(ofSize: 16, weight: .regular)
    }
    
    enum Image {
        enum Home {
            static let tweetCellAvatar = UIImage(systemName: "person.fill")
        }
        
        enum TabBar {
            static let homeIcon = UIImage(systemName: "house")
            static let searchIcon = UIImage(systemName: "magnifyingglass")
            static let notificationsIcon = UIImage(systemName: "bell")
            static let directMessagesIcon = UIImage(systemName: "envelope")
            
            static let homeIconFill = UIImage(systemName: "house.fill")
            static let searchIconFill = UIImage(systemName: "text.magnifyingglass")
            static let notificationsIconFill = UIImage(systemName: "bell.fill")
            static let directMessagesIconFill = UIImage(systemName: "envelope.fill")
        }
    }
}
