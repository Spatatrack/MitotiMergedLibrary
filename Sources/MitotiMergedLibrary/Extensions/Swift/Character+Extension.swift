//
//  Character+Extension.swift
//  WhatsAppMovieAct
//
//  Created by Simone Pistecchia on 22/10/17.
//  Copyright © 2017 Simone Pistecchia. All rights reserved.
//

import Foundation

public extension Character {
    var containsEmoji: Bool {
        return unicodeScalars.contains { $0.isEmoji }
    }
}

public extension Character {
    var unicodeScalarCodePoint: Int {
        let characterString = String(self)
        let scalars = characterString.unicodeScalars
        return Int(scalars[scalars.startIndex].value)
    }
}
