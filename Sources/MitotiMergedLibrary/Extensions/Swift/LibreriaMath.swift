//
//  GameScene.swift
//  prova2
//
//  Created by Giuseppe on 19/11/14.
//  Copyright (c) 2014 MitotiM. All rights reserved.
//

import SpriteKit

#if TARGET_OS_IOS
    // iOS-specific code
    import CoreMotion
#elseif TARGET_OS_TV
    // tvOS-specific code
#endif



// funzioni aggiuntive CGVector




public func * (point: CGVector, scalar: Int) -> CGVector {
    return CGVector(dx: point.dx * CGFloat(scalar), dy: point.dy * CGFloat(scalar))
}



// funzioni aggiuntive CGPoint


public func * (point: CGPoint, scalar: Int) -> CGPoint {
    return CGPoint(x: point.x * CGFloat(scalar), y: point.y * CGFloat(scalar))
}

public func * (size: CGSize, scalar: Float) -> CGSize {
    return CGSize(width: size.width * CGFloat(scalar) , height:size.height * CGFloat(scalar))
}



public func ^ (left: CGFloat, right: NSInteger) -> CGFloat {
    var risultato = left
    let numero = left
    for _ in 0  ..< right-1 {
        risultato = risultato * numero;
    }
    
    return risultato
}


public func satura (numero num: CGFloat, massimo max: CGFloat) -> CGFloat{
    return (num < max ? num :  max)
}



public func vers (vettore vet: CGPoint, vettore2 vet2: CGPoint) -> CGPoint{
    var differenza = vet - vet2
    let norma = norma2(differenza)
    differenza.x = differenza.x / norma
    differenza.y = differenza.y / norma
    return differenza
}


public func distanza (_ vet:CGPoint, coordinate2 vet2:CGPoint) ->CGFloat{
    let differenza = vet - vet2
    return norma2(differenza)
}



public func norma2 (_ vet:CGVector) ->CGFloat{
    let quadratoX = vet.dx^2
    let quadratoY = vet.dy^2
    let sommaQuadrati = quadratoX + quadratoY
    let norma = sqrt(sommaQuadrati)
    return norma
}




public func norma2 (_ punt:CGPoint) ->CGFloat{
    let quadratoX = punt.x^2
    let quadratoY = punt.y^2
    let sommaQuadrati = quadratoX + quadratoY
    let norma = sqrt(sommaQuadrati)
    return norma
}



public func versore (vettore vet: CGPoint, vettore2 vet2: CGPoint) -> CGPoint{
    var ret = CGPoint(x: vet.x - vet2.x , y: vet.y - vet2.y)
    let norma = norma2(ret)
    ret.x = ret.x / norma
    ret.y = ret.y / norma
    return ret
}

public func puntoSuRettaPrincipaleX (_ x: CGFloat) -> CGPoint {
    let punto1: CGPoint = CGPoint.zero
    let punto2: CGPoint = CGPoint(x: 1024, y: 768)
    let x1 = punto1.x
    let x2 = punto2.x
    let y1 = punto1.y
    let y2 = punto2.y
    let y = (x-x1)/(x2-x1) * (y2-y1) + y1

    return CGPoint(x: x, y: y)
}
public func puntoSuRettaPrincipaleY (_ y: CGFloat) -> CGPoint {
    let punto1: CGPoint = CGPoint.zero
    let punto2: CGPoint = CGPoint(x: 1024, y: 768)
    let x1 = punto1.x
    let x2 = punto2.x
    let y1 = punto1.y
    let y2 = punto2.y
    let x = (y-y1)/(y2-y1) * (x2-x1) + x1
    
    return CGPoint(x: x, y: y)
}

public func puntoSuRettaSecondarioX (_ x: CGFloat) -> CGPoint {
    let punto1: CGPoint = CGPoint(x: 1024, y: 0)
    let punto2: CGPoint = CGPoint(x: 0, y: 768)
    let x1 = punto1.x
    let x2 = punto2.x
    let y1 = punto1.y
    let y2 = punto2.y
    let y = (x-x1)/(x2-x1) * (y2-y1) + y1
    
    return CGPoint(x: x, y: y)
}
public func puntoSuRettaSecondarioY (_ y: CGFloat) -> CGPoint {
    let punto1: CGPoint = CGPoint(x: 1024, y: 0)
    let punto2: CGPoint = CGPoint(x: 0, y: 768)
    let x1 = punto1.x
    let x2 = punto2.x
    let y1 = punto1.y
    let y2 = punto2.y
    let x = (y-y1)/(y2-y1) * (x2-x1) + x1
    
    return CGPoint(x: x, y: y)
}


public func angoloDxSu (_ y: CGFloat) -> CGPoint {
    let punto1: CGPoint = CGPoint(x: 1024, y: 768)
    let punto2: CGPoint = CGPoint(x: 1024-768, y: 0)
    let x1 = punto1.x
    let x2 = punto2.x
    let y1 = punto1.y
    let y2 = punto2.y
    let x = (y-y1)/(y2-y1) * (x2-x1) + x1
    
    return CGPoint(x: x, y: y)
}
public func angoloDxGiu (_ y: CGFloat) -> CGPoint {
    let punto1: CGPoint = CGPoint(x: 1024, y: 0)
    let punto2: CGPoint = CGPoint(x: 1024-768, y: 768)
    let x1 = punto1.x
    let x2 = punto2.x
    let y1 = punto1.y
    let y2 = punto2.y
    let x = (y-y1)/(y2-y1) * (x2-x1) + x1
    
    return CGPoint(x: x, y: y)
}
public func angoloSxSu (_ y: CGFloat) -> CGPoint {
    let punto1: CGPoint = CGPoint(x: 0, y: 768)
    let punto2: CGPoint = CGPoint(x: 768, y: 0)
    let x1 = punto1.x
    let x2 = punto2.x
    let y1 = punto1.y
    let y2 = punto2.y
    let x = (y-y1)/(y2-y1) * (x2-x1) + x1
    
    return CGPoint(x: x, y: y)
}
public func angoloSxGiu (_ y: CGFloat) -> CGPoint {
    let punto1: CGPoint = CGPoint(x: 0, y: 0)
    let punto2: CGPoint = CGPoint(x: 768, y: 768)
    let x1 = punto1.x
    let x2 = punto2.x
    let y1 = punto1.y
    let y2 = punto2.y
    let x = (y-y1)/(y2-y1) * (x2-x1) + x1
    
    return CGPoint(x: x, y: y)
}
public func puntoCentrale () -> CGPoint {
    let punto1: CGPoint = CGPoint(x: 0, y: 0)
    let punto2: CGPoint = CGPoint(x: 1024, y: 768)
    let x1 = punto1.x
    let x2 = punto2.x
    let y1 = punto1.y
    let y2 = punto2.y
    let y  = CGFloat(768/2)
    let x = (y-y1)/(y2-y1) * (x2-x1) + x1
    
    return CGPoint(x: x, y: y)
}






public class funzioniMatematiche: SKScene  {

}






