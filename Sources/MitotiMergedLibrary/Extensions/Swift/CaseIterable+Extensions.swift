//
//  File.swift
//  
//
//  Created by Simone Pistecchia on 20/01/23.
//

import Foundation

///per andare avanti o indietro su enum
extension CaseIterable where Self: Equatable, AllCases: BidirectionalCollection {
    ///se non c'è precedente, va all'ultimo
    func previousRecursive() -> Self? {
        let all = Self.allCases
        if let idx = all.firstIndex(of: self) {
            let previous = all.index(before: idx)
            return all[previous < all.startIndex ? all.index(before: all.endIndex) : previous]
        }
        return nil
    }
    ///se finisce la lista, torna dal primo
    func nextRecursive() -> Self? {
        let all = Self.allCases
        if let idx = all.firstIndex(of: self) {
            let next = all.index(after: idx)
            return all[next == all.endIndex ? all.startIndex : next]
        }
        return nil
    }
    
    ///se non c'è, nil
    func previous() -> Self? {
        let all = Self.allCases
        if let idx = all.firstIndex(of: self) {
            let previous = all.index(before: idx)
            if previous < all.startIndex {
                return nil
            }
            return all[previous < all.startIndex ? all.index(before: all.endIndex) : previous]
        }
        return nil
    }
    ///se non c'è, nil
    func next() -> Self? {
        let all = Self.allCases
        if let idx = all.firstIndex(of: self) {
            let next = all.index(after: idx)
            if next == all.endIndex {
                return nil
            }
            return all[next == all.endIndex ? all.startIndex : next]
        }
        return nil
    }
}
