//
//  Math.swift
//  Minerva
//
//  Created by Simone Pistecchia on 15/12/15.
//  Copyright © 2015 Simone Pistecchia. All rights reserved.
//




//Math Utilities
/*
static inline CGPoint CGPointSubtract(const CGPoint a, const CGPoint b)
{
    return CGPointMake(a.x - b.x, a.y - b.y);
}
static inline CGPoint CGPointMultiplyScalar(const CGPoint a,
const CGFloat b)
{
    return CGPointMake(a.x * b, a.y * b);
}
static inline CGFloat CGPointLength(const CGPoint a)
{
    return sqrtf(a.x * a.x + a.y * a.y);
}
static inline CGPoint CGPointNormalize(const CGPoint a)
{
    CGFloat length = CGPointLength(a);
    return CGPointMake(a.x / length, a.y / length);
}
static inline CGPoint CGPointAdd(const CGPoint a,
const CGPoint b)
{
    return CGPointMake(a.x + b.x, a.y + b.y);
}
*/

import Foundation
import CoreGraphics
import SpriteKit



public func AngleFromTwoPoint(_ a : CGPoint, b : CGPoint) -> CGFloat {

    let deltaX = b.x - a.x
    let deltaY = b.y - a.y
    
    var arcoTan = CGFloat(atan(deltaY/deltaX))
    
    if deltaX < 0 {
        arcoTan += π
    }
    return arcoTan
}
public func AngleFromTwoPointAttenuateX(_ a : CGPoint, b : CGPoint) -> CGFloat {
    
    var deltaX = abs(b.x - a.x)
    //Se vado troppo a destra sta troppo in basso, metto limite come se tocco al maz a 200 pixel
    deltaX = min(deltaX, 110)
    ////print(deltaX)
    let deltaY = b.y - a.y
    
    let arcoTan = CGFloat(atan(deltaY/deltaX))
    
    return arcoTan
}



public extension Equatable {
    func oneOf(_ other: Self...) -> Bool {
        return other.contains(self)
    }
}

public protocol NumericType {
    static func +(lhs: Self, rhs: Self) -> Self
    static func -(lhs: Self, rhs: Self) -> Self
    static func *(lhs: Self, rhs: Self) -> Self
    static func /(lhs: Self, rhs: Self) -> Self
    static func %(lhs: Self, rhs: Self) -> Self
    init(_ v: Int)
}

//extension Double : NumericType { }
//extension Float  : NumericType { }
extension Int    : NumericType { }
extension Int8   : NumericType { }
extension Int16  : NumericType { }
extension Int32  : NumericType { }
extension Int64  : NumericType { }
extension UInt   : NumericType { }
extension UInt8  : NumericType { }
extension UInt16 : NumericType { }
extension UInt32 : NumericType { }
extension UInt64 : NumericType { }

/**
 * Returns the length (magnitude) of the vector described by the CGPoint.
 */
public func CGPointSubtract(_ a : CGPoint, b : CGPoint) -> CGPoint {
    return CGPoint(x: a.x - b.x, y: a.y - b.y)
}
public func CGPointAdd(_ p1 : CGPoint, p2 : CGPoint) -> CGPoint {
    return CGPoint(x: p1.x + p2.x, y: p1.y + p2.y)
}

//public func CGPointMake(x: CGFloat, _ y: CGFloat) -> CGPoint
//public var CGPointZero: CGPoint { get }


/**
 * Adds two CGPoint values and returns the result as a new CGPoint.
 */
public func + (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

/**
 * Increments a CGPoint with the value of another.
 */
public func += (left: inout CGPoint, right: CGPoint) {
    left = left + right
}

/**
 * Adds a CGVector to this CGPoint and returns the result as a new CGPoint.
 */
public func + (left: CGPoint, right: CGVector) -> CGPoint {
    return CGPoint(x: left.x + right.dx, y: left.y + right.dy)
}

/**
 * Increments a CGPoint with the value of a CGVector.
 */
public func += (left: inout CGPoint, right: CGVector) {
    left = left + right
}

/**
 * Subtracts two CGPoint values and returns the result as a new CGPoint.
 */
public func - (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

/**
 * Decrements a CGPoint with the value of another.
 */
public func -= (left: inout CGPoint, right: CGPoint) {
    left = left - right
}

/**
 * Subtracts a CGVector from a CGPoint and returns the result as a new CGPoint.
 */
public func - (left: CGPoint, right: CGVector) -> CGPoint {
    return CGPoint(x: left.x - right.dx, y: left.y - right.dy)
}

/**
 * Decrements a CGPoint with the value of a CGVector.
 */
public func -= (left: inout CGPoint, right: CGVector) {
    left = left - right
}

/**
 * Multiplies two CGPoint values and returns the result as a new CGPoint.
 */
public func * (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x * right.x, y: left.y * right.y)
}

/**
 * Multiplies a CGPoint with another.
 */
public func *= (left: inout CGPoint, right: CGPoint) {
    left = left * right
}

/**
 * Multiplies the x and y fields of a CGPoint with the same scalar value and
 * returns the result as a new CGPoint.
 */
public func * (point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x * scalar, y: point.y * scalar)
}

/**
 * Multiplies the x and y fields of a CGPoint with the same scalar value.
 */
public func *= (point: inout CGPoint, scalar: CGFloat) {
    point = point * scalar
}

/**
 * Multiplies a CGPoint with a CGVector and returns the result as a new CGPoint.
 */
public func * (left: CGPoint, right: CGVector) -> CGPoint {
    return CGPoint(x: left.x * right.dx, y: left.y * right.dy)
}

/**
 * Multiplies a CGPoint with a CGVector.
 */
public func *= (left: inout CGPoint, right: CGVector) {
    left = left * right
}

/**
 * Divides two CGPoint values and returns the result as a new CGPoint.
 */
public func / (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x / right.x, y: left.y / right.y)
}

/**
 * Divides a CGPoint by another.
 */
public func /= (left: inout CGPoint, right: CGPoint) {
    left = left / right
}

/**
 * Divides the x and y fields of a CGPoint by the same scalar value and returns
 * the result as a new CGPoint.
 */
public func / (point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x / scalar, y: point.y / scalar)
}

/**
 * Divides the x and y fields of a CGPoint by the same scalar value.
 */
public func /= (point: inout CGPoint, scalar: CGFloat) {
    point = point / scalar
}

/**
 * Divides a CGPoint by a CGVector and returns the result as a new CGPoint.
 */
public func / (left: CGPoint, right: CGVector) -> CGPoint {
    return CGPoint(x: left.x / right.dx, y: left.y / right.dy)
}

/**
 * Divides a CGPoint by a CGVector.
 */
public func /= (left: inout CGPoint, right: CGVector) {
    left = left / right
}

/**
 * Performs a linear interpolation between two CGPoint values.
 */
public func lerp(start: CGPoint, end: CGPoint, t: CGFloat) -> CGPoint {
    return start + (end - start) * t
}
/**
 * Distance between two CGPoint values.
 */
public func distance (from:CGPoint, to:CGPoint) -> CGFloat{
    let a = to.x - from.x
    let b = to.y - from.y
    let dist = sqrt(a*a + b*b)
    return dist
}


