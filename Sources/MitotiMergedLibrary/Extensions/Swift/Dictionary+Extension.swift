//
//  Dictionary+Extension.swift
//  WAR
//
//  Created by Simone Pistecchia on 19/03/2020.
//  Copyright © 2020 Simone Pistecchia. All rights reserved.
//

import Foundation
import UIKit


extension Dictionary: Mergable {

    public func mergeWithSame<T>(right: T) -> T? {

        if let right = right as? Dictionary {
            return self.merge(right: right) as? T
        }

        assert(false)
        return nil
    }
}

///Marge due dictionary
public extension Dictionary {

    /**
    Merge Dictionaries

    - Parameter left: Dictionary to update
    - Parameter right:  Source dictionary with values to be merged

    - Returns: Merged dictionay
    */

    /** var dsa12 = Dictionary<String, Any>()
    dsa12["a"] = 1
    dsa12["b"] = [1, 2]
    dsa12["s"] = Set([5, 6])
    dsa12["d"] = ["c":5, "x": 2]


    var dsa34 = Dictionary<String, Any>()
    dsa34["a"] = 2
    dsa34["b"] = [3, 4]
    dsa34["s"] = Set([6, 7])
    dsa34["d"] = ["c":-5, "y": 4]


    //let dsa2 = ["a": 1, "b":a34]
    let mdsa3 = dsa12.merge(dsa34)
    print("merging:\n\t\(dsa12)\nwith\n\t\(dsa34) \nyields: \n\t\(mdsa3)")
    */
    func merge(right:Dictionary) -> Dictionary {
        var merged = self
        for (k, rv) in right {

            // case of existing left value
            if let lv = self[k] {

                if let lv = lv as? Mergable, type(of: lv) == type(of: rv) {
                    let m = lv.mergeWithSame(right: rv)
                    merged[k] = m
                }

                else if lv is Mergable {
                    assert(false, "Expected common type for matching keys!")
                }

                else if !(lv is Mergable), let _ = lv as? NSArray {
                    assert(false, "Dictionary literals use incompatible Foundation Types")
                }

                else if !(lv is Mergable), let _ = lv as? NSDictionary {
                    assert(false, "Dictionary literals use incompatible Foundation Types")
                }

                else {
                    merged[k] = rv
                }
            }

                // case of no existing value
            else {
                merged[k] = rv
            }
        }

        return merged
    }
}



public extension Dictionary {
    ///Change cambia keys dictionary
    mutating func switchKey(fromKey: Key, toKey: Key) {
        if let entry = removeValue(forKey: fromKey) {
            self[toKey] = entry
        }
    }
}
