//
//  Date+Extension.swift
//  WhatsAppMovieAct
//
//  Created by Simone Pistecchia on 28/10/17.
//  Copyright © 2017 Simone Pistecchia. All rights reserved.
//

import Foundation

public extension Date {
    
    ///Cambia il tempo di una data (SWIFT 4 in poi Calendar.current.date(bySettingHour: 9, minute: 30, second: 0, of: Date())!
    mutating func changeTimeTo(hour:Int, minute:Int, second:Int) {
        let dataVera = self
        var gregorian = Calendar(identifier: .gregorian)
        let now = dataVera
        var components = gregorian.dateComponents([.year, .month, .day, .hour, .minute, .second], from: now)
        //gregorian.locale = Locale(identifier: "en_USPOSIX") //Ci deve stare raccomandato da apple
        gregorian.timeZone = TimeZone(identifier: "UTC")!//.current
        // Change the time to 9:30:00 in your locale
        components.hour = hour
        components.minute = minute
        components.second = second
        let dateG = gregorian.date(from: components)!
        self = dateG
    }
    static func changeTimeTo(date:Date,hour:Int, minute:Int, second:Int) -> Date{
        let dataVera = date
        var gregorian = Calendar(identifier: .gregorian)
        let now = dataVera
        var components = gregorian.dateComponents([.year, .month, .day, .hour, .minute, .second], from: now)
        //gregorian.locale = Locale(identifier: "en_USPOSIX") //Ci deve stare raccomandato da apple
        gregorian.timeZone = TimeZone(identifier: "UTC")!//.current
        // Change the time to 9:30:00 in your locale
        components.hour = hour
        components.minute = minute
        components.second = second
        let dateG = gregorian.date(from: components)!
        return dateG
    }
    
}
public extension Date {
    
    func getMonthName() -> String {
        let df = DateFormatter()
        df.setLocalizedDateFormatFromTemplate("MMM")
        return df.string(from: self)
    }
    
    
        
    static func getDateFromStringen_USPOSIX(stringDate:String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.locale = Locale(identifier: "en_USPOSIX") //Ci deve stare raccomandato da apple
        //dateFormatter.locale = Locale.current
        //dateFormatter.timeZone = TimeZone.current //TimeZone(identifier: "UTC")!//TimeZone.current
        dateFormatter.timeZone = TimeZone(identifier: "UTC")!//TimeZone.current
        let date = dateFormatter.date(from: stringDate)
        return date
    }
    
    static func getDateFromString(stringDate:String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        //dateFormatter.locale = Locale(identifier: "en_USPOSIX") //Ci deve stare raccomandato da apple
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone.current //TimeZone(identifier: "UTC")!//TimeZone.current
        let date = dateFormatter.date(from: stringDate)
        return date
    }
    ///Formato data short es 01/02/17 oppure 01/02/2017 va bene uguale e restituisce la data con ora minuti e secondi cambiati
    static func getDateFrom (date:String, hour:Int, minute:Int, second:Int) -> Date? {
        
        guard let dataVera = getDateFromString(stringDate: date) else {return nil}
        
        var gregorian = Calendar(identifier: .gregorian)
        let now = dataVera
        var components = gregorian.dateComponents([.year, .month, .day, .hour, .minute, .second], from: now)
        gregorian.timeZone = .current//TimeZone(identifier: "UTC")!//.current
        // Change the time to 9:30:00 in your locale
        components.hour = hour
        components.minute = minute
        components.second = second
        
        let dateG = gregorian.date(from: components)!
        return dateG
        //return Calendar.current.date(bySettingHour: hour, minute: minute, second: second, of: dataVera)
    }
}


public extension TimeZone {
    static let gmt = TimeZone(secondsFromGMT: 0)!
}
public extension Formatter {
    static let date = DateFormatter()
}
public extension Date {
    func localizedDescription(dateStyle: DateFormatter.Style = .medium,
                              timeStyle: DateFormatter.Style = .medium,
                           in timeZone : TimeZone = .current,
                              locale   : Locale = .current) -> String {
        Formatter.date.locale = locale
        Formatter.date.timeZone = timeZone
        Formatter.date.dateStyle = dateStyle
        Formatter.date.timeStyle = timeStyle
        return Formatter.date.string(from: self)
    }
    var localizedDescription: String { localizedDescription() }
}

/// 27-02-2023 yesterday tomorrow
public extension Date {
    static var yesterday: Date { return Date().dayBefore }
    static var tomorrow:  Date { return Date().dayAfter }
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    var isLastDayOfMonth: Bool {
        return dayAfter.month != month
    }
}
/// 26-05-2023 yesterday tomorrow
public extension Date {
    
    var year: Int {
        return Calendar.current.component(.year, from: self)
    }

    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }

    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth())!
    }

    func isSameDay(as otherDate: Date) -> Bool {
        return Calendar.current.isDate(self, inSameDayAs: otherDate)
    }
}
