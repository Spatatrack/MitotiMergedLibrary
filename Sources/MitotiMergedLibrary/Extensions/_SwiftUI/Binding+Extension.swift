//
//  Binding+Extension.swift
//  WASP
//
//  Created by Simone Pistecchia on 14/06/2020.
//  Copyright © 2020 Simone Pistecchia. All rights reserved.
//

import Foundation
import SwiftUI

/// per usare il negato su isShowing
@available(iOS 13.0, *)
prefix func !(value: Binding<Bool>) -> Binding<Bool> {
    return Binding<Bool>(get: { return !value.wrappedValue},
                         set: { b in value.wrappedValue = b})
}
