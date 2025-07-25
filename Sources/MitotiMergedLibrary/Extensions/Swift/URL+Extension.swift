//
//  URL+Extension.swift
//  WARS
//
//  Created by Simone Pistecchia on 23/05/2020.
//  Copyright © 2020 Simone Pistecchia. All rights reserved.
//

import Foundation
///una volta che ho int, uso la funzione extension Int64 func stringByteSize() -> String 
public extension URL {
    var fileSize: Int? {
        let value = try? resourceValues(forKeys: [.fileSizeKey])
        return value?.fileSize
    }
    var fileSizeString: String {
        if let size = self.fileSize {
            let bigInt = Int64(size)
            return bigInt.stringByteSize()
        }
        else {
            return ""
        }
    }
}

public extension URL {
    
    func sizeOfFolder() -> String? {
        do {
            let contents = try FileManager.default.contentsOfDirectory(at: self, includingPropertiesForKeys: nil, options: [])
            var folderSize: Int64 = 0
            for content in contents {
                folderSize += Int64(content.fileSize ?? 0)
            }
            return folderSize.stringByteSize()

        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
}

public extension URL {
    var creationDate: Date? {
        return (try? resourceValues(forKeys: [.creationDateKey]))?.creationDate
    }
}
