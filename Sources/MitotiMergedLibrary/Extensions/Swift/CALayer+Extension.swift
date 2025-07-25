//
//  CALayer+Extension.swift
//  WhatsAppMovieAct
//
//  Created by Simone Pistecchia on 07/04/18.
//  Copyright © 2018 Simone Pistecchia. All rights reserved.
//

import Foundation
import UIKit

public extension CALayer {
    
    func pauseAnimationLayer() {
        let pausedTime: CFTimeInterval = self.convertTime(CACurrentMediaTime(), from: nil)
        self.speed = 0.0
        self.timeOffset = pausedTime
    }
    
    func resumeAnimationLayer() {
        let pausedTime: CFTimeInterval = self.timeOffset
        self.speed = 1.0
        self.timeOffset = 0.0
        self.beginTime = 0.0
        let timeSincePause: CFTimeInterval = self.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        self.beginTime = timeSincePause
    }
}

