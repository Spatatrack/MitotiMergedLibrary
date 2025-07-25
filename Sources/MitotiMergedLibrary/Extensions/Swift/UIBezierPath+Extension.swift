//
//  uibei.swift
//  WhatsAppMovieAct
//
//  Created by Simone Pistecchia on 04/04/18.
//  Copyright © 2018 Simone Pistecchia. All rights reserved.
//

import Foundation
import UIKit

public extension UIBezierPath {
    convenience init (roundedTriangle width: CGFloat, height: CGFloat, radius: CGFloat) {
        let point1 = CGPoint(x: -width / 2, y: height / 2)
        let point2 = CGPoint(x: 0, y: -height / 2)
        let point3 = CGPoint(x: width / 2, y: height / 2)
        
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: height / 2))
        path.addArc(tangent1End: point1, tangent2End: point2, radius: radius)
        path.addArc(tangent1End: point2, tangent2End: point3, radius: radius)
        path.addArc(tangent1End: point3, tangent2End: point1, radius: radius)
        path.closeSubpath()
        
        self.init(cgPath: path)
    }
}
