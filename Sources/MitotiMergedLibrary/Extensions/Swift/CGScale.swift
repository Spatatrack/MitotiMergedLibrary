//
//  CGScale.swift
//  Pippi
//
//  Created by Simone Pistecchia on 07/08/16.
//  Copyright © 2016 Simone Pistecchia. All rights reserved.
//

import Foundation
import SpriteKit


//INVENTATA DA ME

public struct CGScale {
    public var xScale: CGFloat
    public var yScale: CGFloat
}
public func CGScaleMake(_ xScale: CGFloat, _ yScale: CGFloat) -> CGScale {
    return CGScale(xScale: xScale, yScale: yScale)
}
