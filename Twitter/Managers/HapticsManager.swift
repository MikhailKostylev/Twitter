//
//  HapticsManager.swift
//  Twitter
//
//  Created by Mikhail Kostylev on 17.11.2022.
//

import UIKit

final class HapticsManager {
    static let shared = HapticsManager()

    private init() {}

    // MARK: - Public
    
    public func vibrateForSelection() {
        DispatchQueue.main.async {
            let generator = UISelectionFeedbackGenerator()
            generator.prepare()
            generator.selectionChanged()
        }
    }

    public func vibrate(for type: UINotificationFeedbackGenerator.FeedbackType) {
        DispatchQueue.main.async {
            let generator = UINotificationFeedbackGenerator()
            generator.prepare()
            generator.notificationOccurred(type)
        }
    }
}
