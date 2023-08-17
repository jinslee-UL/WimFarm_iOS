//
//  StringExt.swift
//  WimFarm
//
//  Created by ulalalab on 2022/02/11.
//

import UIKit

public extension String {
    
    // String Trim
    var stringTrim: String{
       return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    // Return String chracters count
    var length: Int {
        return self.count
    }
    
    // String reversed
    func reversed() -> String {
        return self.reversed().map { String($0) }.joined(separator: "")
    }
    
    // String localized
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    // String localized with comment
    func localizedWithComment(comment: String) -> String {
        return NSLocalizedString(self, comment:comment)
    }
    
    // E-mail address validation
    func validateEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        
        let predicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return predicate.evaluate(with: self)
    }
    
    // Password validation
    func validatePassword() -> Bool {
        let passwordRegEx = "^(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,16}$"
        
        let predicate = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return predicate.evaluate(with: self)
    }
    
    var html2Attributed: NSAttributedString? {
        do {
            guard let data = data(using: String.Encoding.utf8) else {
                return nil
            }
            return try NSAttributedString(data: data,
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            print("error: ", error)
            return nil
        }
    }
    
    func utf8DecodedString()-> String {
        let data = self.data(using: .utf8)
        let message = String(data: data!, encoding: .nonLossyASCII) ?? ""
        return message
    }
    
    func utf8EncodedString()-> String {
        let messageData = self.data(using: .nonLossyASCII)
        let text = String(data: messageData!, encoding: .utf8) ?? ""
        return text
    }
    
    // String split return array
    func arrayBySplit(splitter: String? = nil) -> [String] {
        if let s = splitter {
            return self.components(separatedBy: s)
        } else {
            return self.components(separatedBy: NSCharacterSet.whitespacesAndNewlines)
        }
    }
    
    var isBlank: Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    func compareVersion(_ version: String?) -> ComparisonResult {
        let version1 = components(separatedBy: ".")
        let version2 = version?.components(separatedBy: ".")
        for i in 0..<version1.count {
            var value1 = 0
            var value2 = 0
            if i < version1.count {
                value1 = Int(version1[i]) ?? 0
            }
            if i < (version2?.count ?? 0) {
                value2 = Int(version2?[i] ?? "") ?? 0
            }
            if value1 == value2 {
                continue
            } else {
                if value1 > value2 {
                    return .orderedDescending
                } else {
                    return .orderedAscending
                }
            }
        }
        return .orderedSame
    }
    
    func tempFmt(temp: Double) -> String {
        return String(format: "%.0º", temp)
    }
    
    func day(day: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: day)
    }
    
    func date(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd"
        return dateFormatter.string(from: date)
    }
    
    func yyyyDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy. MM. dd"
        return dateFormatter.string(from: date)
    }
    
    func timeFmt(time: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:00 a"
        return dateFormatter.string(from: time)
    }
    
    func timeFmt24(time: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:00"
        return dateFormatter.string(from: time)
    }
}

extension Optional where Wrapped == String {
    var isBlank: Bool {
        if let unwrapped = self {
            return unwrapped.isBlank
        } else {
            return true
        }
    }
}


extension Int {
    var withComma: String {
        let decimalFormatter = NumberFormatter()
        decimalFormatter.numberStyle = NumberFormatter.Style.decimal
        decimalFormatter.groupingSeparator = ","
        decimalFormatter.groupingSize = 3
        
        return decimalFormatter.string(from: self as NSNumber)!
    }
}

extension String {
    func substring(from: Int, to: Int) -> String {
        let start = index(startIndex, offsetBy: from)
        let end = index(start, offsetBy: to - from)
        return String(self[start ..< end])
    }
    
    func substring(range: NSRange) -> String {
        return substring(from: range.lowerBound, to: range.upperBound)
    }
    
    func decode(data: String?) -> String? {
        let decodedData = Data(base64Encoded: data ?? "", options: [])
        var decodedString: String? = nil
        if let decodedData = decodedData {
            decodedString = String(data: decodedData, encoding: .utf8)
        }

        return decodedString
    }
    
    func encodeUrl() -> String?
    {
        return self.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
    }
    
    func decodeUrl() -> String?
    {
        return self.removingPercentEncoding
    }
    
    public enum DateFormatType {
            
            /// The ISO8601 formatted year "yyyy" i.e. 1997
            case isoYear
            
            /// The ISO8601 formatted year and month "yyyy-MM" i.e. 1997-07
            case isoYearMonth
            
            /// The ISO8601 formatted date "yyyy-MM-dd" i.e. 1997-07-16
            case isoDate
            
            /// The ISO8601 formatted date and time "yyyy-MM-dd'T'HH:mmZ" i.e. 1997-07-16T19:20+01:00
            case isoDateTime
            
            /// The ISO8601 formatted date, time and sec "yyyy-MM-dd'T'HH:mm:ssZ" i.e. 1997-07-16T19:20:30+01:00
            case isoDateTimeSec
            
            /// The ISO8601 formatted date, time and millisec "yyyy-MM-dd'T'HH:mm:ss.SSSZ" i.e. 1997-07-16T19:20:30.45+01:00
            case isoDateTimeMilliSec
            
            /// The dotNet formatted date "/Date(%d%d)/" i.e. "/Date(1268123281843)/"
            case dotNet
            
            /// The RSS formatted date "EEE, d MMM yyyy HH:mm:ss ZZZ" i.e. "Fri, 09 Sep 2011 15:26:08 +0200"
            case rss
            
            /// The Alternative RSS formatted date "d MMM yyyy HH:mm:ss ZZZ" i.e. "09 Sep 2011 15:26:08 +0200"
            case altRSS
            
            /// The http header formatted date "EEE, dd MM yyyy HH:mm:ss ZZZ" i.e. "Tue, 15 Nov 1994 12:45:26 GMT"
            case httpHeader
            
            /// A generic standard format date i.e. "EEE MMM dd HH:mm:ss Z yyyy"
            case standard
            
            /// A custom date format string
            case custom(String)
            
            /// The local formatted date and time "yyyy-MM-dd HH:mm:ss" i.e. 1997-07-16 19:20:00
            case localDateTimeSec
            
            /// The local formatted date  "yyyy-MM-dd" i.e. 1997-07-16
            case localDate
            
            /// The local formatted  time "hh:mm a" i.e. 07:20 am
            case localTimeWithNoon
            
            /// The local formatted date and time "yyyyMMddHHmmss" i.e. 19970716192000
            case localPhotoSave
            
            case birthDateFormatOne
            
            case birthDateFormatTwo
            
            ///
            case messageRTetriveFormat
            
            ///
            case emailTimePreview
        
            // 그래프를 위한 날짜+시+분
            case localGraphDateTime
            
            var stringFormat:String {
              switch self {
              //handle iso Time
              case .birthDateFormatOne: return "dd/MM/YYYY"
              case .birthDateFormatTwo: return "dd-MM-YYYY"
              case .isoYear: return "yyyy"
              case .isoYearMonth: return "yyyy-MM"
              case .isoDate: return "yyyy-MM-dd"
              case .isoDateTime: return "yyyy-MM-dd'T'HH:mmZ"
              case .isoDateTimeSec: return "yyyy-MM-dd'T'HH:mm:ssZ"
              case .isoDateTimeMilliSec: return "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
              case .dotNet: return "/Date(%d%f)/"
              case .rss: return "EEE, d MMM yyyy HH:mm:ss ZZZ"
              case .altRSS: return "d MMM yyyy HH:mm:ss ZZZ"
              case .httpHeader: return "EEE, dd MM yyyy HH:mm:ss ZZZ"
              case .standard: return "EEE MMM dd HH:mm:ss Z yyyy"
              case .custom(let customFormat): return customFormat
                
              //handle local Time
              case .localDateTimeSec: return "yyyy-MM-dd HH:mm:ss"
              case .localTimeWithNoon: return "hh:mm a"
              case .localDate: return "yyyy-MM-dd"
              case .localPhotoSave: return "yyyyMMddHHmmss"
              case .messageRTetriveFormat: return "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
              case .emailTimePreview: return "dd MMM yyyy, h:mm a"
              case .localGraphDateTime: return "dd HH:mm"
              }
            }
     }
            
     func toDate(_ format: DateFormatType = .isoDate) -> Date?{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = format.stringFormat
            let date = dateFormatter.date(from: self)
            return date
      }
    
    func yesterDay() -> String {
        var dayComponent = DateComponents()
        dayComponent.day = -1
        let calendar = Calendar.current
        let nextDay =  calendar.date(byAdding: dayComponent, to: Date())!
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = "MMMM d, yyyy"
        return formatter.string(from: nextDay) //Output is "March 6, 2020
    }
}

public extension Optional {
    
    // Check NotEmpty
    var isNotEmpty: Bool {
        guard let str = self as? String else {
            return false
        }
        return !str.isEmpty
    }
    
    // Check NotEmpty return String
    var isNotEmptyString: String {
        guard let str = self as? String else {
            return ""
        }
        return str
    }
}

extension Data {
    struct HexEncodingOptions: OptionSet {
        let rawValue: Int
        static let upperCase = HexEncodingOptions(rawValue: 1 << 0)
    }

    func hexEncodedString(options: HexEncodingOptions = []) -> String {
        let format = options.contains(.upperCase) ? "%02hhX" : "%02hhx"
        return self.map { String(format: format, $0) }.joined()
    }
}

func convertToDictionary(text: String) -> [String: Any]? {
    if let data = text.data(using: .utf8) {
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        } catch {
            print(error.localizedDescription)
        }
    }
    return nil
}

extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}

extension Array where Element: Hashable {
    func removeDuplicates() -> [Element] {
        var addedDidct = [Element: Bool]()
        return filter ({ addedDidct.updateValue(true, forKey: $0) == nil})
    }
}

class Time {
    static let defaultDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter
    }()

    static let dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter
    }()
    
    static let dayNumberFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        return formatter
    }()

    static let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh a"
        return formatter
    }()
}
