//
//  cashape.swift
//  WhatsAppMovieAct
//
//  Created by Simone Pistecchia on 04/04/18.
//  Copyright © 2018 Simone Pistecchia. All rights reserved.
//

import Foundation
import UIKit

public extension CAShapeLayer {
    
    ///view.layer.addSublayer(triangle)
    class func triangleShape(position:CGPoint, size:CGSize, color:UIColor, radius: CGFloat) -> CAShapeLayer {
        let triangle = CAShapeLayer()
        triangle.fillColor = color.cgColor
        // Points of the triangle
        let point1 = CGPoint(x: -size.width / 2, y: size.height / 2)
        let point2 = CGPoint(x: 0, y: -size.height / 2)
        let point3 = CGPoint(x: size.width / 2, y: size.height / 2)
        
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: size.height / 2))
        path.addArc(tangent1End: point1, tangent2End: point2, radius: radius)
        path.addArc(tangent1End: point2, tangent2End: point3, radius: radius)
        path.addArc(tangent1End: point3, tangent2End: point1, radius: radius)
        path.closeSubpath()
        
       
        triangle.path = path
        triangle.position = position
        
        return triangle
    }
}

