//
//  FileManager+Extension.swift
//  WARS
//
//  Created by Simone Pistecchia on 21/05/2020.
//  Copyright © 2020 Simone Pistecchia. All rights reserved.
//

import Foundation

public extension FileManager {
    
    @available(iOS 10.0, *)
    func clearTmpDirectory() {
        do {
            let tmpDirURL = FileManager.default.temporaryDirectory
            let tmpDirectory = try contentsOfDirectory(atPath: tmpDirURL.path)
            try tmpDirectory.forEach { file in
                let fileUrl = tmpDirURL.appendingPathComponent(file)
                try removeItem(atPath: fileUrl.path)
            }
        } catch {
           //catch the error somehow
        }
    }
}
