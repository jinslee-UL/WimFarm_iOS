//
//  TrendModel.swift
//  WimFarm
//
//  Created by ulalalab on 2023/01/31.
//

import Foundation
import Charts

struct TrendRes: Codable {
    var data: TrendModel?
    var code: String?
}

struct TrendModel: Codable {
    // api로 받은 트랜드 데이터
    var search: [[String:[TrendItem]?]]?
    // 위 데이터의 파일명
    var file: String?
    // 받아온 데이터 파싱해서 넣어줄 부분.
    var list: [Trend]?
    // 받아온 데이터 파싱해서 넣어줄 부분.
//    val values = [Entry]?
    // 받아온 데이터 파싱해서 넣어줄 부분.
//    val alarms = [Entry]?


    // 다중 그래프를 위해서
//    var multiList: [String: [Trend]]?
//    var multiValues: [String: [Entry]]?
    var multiList: [MultiList]?
    var multiValues: [MultiValue]?
    //Entry 는 차트!!
}

struct Trend : Codable {
    var time : Date?
    var value : Float?
    
    init(time: Date, value: Float) {
        self.time = time
        self.value = value
    }
}

struct Entry : Codable {
    var x : Float?
    var value : Float?
    
    init(x: Float, value: Float) {
        self.x = x
        self.value = value
    }
}

struct MultiList :  Codable {
    var id: String {
        self.df!
    }
    
    var df : String?
    var trend : [Trend]?
    
    init(df: String, trend: [Trend]) {
        self.df = df
        self.trend = trend
    }
}

struct MultiValue :  Codable {
    var id: String {
        self.df!
    }
    
    var df : String?
    var entry : [Entry]?
    
    init(df: String, entry: [Entry]) {
        self.df = df
        self.entry = entry
    }
}


struct EntryTimes : Codable {
    var time : Date?
    var value : Double?
    
    init(time: Date, value: Double) {
        self.time = time
        self.value = value
    }
}

struct ChartDataEntries {
    var df : String?
    var days : [String]?
    var time : [EntryTimes]?
    var cdEntry : [ChartDataEntry]?
    
    init(df: String, days: [String], time: [EntryTimes],cdEntry: [ChartDataEntry]) {
        self.df = df
        self.days = days
        self.time = time
        self.cdEntry = cdEntry
    }
}

struct TrendItem : Codable, Identifiable {
    var id: String {
        self.time!
    }
    
    var time : String?
    var maxCh : [String:Float] = [:]
//    var maxCh : Float?
    
    enum CodingKeys: String, CaseIterable, CodingKey {
            case time
        }
        
        struct CustomCodingKeys: CodingKey {
            var stringValue: String
            init?(stringValue: String) {
                self.stringValue = stringValue
            }
            
            var intValue: Int? { return nil }
            init?(intValue: Int) { return nil }
            
            var floatValue: Float? { return nil }
            init?(floatValue: Float) { return nil }
        }
        
        public init(from decoder: Decoder) throws {
            let defaultContainer = try decoder.container(keyedBy: CodingKeys.self)
            let extraContainer = try decoder.container(keyedBy: CustomCodingKeys.self)
            
            // 내가 아는 키
            self.time = try defaultContainer.decode(String.self, forKey: .time)
            
            for key in extraContainer.allKeys {
                if CodingKeys.allCases.filter({ $0.rawValue == key.stringValue}).isEmpty {
                // 내가 모르는 키가 나오면
//                    let value =  try extraContainer.decode(Float.self, forKey: CustomCodingKeys(stringValue: key.stringValue)!)
                    do {
                        let value = try extraContainer.decode(Float.self, forKey: CustomCodingKeys(stringValue: key.stringValue)!)
                        
                        self.maxCh[key.stringValue] = value
                    } catch {
                        print(error)
                    }
                }
            }
        }
}


struct TrendListItem : Codable {
    var groupComment: String?
    var deviceCode: String?
    var channel: String?
    var sensorName: String?
    var sensorIdx: Int?
    var sensorIcon: String?
    var mode: Bool? = false
    var select: Bool? = false
    var sensorCategory: String?
}

struct TrendChannelItem: Codable {
    var sensorIcon: String?
    var select: Bool? = false
}

struct TrendLegendItem: Codable {
    var legendTitle: String?
    var legendColor: String?
}
