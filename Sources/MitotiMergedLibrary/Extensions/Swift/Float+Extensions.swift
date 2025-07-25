//
//  Extention.swift
//  Equilibrium
//
//  Created by Simone Pistecchia on 12/03/16.
//  Copyright © 2016 Simone Pistecchia. All rights reserved.
//

import Foundation


public extension Float {
    init(_ range: Range<Int> ) {
        let delta = range.lowerBound < 0 ? abs(range.lowerBound) : 0
        let min = UInt32(range.lowerBound + delta)
        let max = UInt32(range.upperBound   + delta)
        self.init(Float(min + arc4random_uniform(max - min)) - Float(delta))
    }
}


public extension Float {
    //number of decimal
    func round(to places: Int) -> Float {
        let divisor = pow(10.0, Float(places))
        return (self * divisor).rounded() / divisor
    }
    
    ///number of decimal
    func getPercentage(to digits: Int) -> String {
        if self >= 1 {
            return String(Int(self * 100)) + "%"
        }
        return String(format: "%.\(digits)f", self * 100) + "%"
    }
    /*
    func getPercentage(to places: Int) -> String {
        if places == 0 {return String(format: "%.f", self * 100) + "%"}
        let divisor = pow(10.0, Float(places))
        let num = (self * 100 * divisor).rounded() / divisor
        return "\(num)%"
    }*/
    /*
    func getPercentage(to places: Int) -> String {
        let intValue = Int(ceil(self * 100)) ceil arrotonda al valore
        if intValue == 0 {return "loading..."}
        return "\(intValue)%"
    }*/
}
