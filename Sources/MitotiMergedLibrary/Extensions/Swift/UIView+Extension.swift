//
//  UIView+Extension.swift
//  WhatsAppMovieAct
//
//  Created by Simone Pistecchia on 28/10/17.
//  Copyright © 2017 Simone Pistecchia. All rights reserved.
//

import Foundation
import UIKit

///Tipo spritekit
/** ESEMPIO self.statusLabel.alpha = 0
     self.statusLabel.text = "Sample Text Here"
     self.myLabel.fadeIn(completion: {(finished: Bool) -> Void in
         self.myLabel.fadeOut()
     })
*/
public extension UIView {
    
    func fadeIn(duration: TimeInterval = 1.0, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseIn, animations: {
            self.alpha = 1.0
        }, completion: completion)  }
    
    func fadeOut(duration: TimeInterval = 1.0, delay: TimeInterval = 0.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseIn, animations: {
            self.alpha = 0.0
        }, completion: completion)
    }
    ///UIView che va verso l'alto
    func pushUp(deltaY: CGFloat = 20, duration: TimeInterval = 1.0, delay: TimeInterval = 0.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseIn, animations: {
            self.center.y -= deltaY
        }, completion: completion)
    }
    
    func moveTo(newCenter: CGPoint, duration: TimeInterval = 1.0, delay: TimeInterval = 0.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseIn, animations: {
            self.center = newCenter
        }, completion: completion)
    }
    
    func addSubviewToCenter (view: UIView) {
        self.addConstraint(NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0))
        addSubview(view)
    }
    
   
    ///Compare aspetta e scompare
    //func fadeInWaitFadeOut()
}

//per disabilitare keyboard se tocco fuori la kayboard
//public extension UIView {
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesBegan(touches, with: event)
//        UIApplication.shared.windows
//            .first { $0.isKeyWindow }?
//            .endEditing(true)
//    }
//}
