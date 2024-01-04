//
//  HapticManager.swift
//  Pyeon-Duck
//
//  Created by 준우의 MacBook 16 on 1/3/24.
//

import UIKit

class HapticManager {
    static let shared = HapticManager()

    // warning, error, success
    func hapticNotification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }

    // heavy, light, meduium, rigid, soft
    func hapticImpact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}
