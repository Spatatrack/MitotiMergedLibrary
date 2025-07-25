//
//  File.swift
//  
//
//  Created by Simone Pistecchia on 16/01/21.
//

import Foundation

@globalActor
public actor IAPProductsActor {
    public static let shared = IAPProductsActor()
}

/// Prende i prodotti dal plist "InAppProducts.plist"
/// 
/// Questa classe è annotata con @IAPProductsActor per garantire la sicurezza rispetto alla concorrenza.
/// L'accesso alle sue proprietà e metodi avviene quindi all'interno del contesto dell'attore.
/// 
/// Esempio di uso:
/// ```swift
/// await IAPProducts.sharedInstance.productsIdentifiers
/// ```
@IAPProductsActor
public class IAPProducts {
    
    public static let sharedInstance = IAPProducts()
    
    public var productsIdentifiers = Array<ProductIdentifier>()
    
//    public var productsIdentifiersArray: Array<ProductIdentifier> = {
//        returns productsIdentifiers
//    }
    
    init() {
        productsIdentifiers = getProductsFromPlist()
    }
    
    
    private func getProductsFromPlist() -> [String] {
        if let url = Bundle.main.url(forResource:"InAppProducts", withExtension: "plist") {
            do {
                let data = try Data(contentsOf:url)
                if let swiftDictionary = try PropertyListSerialization.propertyList(from: data, format: nil) as? [String] {
                    return swiftDictionary
                }
            }
            catch {
                print("getDicFromPlist: \(error.localizedDescription)")
                return []
            }
        }
        fatalError("non hai messo il file InAppProducts.plist")
    }
}
