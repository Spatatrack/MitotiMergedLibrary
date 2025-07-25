//
//  UIImageView+extension.swift
//  WhatsAppMovieAct
//
//  Created by Simone Pistecchia on 03/11/17.
//  Copyright © 2017 Simone Pistecchia. All rights reserved.
//

import Foundation
import UIKit

@available(iOS 10.0, *)
public extension UIImage {
    ///cosi load e salva con rotazione
    func png(isOpaque: Bool = true) -> Data? { flattened(isOpaque: isOpaque).pngData() }
    func flattened(isOpaque: Bool = true) -> UIImage {
        if imageOrientation == .up { return self }
        let format = imageRendererFormat
        format.opaque = isOpaque
        return UIGraphicsImageRenderer(size: size, format: format).image { _ in draw(at: .zero) }
    }
}
@available(iOS 10.0, *)
public extension UIImage {
    func resized(withPercentage percentage: CGFloat, isOpaque: Bool = true) -> UIImage? {
        let canvas = CGSize(width: size.width * percentage, height: size.height * percentage)
        let format = imageRendererFormat
        format.opaque = isOpaque
        return UIGraphicsImageRenderer(size: canvas, format: format).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }
    func resized(toWidth width: CGFloat, isOpaque: Bool = true) -> UIImage? {
        let canvas = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        let format = imageRendererFormat
        format.opaque = isOpaque
        return UIGraphicsImageRenderer(size: canvas, format: format).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }
}
public extension UIImageView{
    
    ///Fade out image and fade in new one
    func fadeTransition(toImage: UIImage, withDuration duration: TimeInterval){
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0.1
        }) { (bool) in
            UIView.animate(withDuration: duration, animations: {
                self.image = toImage
                self.alpha = 1
            }, completion: nil)
        }
    }
    
    ///Transition with cross transition
    func crossTransition(toImage: UIImage, withDuration duration: TimeInterval){
        UIView.transition(with: self,
                          duration: duration,
                          options: .transitionCrossDissolve,
                          animations: {
                            self.image = toImage
        }, completion: nil)
    }
    
    ///Fade out image and fade in new one
    func kenBurnsAnimation(withDuration duration: TimeInterval){
        UIView.animate(withDuration: duration, animations: {
            let pos1 = CGFloat(arc4random_uniform(2) < 1 ? 1 : -1)
            let pos2 = CGFloat(arc4random_uniform(2) < 1 ? 1 : -1)
            var t = CGAffineTransform.identity
            t = t.translatedBy(x: 6 * pos1, y: 6 * pos2)
            t = t.rotated(by: 0.01)
            t = t.scaledBy(x: 1.1, y: 1.1)
            // ... add as many as you want, then apply it to to the view
            self.transform = t
        }) { (bool) in
            
        }
    }
    
}
