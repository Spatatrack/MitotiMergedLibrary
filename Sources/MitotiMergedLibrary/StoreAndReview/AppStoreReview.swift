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
        AppStoreReview.checkStore(senderView: self)
    //SPRITEKIT
        AppStoreReview.checkStore(sender: self.view!)
    //SWIFTUI
        if let viewController = UIApplication.shared.windows.first?.rootViewController {
            AppStoreReview.checkStore(senderView: viewController)
        }
 
 Button(action: {AppleStore.openRateMe()}) {
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
 ///Button(action: {AppleStore.openRateMe()}) {
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
    
    ///Apri apple store review e Setta nsuserdefaul come già reviewed/
    public static func openAppStoreReview () {
        let RATED: String = Bundle.main.object(forInfoDictionaryKey:kCFBundleVersionKey as String) as! String
        UserDefaults.standard.set("yes", forKey: RATED)
        UserDefaults.standard.synchronize()
        AppleStore.openRateMe()
    }
    
    ///Setta nsuserdefault come non reviewed
    public static func setAsNoReviewed () {
        let RATED: String = Bundle.main.object(forInfoDictionaryKey:kCFBundleVersionKey as String) as! String
        UserDefaults.standard.set("no", forKey: RATED)
        UserDefaults.standard.synchronize()
    }
    
    //iOS>10
    ///Check If number is grater then setting, if yes show alert to rate
    public static func checkStoreToReview() {
        
        AppStoreReview.numOpen += 1
        
        let numOpen: Int = AppStoreReview.numOpen // Numero di aperture dell'app
        
        // Ottiene il numero di aperture necessarie per la prima richiesta di recensione
        let numOpenToOpenReview = MitotiMLibraryNew.numToOpenReview
        
        // Ottiene la ricorrenza di aperture per le richieste successive
        let recurrenceOpenReview = MitotiMLibraryNew.recurrenceOpenReview
        
        // Controlla se è il momento di mostrare la richiesta di recensione
        if (numOpen == numOpenToOpenReview) || (numOpen >= numOpenToOpenReview && (numOpen - numOpenToOpenReview) % recurrenceOpenReview == 0) {
            AppStoreReview.openAppStoreReview()
        }
    }
    //iOS<10
    ///Check If number is grater then setting, if yes show alert to rate
    @objc static func checkStore(senderView: UIViewController) {
        
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
                        //print("Vota adesso")
                        AppStoreReview.openAppStoreReview()
                }))
                /*
                alert.addAction(UIAlertAction(title: NSLocalizedString("No, thanks",   comment:""), style: UIAlertAction.Style.default, handler: {(alertAction) -> Void in
                    UserDefaults.standard.set("yes", forKey: RATED)
                    UserDefaults.standard.synchronize()}))
                */
                alert.addAction(UIAlertAction(title: NSLocalizedString("RATE_REMEMBER_BUTTON", tableName: "MTMLocalizable", bundle: .module, comment: ""), style: UIAlertAction.Style.default, handler: {(alertAction) -> Void in
                    self.numOpen = 0
                }))
                
                // show the alert
                senderView.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    ///Check If number is grater then setting, if ies show alert to rate
    public static func checkStore(senderSKView: SKView) {
        AppStoreReview.checkStore(senderView: senderSKView.window!.rootViewController!)
    }
    
}


