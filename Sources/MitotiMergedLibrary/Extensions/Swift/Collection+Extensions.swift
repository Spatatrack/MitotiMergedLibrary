//
//  Collection+Extensions.swift
//  WARS
//
//  Created by Simone Pistecchia on 16/04/2020.
//  Copyright © 2020 Simone Pistecchia. All rights reserved.
//

import Foundation


extension Collection {

    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    /** let array = [1, 2, 3]

    for index in -20...20 {
        if let item = array[safe: index] {
            print(item)
        }
    }*/
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}


/// <#Description#>
//let votes = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
//let votesTotal = votes.sum()                       // 55
//let votesAverage = votes.average()                 // 5
//let votesDoubleAverage: Double = votes.average()   // 5.5
public extension Collection where Element: BinaryInteger {
    /// Returns the average of all elements in the array
    /// - Returns: <#description#>
    func average() -> Element { isEmpty ? .zero : sum() / Element(count) }
    /// Returns the average of all elements in the array as Floating Point type
    func average<T: FloatingPoint>() -> T { isEmpty ? .zero : T(sum()) / T(count) }
}
public extension Collection where Element: BinaryFloatingPoint {
    /// Returns the average of all elements in the array
    func average() -> Element { isEmpty ? .zero : Element(sum()) / Element(count) }
}
public extension Collection where Element == Decimal {
    func average() -> Decimal { isEmpty ? .zero : sum() / Decimal(count) }
}


///let users: [User] = [
///    .init(name: "Steve", age: 45),
///    .init(name: "Tim", age: 50)]
///
///let ageSum = users.sum(\.age) // 95
///let ageAvg = users.average(\.age)                 // 47
///let ageAvgDouble: Double = users.average(\.age)   // 47.5
public extension Collection {
    func average<I: BinaryInteger>(_ keyPath: KeyPath<Element, I>) -> I {
        sum(keyPath) / I(count)
    }
    func average<I: BinaryInteger, F: BinaryFloatingPoint>(_ keyPath: KeyPath<Element, I>) -> F {
        F(sum(keyPath)) / F(count)
    }
    func average<F: BinaryFloatingPoint>(_ keyPath: KeyPath<Element, F>) -> F {
        sum(keyPath) / F(count)
    }
    func average(_ keyPath: KeyPath<Element, Decimal>) -> Decimal {
        sum(keyPath) / Decimal(count)
    }
}
