//
//  Calculator.swift
//  Minerva
//
//  Created by Simone Pistecchia on 14/12/15.
//  Copyright © 2015 Simone Pistecchia. All rights reserved.
//

import Foundation
import UIKit


public struct Random {
    /*
    static func within<B: Comparable & ForwardIndexType(_ range: ClosedInterval<B>) -> B {
        let inclusiveDistance = range.start.distanceTo(range.end).successor()
        let randomAdvance = B.Distance(arc4random_uniform(UInt32(inclusiveDistance.toIntMax())).toIntMax())
        return range.start.advancedBy(randomAdvance)
    }
    
    static func within<B: Comparable & ForwardIndexType(_ range: ClosedRange<B>) -> B {
        let inclusiveDistance = <#T##Collection corresponding to your index##Collection#>.index(after: <#T##Collection corresponding to your index##Collection#>.distance(from: range.start, to: range.end))
        let randomAdvance = B.Distance(arc4random_uniform(UInt32(inclusiveDistance.toIntMax())).toIntMax())
        return <#T##Collection corresponding to your index##Collection#>.index(range.start, offsetBy: randomAdvance)
    }*/
    
    static func within(_ range: ClosedRange<Float>) -> Float {
        return (range.upperBound - range.lowerBound) * Float(Float(arc4random()) / Float(UInt32.max)) + range.lowerBound
    }
    
    static func within(_ range: ClosedRange<Double>) -> Double {
        return (range.upperBound - range.lowerBound) * Double(Double(arc4random()) / Double(UInt32.max)) + range.lowerBound
    }
    
    static func within(_ range: ClosedRange<CGFloat>) -> CGFloat {
        return (range.upperBound - range.lowerBound) * CGFloat(CGFloat(arc4random()) / CGFloat(UInt32.max)) + range.lowerBound
    }
    
    static func within(_ range: ClosedRange<Int>) -> Int {
        return (range.upperBound - range.lowerBound) * Int(arc4random() / UINT32_MAX) + range.lowerBound
    }
    
    //RANDOM es 1...3 random tra 1 compreso e 3 compreso
    func within(_ range: ClosedRange<Int>) -> Int {
        let diff = range.upperBound - range.lowerBound + 1
        let random:Float = Float(arc4random_uniform(UInt32(diff)))
        return Int(random) + range.lowerBound
    }
    
    static func generate() -> Int {
        return Random.within(0...1)
    }
    
    static func generate() -> Bool {
        return Random.generate() == 0
    }
    
    static func generate() -> Float {
        return Random.within(0.0...1.0)
    }
    
    static func generate() -> Double {
        return Random.within(0.0...1.0)
    }
    
    static func generate() -> CGFloat {
        return CGFloat(Random.within(0.0...1.0))
    }
    
    static func generate(_ frame: CGRect) -> CGPoint {
        let xOrigin = Float(frame.origin.x)
        let yOrigin = Float(frame.origin.y)
        
        let wSize = Float(frame.size.width)
        let hSize = Float(frame.size.height)
        
        let x = CGFloat(Random.within(xOrigin...wSize))
        let y = CGFloat(Random.within(yOrigin...hSize))
        return CGPoint(x: x, y: y)
    }
}
