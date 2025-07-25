//
//  SwiftUIView.swift
//  
//
//  Created by Simone Pistecchia on 31/12/20.
//

import SwiftUI

///per trovare la scena in ios14
@available(iOS 13.0, *)
public extension UIApplication {
    var currentScene: UIWindowScene? {
        connectedScenes
            .first { $0.activationState == .foregroundActive } as? UIWindowScene
    }
}
