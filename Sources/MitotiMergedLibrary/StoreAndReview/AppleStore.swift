//
//  AppleStore.swift
//  Bat vs Spiders
//
//  Created by Simone Pistecchia on 17/01/17.
//  Copyright © 2017 Simone Pistecchia. All rights reserved.
//

import Foundation
import UIKit
import StoreKit

@MainActor
public struct AppleStore {
    
    public static let appleStoreAppLink = "itms-apps://itunes.apple.com/app/id" + MitotiMLibraryNew.idApple //BVS ID "1195231964"
    
    static let URLotherAppMitotiM: URL? = URL(string: "itms-apps://itunes.apple.com/mitotim")//"http://itunes.com/apps/mitotim")
    
    /// Opens the App Store page for the app asynchronously.
    public static func openiTunesLink() async {
        let iTunesLink = AppleStore.appleStoreAppLink
        let url: URL = URL(string: iTunesLink)!
        if UIApplication.shared.canOpenURL(url) {
            await UIApplication.shared.open(url)
        }
    }
    
    /// Requests an App Store review asynchronously.
    public static func openRateMe() async {
        SKStoreReviewController.requestReview()
    }
    
    /// Opens the other MitotiM app asynchronously.
    public static func openOtherApp() async {
        guard let url: URL = URLotherAppMitotiM else { return }
        if UIApplication.shared.canOpenURL(url) {
            await UIApplication.shared.open(url)
        }
    }
    
    /// Opens the app's settings asynchronously.
    public static func goToAppSettings() async {
        if let settings = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(settings) {
            await UIApplication.shared.open(settings)
        }
    }
}
