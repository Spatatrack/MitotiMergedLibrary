//
//  Boundle+Extension.swift
//  WARS
//
//  Created by Simone Pistecchia on 07/05/2020.
//  Copyright © 2020 Simone Pistecchia. All rights reserved.
//

import Foundation
import UIKit

public extension Bundle {
    ///icona dell'app  let appIcon = Bundle.main.icon
    var icon: UIImage? {
        if let icons = infoDictionary?["CFBundleIcons"] as? [String: Any],
            let primaryIcon = icons["CFBundlePrimaryIcon"] as? [String: Any],
            let iconFiles = primaryIcon["CFBundleIconFiles"] as? [String],
            let lastIcon = iconFiles.last {
            return UIImage(named: lastIcon)
        }
        return nil
    }
}
