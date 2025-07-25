//
//  File.swift
//  
//
//  Created by Simone Pistecchia on 18/03/22.
//

import Foundation

//18-03-2022
public extension Comparable {
    ///x = x.clamped(0.5, 5.0) rientra tra due numeri
    func clamped(_ f: Self, _ t: Self)  ->  Self {
        var r = self
        if r < f { r = f }
        if r > t { r = t }
        // (use SIMPLE, EXPLICIT code here to make it utterly clear
        // whether we are inclusive, what form of equality, etc etc)
        return r
    }
}
