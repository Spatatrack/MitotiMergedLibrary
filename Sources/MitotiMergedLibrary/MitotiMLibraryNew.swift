import Foundation

//https://stackoverflow.com/questions/40436895/how-to-read-plist-without-using-nsdictionary-in-swift

public func helloFromVersion1() -> String {
    return "Hello from MitotiMLibraryNew 1.0.0" //ciao
}
//pippo


public class pippoClass {
    var t = 0
}
//LANGUAGE
public struct PippoStruct {
//    public init() {
// pippo
//    }
    
    public static let staticVeriable: String = NSLocalizedString("RATE_REMEMBER_BUTTON", tableName: "MTMLocalizable", bundle: .module, comment: "")
  
}

public struct MitotiMLibraryNew {
    public private(set) var text = "Hello, World!"

    public init() {
    }
    
    public static let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as! String
    
    public static let idApple: String = {
        return getStringMitotimPlist(key: Keys.idApple)
    }()
    public static let numToOpenReview: Int = {
        return getNumberMitotimPlist(key: Keys.numToOpenReview)
    }()
    public static let recurrenceOpenReview: Int = {
        return getNumberMitotimPlist(key: Keys.recurrenceOpenReview)
    }()
    public static let mailTo: String = {
        return getStringMitotimPlist(key: Keys.mailTo)
    }()
    public static let messageBody: String = {
        return getStringMitotimPlist(key: Keys.messageBody)
    }()
    
    private struct Keys {
        static let idApple = "idApple"
        static let numToOpenReview = "numToOpenReview"
        static let recurrenceOpenReview =  "recurrenceOpenReview"
        static let mailTo = "mailTo"
        static let messageBody = "messageBody"
    }
    private static func getValueFromMitotimPlist(key: String) -> Any? {
        if let url = Bundle.main.url(forResource:"MitotiM", withExtension: "plist") {
            do {
                let data = try Data(contentsOf:url)
                let swiftDictionary = try PropertyListSerialization.propertyList(from: data, format: nil) as! [String:Any]
                if let value = swiftDictionary[key] {
                    return value
                }
            }
            catch {
                print("getValueFromMitotimPlist: \(error)")
                return nil
            }
        }
        fatalError("non hai messo il file MitotiM.plist")
    }
    private static func getStringMitotimPlist(key: String) -> String {
        if let value = getValueFromMitotimPlist(key: key) as? String {
            return value
        }
        else {
            return "no string found"
        }
    }
    private static func getNumberMitotimPlist(key: String) -> Int {
        if let value = getValueFromMitotimPlist(key: key) as? Int {
            return value
        }
        else {
            return 10
        }
    }
}
