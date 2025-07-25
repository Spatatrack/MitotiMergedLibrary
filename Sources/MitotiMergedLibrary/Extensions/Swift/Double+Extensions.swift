//
//  Extention.swift
//  Equilibrium
//
//  Created by Simone Pistecchia on 12/03/16.
//  Copyright © 2016 Simone Pistecchia. All rights reserved.
//

import Foundation
import UIKit



public extension Double {
    func degreesToRadians () -> Double
    {
        return (self / 180 * Double.pi)
    }
    func radiansToDegrees () -> Double
    {
        return (self / Double.pi * 180)
    }
}
