//
//  CGVector+Extension.swift
//  Pippi
//
//  Created by Simone Pistecchia on 06/08/16.
//  Copyright © 2016 Simone Pistecchia. All rights reserved.
//

import Foundation
import UIKit


/**
 * Creates a new CGVector given a CGSize.
 */
public func CGVectorFromSize(_ size: CGSize) -> CGVector{
    let ret = CGVector(dx: size.width, dy: size.height)
    return ret
}

/**
 * Creates a new CGVector given a CGSize.
 */
public func CGVectorFromPoint(_ point: CGPoint) -> CGVector{
    let ret = CGVector(dx: point.x, dy: point.y)
    return ret
}

public extension CGVector {
    func speed() -> CGFloat {
        return sqrt(dx*dx+dy*dy)
    }
    func angle() -> CGFloat {
        return atan2(dy, dx)
    }
}
