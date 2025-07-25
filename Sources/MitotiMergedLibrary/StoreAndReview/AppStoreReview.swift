//
//  AppStoreReview.swift
//  Pippi
//
//  Created by Simone Pistecchia on 19/09/16.
//  Copyright © 2016 Simone Pistecchia. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit


/**Se il numero di chiamate supera un tot preimpostato, chiede la recensione
    SETTARE AppConfiguration.AppleStore.numWinToOpenReview
    E CHIAMARE OGNI VOLTA CHE SI VUOLE FARE IL CHECK
    //NORMAL
        Task {
            await AppStoreReview.checkStore(senderView: self)
        }
    //SPRITEKIT
        Task {
            await AppStoreReview.checkStore(senderSKView: self.view!)
        }
    //SWIFTUI
        if let viewController = UIApplication.shared.windows.first?.rootViewController {
            Task {
                await AppStoreReview.checkStore(senderView: viewController)
            }
        }
 
 Button(action: { Task { await AppleStore.openRateMe() } }) {
     HStack {
         Text(AppStoreReview.titleRateUs)
         Spacer()
         Text(AppStoreReview.titleRateUs)
             .foregroundColor(.gray)
             .font(.caption)
         Image(systemName: "chevron.right")
     }
     
 }
 */

/// diretto AppleStore.openRateMe()
/// in base a aperture AppStoreReview.checkStoreToReview()
/**
 ///Button(action: { Task { await AppleStore.openRateMe() } }) {
 HStack {
     Text(AppStoreReview.titleRateUs)
     Spacer()
     Text(AppStoreReview.titleRateUs)
         .foregroundColor(.gray)
         .font(.caption)
     Image(systemName: "chevron.right")
 }
 
}
 */
public class AppStoreReview {
    
    public static let titleRateUs = NSLocalizedString("Rate us!", tableName: "MTMLocalizable", bundle: .module, comment: "")
    public static let messageRateUs = NSLocalizedString("please, support my work", tableName: "MTMLocalizable", bundle: .module, comment: "")
    
    //Quante volte ha vinto
    public static var numOpen : Int {
        get {
            let returnValue: Int? = UserDefaults.standard.integer(forKey: "numPerReview")
            return returnValue ?? 0
        }
        set (newValue) {
            UserDefaults.standard.set(newValue, forKey: "numPerReview")
            UserDefaults.standard.synchronize()
        }
    }
    
    //Ritorna si se è gia stata fatta la recensione
    public static func isAlreadyReviewed() -> Bool{
        let RATED: String = Bundle.main.object(forInfoDictionaryKey:kCFBundleVersionKey as String) as! String
        
        let ratedValue: String = UserDefaults.standard.object(forKey: RATED) as? String ?? "no"
        
        if ( ratedValue == "no" ) {
            return false
        }
        else {
            return true
        }
    }
    
    ///Apri apple store review e Setta nsuserdefaul come già reviewed
    @MainActor public static func openAppStoreReview() async {
        let RATED: String = Bundle.main.object(forInfoDictionaryKey:kCFBundleVersionKey as String) as! String
        UserDefaults.standard.set("yes", forKey: RATED)
        UserDefaults.standard.synchronize()
        await AppleStore.openRateMe()
    }
    
    ///Setta nsuserdefault come non reviewed
    public static func setAsNoReviewed () {
        let RATED: String = Bundle.main.object(forInfoDictionaryKey:kCFBundleVersionKey as String) as! String
        UserDefaults.standard.set("no", forKey: RATED)
        UserDefaults.standard.synchronize()
    }
    
    /// Check If number is greater than setting, if yes show alert to rate
    /// This function is async and must be called from the main actor.
    @MainActor public static func checkStoreToReview() async {
        
        AppStoreReview.numOpen += 1
        
        let numOpen: Int = AppStoreReview.numOpen // Numero di aperture dell'app
        
        // Ottiene il numero di aperture necessarie per la prima richiesta di recensione
        let numOpenToOpenReview = MitotiMLibraryNew.numToOpenReview
        
        // Ottiene la ricorrenza di aperture per le richieste successive
        let recurrenceOpenReview = MitotiMLibraryNew.recurrenceOpenReview
        
        // Controlla se è il momento di mostrare la richiesta di recensione
        if (numOpen == numOpenToOpenReview) || (numOpen >= numOpenToOpenReview && (numOpen - numOpenToOpenReview) % recurrenceOpenReview == 0) {
            await AppStoreReview.openAppStoreReview()
        }
    }
    
    /// Check If number is greater than setting, if yes show alert to rate
    /// This function is async and must be called from the main actor.
    @MainActor public static func checkStore(senderView: UIViewController) async {
        
        AppStoreReview.numOpen += 1
        
        let numOpen: Int = AppStoreReview.numOpen //numero di aperture per far comparire il rate
        
        let isRated = isAlreadyReviewed()
        
        if isRated == false {
            
            let numOpenToOpenReview = MitotiMLibraryNew.numToOpenReview

            if numOpen >= numOpenToOpenReview {
                
                // create the alert
                let alert = UIAlertController(title: titleRateUs,
                                              message: messageRateUs,
                                              preferredStyle: UIAlertController.Style.alert)
                
                // add the actions (buttons)
                alert.addAction(UIAlertAction(title: NSLocalizedString("Rate Now", tableName: "MTMLocalizable", bundle: .module, comment: ""), style: UIAlertAction.Style.default, handler: {(alertAction) -> Void in
                        Task {
                            await AppStoreReview.openAppStoreReview()
                        }
                }))
                
                alert.addAction(UIAlertAction(title: NSLocalizedString("RATE_REMEMBER_BUTTON", tableName: "MTMLocalizable", bundle: .module, comment: ""), style: UIAlertAction.Style.default, handler: {(alertAction) -> Void in
                    self.numOpen = 0
                }))
                
                // show the alert
                await senderView.presentAsync(alert, animated: true)
            }
        }
    }
    
    /// Async version of checkStore for SKView
    @MainActor public static func checkStore(senderSKView: SKView) async {
        if let rootVC = senderSKView.window?.rootViewController {
            await checkStore(senderView: rootVC)
        }
    }
    
}

// Helper extension to present UIAlertController asynchronously
@MainActor
extension UIViewController {
    func presentAsync(_ viewControllerToPresent: UIViewController, animated flag: Bool) async {
        await withCheckedContinuation { continuation in
            self.present(viewControllerToPresent, animated: flag) {
                continuation.resume()
            }
        }
    }
}
