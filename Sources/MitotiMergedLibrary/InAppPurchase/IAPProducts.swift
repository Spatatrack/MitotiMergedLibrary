//
//  File.swift
//  
//
//  Created by Simone Pistecchia on 16/01/21.
//

import Foundation


///prende i prodotti dal plist "InAppProducts.plist"
//<?xml version="1.0" encoding="UTF-8"?>
//<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
//<plist version="1.0">
//<array>
//    <string>it.mitotim.RobArt.widget.monster</string>
//    <string>it.mitotim.RobArt.widget.normal</string>
//</array>
//</plist>
public class IAPProducts {
    
    public static var sharedInstance = IAPProducts()
    
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
