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


public struct AppleStore {
    
    
    public static let appleStoreAppLink = "itms-apps://itunes.apple.com/app/id" + MitotiMLibraryNew.idApple //BVS ID "1195231964"
    
    static let URLotherAppMitotiM: URL? = URL(string: "itms-apps://itunes.apple.com/mitotim")//"http://itunes.com/apps/mitotim")
    
    public static func openiTunesLink() {
        
        let iTunesLink = AppleStore.appleStoreAppLink
        let url: URL = URL(string: iTunesLink)!
        if (UIApplication.shared.canOpenURL(url)) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    public static func openRateMe() {
        if #available(iOS 14, *) {
            if let scene = UIApplication.shared.currentScene {
                SKStoreReviewController.requestReview(in: scene)
            }
        }
        else if #available( iOS 10.3,*){ //richiesta diretta dall'app
            SKStoreReviewController.requestReview()
        }
        else {
            let reviewLink = "http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=" + MitotiMLibraryNew.idApple + "&pageNumber=0&sortOrdering=1&type=Purple+Software&mt=8"
            let url: URL = URL(string: reviewLink)!
            if (UIApplication.shared.canOpenURL(url)) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)                
            }
        }
    }
    
    public static func openOtherApp() {
        
        guard let url: URL = URLotherAppMitotiM else {return}
        if (UIApplication.shared.canOpenURL(url)) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    public static func goToAppSettings() {
        if let settings = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(settings) {
            UIApplication.shared.open(settings)
        }
    }
}

