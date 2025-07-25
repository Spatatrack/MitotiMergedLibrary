//
//  Extention.swift
//  Equilibrium
//
//  Created by Simone Pistecchia on 12/03/16.
//  Copyright © 2016 Simone Pistecchia. All rights reserved.
//

import Foundation
import UIKit


public extension Set {
    
    ///Get a random item into an Set
    func randomElement() -> Element?
    {
        let randomInt = Int(arc4random_uniform(UInt32(self.count)))
        let theIndex = index(startIndex, offsetBy: randomInt)
        return count == 0 ? nil: self[theIndex]
    }
}


extension Set: Mergable {

    public func mergeWithSame<T>(right: T) -> T? {

        if let right = right as? Set {
            return self.union(right) as? T
        }

        assert(false)
        return nil
    }
}

///04-03-2022
public extension Sequence where Element: Hashable {
    ///ritorna un array di elementi unici
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted
    }
}
    ///trasformain arrey du elementi unici
    mutating func trasformInUniqued() {
        var set = Set<Element>()
        let seq = filter { set.insert($0).inserted }
        self = seq as! Self
    }
}
