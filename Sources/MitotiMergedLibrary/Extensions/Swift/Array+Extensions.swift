//
//  Extention.swift
//  Equilibrium
//
//  Created by Simone Pistecchia on 12/03/16.
//  Copyright © 2016 Simone Pistecchia. All rights reserved.
//

import Foundation
import UIKit


public extension Array {
    
    ///Get a random item into an array
    func randomItem() -> Element {
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]//prova
    }
}



public extension Array {
    
    ///Get a random items into an array exclusive
    ///In pratica se ho array di 1,2,3 e voglio una lista di items random ma che non si ripete, es output 1 oppure 3,1 o 2,3,1
    func randomItems() -> [Element] {
        let randomNum = Int(1..<self.count)
        var returnArray:[Element]=[]
        for f in self.shuffled() {
            if returnArray.count < randomNum + 1 {
                returnArray.append(f)
            }
        }
        return returnArray
    }    
}

//2-2-2020
public protocol Dated {
    var date: Date { get }
}
//2-2-2020
public extension Array where Element: Dated {
    func groupedBy(_ dateComponents: Set<Calendar.Component>) -> [Date: [Element]] {
        let initial: [Date: [Element]] = [:]
        let groupedByDateComponents = reduce(into: initial) { acc, cur in
            let components = Calendar.current.dateComponents(dateComponents, from: cur.date)
            let date = Calendar.current.date(from: components)!
            let existing = acc[date] ?? []
            acc[date] = existing + [cur]
        }
        return groupedByDateComponents
    }
    func groupedByTimeZone(_ dateComponents: Set<Calendar.Component>) -> [Date: [Element]] {
        let initial: [Date: [Element]] = [:]
        let groupedByDateComponents = reduce(into: initial) { acc, cur in
            var calendar = Calendar.current
            calendar.timeZone = .current//TimeZone(identifier: "UTC")!
            let components = calendar.dateComponents(dateComponents, from: cur.date)
            let date = calendar.date(from: components)!
            let existing = acc[date] ?? []
            acc[date] = existing + [cur]
        }
        return groupedByDateComponents
    }
}



public protocol Mergable {
    func mergeWithSame<T>(right: T) -> T?
}

extension Array: Mergable {

    public func mergeWithSame<T>(right: T) -> T? {

        if let right = right as? Array {
            return (self + right) as? T
        }

        assert(false)
        return nil
    }
}

public extension Array {
    ///divide un array in array di n elementi dentro array: let arrs = [1,2,3,4,5,6,7,8,9]
    ///
    ///print(arrs.splitElements(chunkSize: 2)) //prints[[1, 2], [3, 4], [5, 6], [7, 8], [9]]
    func splitElements(chunkSize: Int) -> [[Element]] {
        return stride(from: 0, to: self.count, by: chunkSize).map {
            Array(self[$0..<Swift.min($0 + chunkSize, self.count)])
        }
    }

}

public extension Array {
    /// se voglio limitare l'array agli ultimi 3 elementi ad esempio (sovrascrive se stesso
    mutating func limitRecentElements(numElements:Int) {
        let endInd = self.endIndex
        if numElements >= endInd {
            return
        }
        let indexFirstEl = endInd - numElements
        self = Array(self[indexFirstEl..<endInd])
    }
    /// se voglio aggiungere un elemento ad un array ma senza eccedere un numero di elementi (se eccede rimuove il meno recente e inserisce il nuovo
    @inlinable mutating func appendFixeSize(_ newElement: Element, arraySize:Int) {
        if arraySize > self.endIndex {
            self.insert(newElement, at: 0)
        }
        else {
            self.removeLast()
            self.insert(newElement, at: 0)
        }
    }
}
public extension Array where Element: Equatable {
    /// se voglio aggiungere un elemento (No doppioni) ad un array ma senza eccedere un numero di elementi (se eccede rimuove il meno recente e inserisce il nuovo
    @inlinable mutating func appendFixeSizeNoDoubleElements(_ newElement: Element, arraySize:Int) {
        if let index = self.firstIndex(of: newElement) {
            self.remove(at: index)
        }
        if arraySize > self.endIndex {
            self.insert(newElement, at: 0)
        }
        else {
            self.removeLast()
            self.insert(newElement, at: 0)
        }
    }
}

public extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()

        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }

    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}

//10-11-2020
///visto che forEach non modifica una struct, questo modifica un array di struct
public extension Array {
    mutating func modifyForEach(_ body: (_ index: Index, _ element: inout Element) -> ()) {
        for index in indices {
            modifyElement(atIndex: index) { body(index, &$0) }
        }
    }

    mutating func modifyElement(atIndex index: Index, _ modifyElement: (_ element: inout Element) -> ()) {
        var element = self[index]
        modifyElement(&element)
        self[index] = element
    }
}

//20.01.2023

public extension Array {
    ///se non c'è precedente, va all'ultimo
    func previousRecursive(currentIdx: inout Int) -> Element? {
        if currentIdx == 0 {
            currentIdx = self.count - 1
            return self.last
        }
        let nextIndex = (currentIdx - 1) % self.count
        if self.indices.contains(nextIndex) {
            currentIdx = nextIndex
            return self[nextIndex]
        }
        else {
            return nil
        }
    }
    ///se finisce la lista, torna dal primo
    func nextRecursive(currentIdx: inout Int) -> Element? {
        let nextIndex = (currentIdx + 1) % self.count
        if self.indices.contains(nextIndex) {
            currentIdx = nextIndex
            return self[nextIndex]
        }
        else {
            return nil
        }
    }
    
    ///Ritorna l'elemenro precedente e modifica l'index al precedente. se non c'è, nil
    func previous(currentIdx: inout Int) -> Element? {
        let nextIndex = currentIdx - 1
        if currentIdx < 0 {
            return nil
        }
        else {
            if self.indices.contains(nextIndex) {
                currentIdx = nextIndex
                return self[nextIndex]
            }
            else {
                return nil
            }
        }
    }
    ///Ritorna l'elemenro successivo e modifica l'index al successivo. se non c'è, nil
    func next(currentIdx: inout Int) -> Element? {
        let nextIndex = currentIdx + 1
        if currentIdx >= self.count {
            return nil
        }
        else {
            if self.indices.contains(nextIndex) {
                currentIdx = nextIndex
                return self[nextIndex]
            }
            else {
                return nil
            }
        }
    }
    
    ///Ritorna l'elemenro precedente SENZA modificare l'index. se non c'è, nil
    func previousElement(currentIdx: Int) -> Element? {
        let nextIndex = currentIdx - 1
        if currentIdx < 0 {
            return nil
        }
        else {
            if self.indices.contains(nextIndex) {               
                return self[nextIndex]
            }
            else {
                return nil
            }
        }
    }
    ///Ritorna l'elemenro successivo SENZA modificare l'index. se non c'è, nil
    func nextElement(currentIdx: Int) -> Element? {
        let nextIndex = currentIdx + 1
        if currentIdx >= self.count {
            return nil
        }
        else {
            if self.indices.contains(nextIndex) {
                return self[nextIndex]
            }
            else {
                return nil
            }
        }
    }
}
