//
//  String+Extension.swift
//  WhatsAppMovieAct
//
//  Created by Simone Pistecchia on 22/10/17.
//  Copyright © 2017 Simone Pistecchia. All rights reserved.
//

import Foundation
import UIKit


public extension String {
    ///Es let str = "👨‍👨‍👧‍👧pippo👨‍👨‍👧‍👧 sta pippando 😍😍" print: ["", "👨‍👨‍👧‍👧", "pippo", "👨‍👨‍👧‍👧", " sta pippando ", "😍","😍"]
    var splitAllEmojiAndSentence: [String] {
        let array = Array(self)
        var result:[String] = []
        var sentenceInProgress: String = ""
        for lecter in array {
            if lecter.containsEmoji {
                if sentenceInProgress != "" {
                    result.append(sentenceInProgress)
                }
                result.append("\(lecter)")
                sentenceInProgress = ""
            }
            else {
                sentenceInProgress = sentenceInProgress + "\(lecter)"
            }
        }
        if sentenceInProgress != "" {
            result.append(sentenceInProgress)
        }
        return result
    }
    ///Es let str = "👨‍👨‍👧‍👧pippo👨‍👨‍👧‍👧 sta pippando 😍😍" print: ["", "👨‍👨‍👧‍👧", "pippo", "👨‍👨‍👧‍👧", " sta pippando ", "😍😍"] //unisce le emoji
    var splitEmojiAndSentence: [String] {
        let array = Array(self)
        var result:[String] = []
        var sentenceInProgress: String = ""
        var emojiInProgress: String = ""
        var lastAppendIsEmoji:Bool = false
        for lecter in array {
            if lecter.containsEmoji {
                if sentenceInProgress != "" {
                    result.append(sentenceInProgress)
                }
                emojiInProgress = emojiInProgress + "\(lecter)"
                sentenceInProgress = ""
                lastAppendIsEmoji = true
            }
            else {
                if emojiInProgress != "" {
                    result.append(emojiInProgress)
                }
                sentenceInProgress = sentenceInProgress + "\(lecter)"
                emojiInProgress = ""
                lastAppendIsEmoji = false
            }
        }
        if lastAppendIsEmoji == true {
            if emojiInProgress != "" {
                result.append(emojiInProgress)
            }
        }
        else {
            if sentenceInProgress != "" {
                result.append(sentenceInProgress)
            }
        }
        return result
    }
}

///EX: let sentence = "😃 hello world 🙃"
///    sentence.emojis // ["😃", "🙃"]
public extension String {
    var charEmojis:[Character] {
        let emojiRanges = [0x1F601...0x1F64F, 0x2702...0x27B0]
        let emojiSet = Set(emojiRanges.joined())
        return self.filter { emojiSet.contains($0.unicodeScalarCodePoint) }
    }
    var charWithOutEmojis:[Character] {
        let emojiRanges = [0x1F601...0x1F64F, 0x2702...0x27B0]
        let emojiSet = Set(emojiRanges.joined())
        return self.filter { !emojiSet.contains($0.unicodeScalarCodePoint) }
    }
    var emojis:String {
        let emojiRanges = [0x1F600...0x1F64F, 0x1F300...0x1F5FF, 0x1F680...0x1F6FF, 0x2600...0x26FF,0x2700...0x27BF,0xFE00...0xFE0F,0x1F900...0x1F9FF,65024...65039,8400...8447] //[0x1F601...0x1F64F, 0x2702...0x27B0]
        let emojiSet = Set(emojiRanges.joined())
        return self.filter { emojiSet.contains($0.unicodeScalarCodePoint) }
        
        //return "\(self.charEmojis)"
    }
    var withOutEmojis:String {
        let emojiRanges = [0x1F600...0x1F64F, 0x1F300...0x1F5FF, 0x1F680...0x1F6FF, 0x2600...0x26FF,0x2700...0x27BF,0xFE00...0xFE0F,0x1F900...0x1F9FF,65024...65039,8400...8447] //[0x1F601...0x1F64F, 0x2702...0x27B0]
        let emojiSet = Set(emojiRanges.joined())
        return self.filter { !emojiSet.contains($0.unicodeScalarCodePoint) }
        //return "\(self.charWithOutEmojis)"
    }
}
public extension String {
    
    
    var containsEmoji: Bool {
        
        return unicodeScalars.contains { $0.isEmoji }
    }
    
    var containsOnlyEmoji: Bool {
        
        return !isEmpty
            && !unicodeScalars.contains(where: {
                !$0.isEmoji
                    && !$0.isZeroWidthJoiner
            })
    }
    
    // The next tricks are mostly to demonstrate how tricky it can be to determine emoji's
    // If anyone has suggestions how to improve this, please let me know
    var emojiString: String {
        
        return emojiScalars.map { String($0) }.reduce("", +)
    }
    
    
    
    fileprivate var emojiScalars: [UnicodeScalar] {
        
        var chars: [UnicodeScalar] = []
        var previous: UnicodeScalar?
        for cur in unicodeScalars {
            
            if let previous = previous, previous.isZeroWidthJoiner && cur.isEmoji {
                chars.append(previous)
                chars.append(cur)
                
            } else if cur.isEmoji {
                chars.append(cur)
            }
            
            previous = cur
        }
        
        return chars
    }
}

///CAPIRE LA DIMENSIONE DI UN TESTO
public extension String {
    // Removed stringWidth and stringHeight properties, moved to @MainActor extension below
}

//18-01-2020 mi sembra uguale a 15-4-2020
public extension StringProtocol  {
    func substring(from start: Self, to end: Self? = nil, options: String.CompareOptions = []) -> SubSequence? {
        guard let lower = range(of: start, options: options)?.upperBound else { return nil }
        guard let end = end else { return self[lower...] }
        guard let upper = self[lower...].range(of: end, options: options)?.lowerBound else { return nil }
        return self[lower..<upper]
    }
}
//15-4-2020
public extension String {
    ///divide il primo risultato che trova string tra due caratteri - Returns an empty string when there is no path.
    func slice(from: String, to: String) -> String? {

        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                String(self[substringFrom..<substringTo])
            }
        }
    }
}
///Prende una data da una stringa qualsiasi
///print("2018-11-04T23:59:00+00:00".detectDate ?? "") // 2018-11-04 10:00:00 +0000
/* ha un bug con date tipo 3/8 8/3 inverte mese giorno
extension String {
    var detectDate: Date? {
        let detector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.date.rawValue)
        let matches = detector?.matches(in: self, options: [], range: NSMakeRange(0, self.utf16.count))
        return matches?.first?.date
    }
}*/
///Prende una data da una stringa qualsiasi
///print("2018-11-04T23:59:00+00:00".detectDate ?? "") // 2018-11-04 10:00:00 +0000
/// Attenzione a ha un bug con date tipo 3/8 8/3 inverte mese giorno
public extension String {
    var nsString: NSString { return self as NSString }
    var length: Int { return nsString.length }
    var nsRange: NSRange { return NSRange(location: 0, length: length) }
    var detectDates: [Date]? {
        return try? NSDataDetector(types: NSTextCheckingResult.CheckingType.date.rawValue)
                .matches(in: self, range: nsRange)
            .compactMap{$0.date}
    }
}

public extension Collection where Iterator.Element == String {
    var dates: [Date] {
        return compactMap{$0.detectDates}.flatMap{$0}
    }
}

/// Properties requiring UIKit must be accessed on the main actor (main thread)
@MainActor
public extension String {
    var stringWidth: CGFloat {
        let constraintRect = CGSize(width: UIScreen.main.bounds.width / 1.6, height: .greatestFiniteMagnitude)
        let boundingBox = self.trimmingCharacters(in: .whitespacesAndNewlines).boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)], context: nil)
        return boundingBox.width + 20
    }
    var stringHeight: CGFloat {
        let constraintRect = CGSize(width: UIScreen.main.bounds.width, height: .greatestFiniteMagnitude)
        let boundingBox = self.trimmingCharacters(in: .whitespacesAndNewlines).boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)], context: nil)
        return boundingBox.height + 20
    }
}
