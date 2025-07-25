//
//  GenericExtensions.swift
//  Bat vs Spiders
//
//  Created by Simone Pistecchia on 16/07/17.
//  Copyright © 2017 Simone Pistecchia. All rights reserved.
//

import Foundation


///RANDOM ELEMENT ESCLUSIVI, se ne ho già scelto uno non me lo ripete

public extension MutableCollection where Indices.Iterator.Element == Index {
    /// Shuffles the contents of this collection.
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (firstUnshuffled , unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            let d: Int = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            guard d != 0 else { continue }
            let i = index(firstUnshuffled, offsetBy: d)
            self.swapAt(firstUnshuffled, i)
        }
    }
}


