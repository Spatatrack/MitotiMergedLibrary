//
//  UIColor+Extension.swift
//  WhatsAppMovieAct
//
//  Created by Simone Pistecchia on 03/12/17.
//  Copyright © 2017 Simone Pistecchia. All rights reserved.
//

import Foundation
import  UIKit

public extension UIColor {
    var coreImageColor: CIColor {
        return CIColor(color: self)
    }
    var components: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        let coreImageColor = self.coreImageColor
        return (coreImageColor.red, coreImageColor.green, coreImageColor.blue, coreImageColor.alpha)
    }
}
