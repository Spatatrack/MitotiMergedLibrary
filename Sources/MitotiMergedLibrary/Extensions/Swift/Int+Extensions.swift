//
//  Extention.swift
//  Equilibrium
//
//  Created by Simone Pistecchia on 12/03/16.
//  Copyright © 2016 Simone Pistecchia. All rights reserved.
//

import Foundation


public extension Int {
    
    ///ES
    ///Int(10...90) // will return an Int between 10 (included) and 90 (included)
    init(_ range: Range<Int> ) {
            let delta = range.lowerBound < 0 ? abs(range.lowerBound) : 0
            let min = UInt32(range.lowerBound + delta)
            let max = UInt32(range.upperBound   + delta)
            self.init(Int(min + arc4random_uniform(max - min)) - delta)
    }
    
    func stringFromSeconds (_ seconds: TimeInterval) -> String {
        let secondsLeft = seconds
        let day = TimeInterval(secondsLeft/3600/24)
        let hours = TimeInterval(day.truncatingRemainder(dividingBy: 1)) * 24
        let minutes = TimeInterval((hours.truncatingRemainder(dividingBy: 1))) * 60
        let seconds = round(TimeInterval(minutes.truncatingRemainder(dividingBy: 1)) * 60)
        //let seconds = Int((secondsLeft % 3600).truncatingRemainder(dividingBy: 60))
        
        var dayString = String(Int(day)) + "d "
        if Int(day) < 1 {
            dayString = ""
        }
        
        var hoursString = String(Int(hours)) + "h "
        if Int(hours) < 1 {hoursString = ""}
        
        var minutesString = String(Int(minutes)) + "m "
        if Int(minutes) < 1 {minutesString = ""}
        
        var secondsString = String(Int(seconds)) + "s"
        if Int(seconds) < 0 {secondsString = "finish"}
        
        //print("\(day)\(hours)\(minutes)\(seconds)")
        return "\(dayString)\(hoursString)\(minutesString)\(secondsString)"
    }
}
//
//extension Int {
//    /**
//     * Returns a random integer in the specified range.
//     */
//    public static func random(_ range: Range<Int>) -> Int {
//        return Int(arc4random_uniform(UInt32(range.upperBound - range.lowerBound))) + range.lowerBound
//    }
//
//    /**
//     * Returns a random integer between 0 and n-1.
//     */
//    public static func random(_ n: Int) -> Int {
//        return Int(arc4random_uniform(UInt32(n)))
//    }
//
//    /**
//     * Returns a random integer in the range min...max, inclusive.
//     */
//    public static func random(min: Int, max: Int) -> Int {
//        assert(min < max)
//        return Int(arc4random_uniform(UInt32(max - min + 1))) + min
//    }
//}

public extension Int64 {
    ///formatted result: 175.1 MB
    func stringByteSize() -> String {
        let bcf = ByteCountFormatter()
        bcf.allowedUnits = [.useKB, .useMB, .useGB] // optional: restricts the units to MB only
        bcf.countStyle = .file
        let string = bcf.string(fromByteCount: self)
        return string
    }

}
public extension Int {
    ///formatted result: 175.1 MB
    func stringByteSize() -> String {
        let bcf = ByteCountFormatter()
        bcf.allowedUnits = [.useKB, .useMB, .useGB] // optional: restricts the units to MB only
        bcf.countStyle = .file
        let string = bcf.string(fromByteCount: Int64(self))
        return string
    }

}
