//
//  EditMode+Extension.swift
//  WARS
//
//  Created by Simone Pistecchia on 02/05/2020.
//  Copyright © 2020 Simone Pistecchia. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
extension EditMode {
    var title: String {
        self == .active ? NSLocalizedString("done", tableName: "EXTLocalizable", bundle: .module, comment: "") : NSLocalizedString("edit", tableName: "MTMLocalizable", bundle: .module, comment: "")
    }

    mutating func toggle() {
        self = self == .active ? .inactive : .active
    }
}
