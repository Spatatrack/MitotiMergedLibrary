//
//  Extention.swift
//  Equilibrium
//
//  Created by Simone Pistecchia on 12/03/16.
//  Copyright © 2016 Simone Pistecchia. All rights reserved.
//

import Foundation
import SpriteKit
import CoreGraphics



///Restituisce stessa Y sposta solo la x
extension CGPoint {
    public mutating func ChangeXto(_ x:CGFloat){
        let p:CGPoint = CGPoint(x: x, y: self.y)
        self = p
    }
    public mutating func ChangeYto(_ y:CGFloat){
        let p:CGPoint = CGPoint(x: self.x, y: y)
        self = p
    }
    public mutating func addX(_ x:CGFloat){
        let p:CGPoint = CGPoint(x: self.x + x, y: self.y)
        self = p
    }
    public mutating func addY(_ y:CGFloat){
        let p:CGPoint = CGPoint(x: self.x, y: self.y + y)
        self = p
    }
    public mutating func addXY(x:CGFloat, y:CGFloat){
        let p:CGPoint = CGPoint(x: self.x + x, y: self.y + y)
        self = p
    }
    public mutating func subStractX(_ x:CGFloat){
        let p:CGPoint = CGPoint(x: self.x - x, y: self.y)
        self = p
    }
    public mutating func subStractY(_ y:CGFloat){
        let p:CGPoint = CGPoint(x: self.x, y: self.y - y)
        self = p
    }
    
    public mutating func subStractXY(x:CGFloat, y:CGFloat){
        let p:CGPoint = CGPoint(x: self.x - x, y: self.y - y)
        self = p
    }
    
    public func getPointAddX(_ x:CGFloat) -> CGPoint {
        let p:CGPoint = CGPoint(x: self.x + x, y: self.y)
        return p
    }
    public func getPointAddY(_ y:CGFloat) -> CGPoint {
        let p:CGPoint = CGPoint(x: self.x, y: self.y + y)
        return p
    }
    public func getPointSubstractX(_ x:CGFloat) -> CGPoint {
        let p:CGPoint = CGPoint(x: self.x - x, y: self.y)
        return p
    }
    public func getPointSubstractY(_ y:CGFloat) -> CGPoint {
        let p:CGPoint = CGPoint(x: self.x, y: self.y - y)
        return p
    }
    
    /// x=x y=-y
    public mutating func invertYcoordinate() {
        let p:CGPoint = CGPoint(x: self.x, y: -self.y)
        self = p
    }
    
    /// x=x y=-y
    public func getInvertYcoordinate() -> CGPoint {
        let p:CGPoint = CGPoint(x: self.x, y: -self.y)
        return p
    }
}

extension CGPoint {
    public init(vector: vector_float2)
    {
        self.init()
        self.x = CGFloat(vector.x)
        self.y = CGFloat(vector.y)
    }
}

// MARK: Points and vectors
public extension CGPoint {
    init(_ point: SIMD2<Float>) {
        self.init()
        x = CGFloat(point.x)
        y = CGFloat(point.y)
    }
}

public extension CGPoint {
    /**
     * Creates a new CGPoint given a CGVector.
     */
    init(vector: CGVector) {
        self.init(x: vector.dx, y: vector.dy)
    }
    
    /**
     * Given an angle in radians, creates a vector of length 1.0 and returns the
     * result as a new CGPoint. An angle of 0 is assumed to point to the right.
     */
    init(angle: CGFloat) {
        self.init(x: cos(angle), y: sin(angle))
    }
    
    /**
     * Adds (dx, dy) to the point.
     */
    mutating func offset(dx: CGFloat, dy: CGFloat) -> CGPoint {
        x += dx
        y += dy
        return self
    }
    
    
    
    /**
     * Returns the length (magnitude) of the vector described by the CGPoint.
     */
    func length() -> CGFloat {
        return sqrt(x*x + y*y)
    }
    
    /**
     * Returns the squared length of the vector described by the CGPoint.
     */
    func lengthSquared() -> CGFloat {
        return x*x + y*y
    }
    
    /**
     * Normalizes the vector described by the CGPoint to length 1.0 and returns
     * the result as a new CGPoint.
     */
    func normalized() -> CGPoint {
        let len = length()
        return len>0 ? self / len : CGPoint.zero
    }
    
    /**
     * Normalizes the vector described by the CGPoint to length 1.0.
     */
    mutating func normalize() -> CGPoint {
        self = normalized()
        return self
    }
    
    /**
     * Calculates the distance between two CGPoints. Pythagoras!
     */
    func distanceTo(_ point: CGPoint) -> CGFloat {
        return (self - point).length()
    }
    
    /**
     * Returns the angle in radians of the vector described by the CGPoint.
     * The range of the angle is -π to π; an angle of 0 points to the right.
     */
    var angle: CGFloat {
        return atan2(y, x)
    }
}



