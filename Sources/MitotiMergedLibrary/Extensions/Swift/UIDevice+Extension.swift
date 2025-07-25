//
//  File.swift
//  
//
//  Created by Simone Pistecchia on 14/02/21.
//

import Foundation
import UIKit
import AVFoundation

extension UIDevice {
    static func vibrate() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
}

//https://www.hackingwithswift.com/example-code/uikit/how-to-generate-haptic-feedback-with-uifeedbackgenerator
//OPPURE PER FEEDBACK
/* vibrate vibrazione
UIImpactFeedbackGenerator
let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .light)
impactFeedbackgenerator.prepare()
impactFeedbackgenerator.impactOccurred()
UISelectionFeedbackGenerator
let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
selectionFeedbackGenerator.selectionChanged()
UINotificationFeedbackGenerator
let notificationFeedbackGenerator = UINotificationFeedbackGenerator()
notificationFeedbackGenerator.prepare()
notificationFeedbackGenerator.notificationOccurred(.success)
notificationFeedbackGenerator.notificationOccurred(.warning)
notificationFeedbackGenerator.notificationOccurred(.error)
 */
