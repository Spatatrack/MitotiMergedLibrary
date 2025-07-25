//
//  Sequence+Extension.swift
//  WARS
//
//  Created by Simone Pistecchia on 03/06/2020.
//  Copyright © 2020 Simone Pistecchia. All rights reserved.
//

import Foundation

public extension Sequence {
    /// Returns an array with the contents of this sequence, shuffled.
    func shuffled() -> [Iterator.Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
}

public extension Sequence where Element: AdditiveArithmetic {
    /// Returns the total sum of all elements in the sequence
    func sum() -> Element { reduce(.zero, +) }
}


public extension Sequence  {
    /// Example
    /// - Parameter keyPath: let users: [User] = [
    /// .init(name: "Steve", age: 45),
    /// .init(name: "Tim", age: 50)]
    /// - Returns: let ageSum = users.sum(\.age) // 95

    func sum<T: AdditiveArithmetic>(_ keyPath: KeyPath<Element, T>) -> T {
        reduce(.zero) { $0 + $1[keyPath: keyPath] }
    }
}

///11-03-2022
///per trovare min o max dentro un array di struct
///let points: [CGPoint] = [.init(x: 1.2, y: 3.4), .init(x: 0.1, y: 2.2), .init(x: 2.3, y: 1.1)]
///let maxX = points.max(\.x)
///let maxY = points.max(\.y)
///print("maxX:", maxX ?? "nil")
///print("maxY:", maxY ?? "nil")
public extension Sequence {
    func max<T: Comparable>(_ predicate: (Element) -> T)  -> Element? {
        self.max(by: { predicate($0) < predicate($1) })
    }
    func min<T: Comparable>(_ predicate: (Element) -> T)  -> Element? {
        self.min(by: { predicate($0) < predicate($1) })
    }
}
