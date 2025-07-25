//
//  TimeInterval+Extension.swift
//  WAR
//
//  Created by Simone Pistecchia on 24/03/2020.
//  Copyright © 2020 Simone Pistecchia. All rights reserved.
//

import Foundation
import UIKit
public extension TimeInterval {

    func stringFromTimeInterval() -> String {
        
        let time = NSInteger(self)

        //let ms = Int((self.truncatingRemainder(dividingBy: 1)) * 1000)
        let seconds = time % 60
        let minutes = (time / 60) % 60
        let hours = (time / 3600)

        //return String(format: "%0.2d:%0.2d:%0.2d.%0.3d",hours,minutes,seconds,ms)
        var formatString = ""
        if hours == 0 {
            if(minutes < 10) {
                formatString = "%2d:%0.2d"
            }else {
                formatString = "%0.2d:%0.2d"
            }
            return String(format: formatString,minutes,seconds)
        }else {
            formatString = "%2d:%0.2d:%0.2d"
            return String(format: formatString,hours,minutes,seconds)
        }
    }
}
