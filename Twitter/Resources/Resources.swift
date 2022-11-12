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
    
    enum Image {
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
