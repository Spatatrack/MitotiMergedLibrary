//
//  Extention.swift
//  Equilibrium
//
//  Created by Simone Pistecchia on 12/03/16.
//  Copyright © 2016 Simone Pistecchia. All rights reserved.
//

import Foundation
import UIKit

/** The value of π as a CGFloat 
    Alt+P (usare alt destro) 
*/
let π = CGFloat.pi //

public extension CGFloat {
    mutating func saturate (min:CGFloat, max:CGFloat) {
        var result = self
        if result > max {result = max}
        if result < min {result = min}
        self = result
    }
    
    init(_ range: Range<Int> ) {
        let delta = range.lowerBound < 0 ? abs(range.lowerBound) : 0
        let min = UInt32(range.lowerBound + delta)
        let max = UInt32(range.upperBound   + delta)
        self.init(CGFloat(min + arc4random_uniform(max - min)) - CGFloat(delta))
    }
}

public extension CGFloat {
    func degreesToRadians () -> CGFloat
    {
        return (self / 180 * π)
    }
    mutating func radiansToDegrees () -> CGFloat
    {
        return (self / π * 180)
    }
}
