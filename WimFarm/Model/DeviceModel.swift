//
//  DeviceModel.swift
//  WimFarm
//
//  Created by ulalalab on 2023/01/31.
//

import Foundation

struct Device : Codable, Identifiable {
    var id: String? {
        self.device_code
    }
    
    var device_idx, device_company_idx, device_factory_idx, device_works_idx, device_onoff: Int?
    var device_code, device_config, device_extension, device_comment: String?
    var deviceConfig: [DeviceConfig]?
}

struct DeviceConfig : Codable, Identifiable, Hashable {
    var id: String? {
        self.channel
    }
//    var channel, filter, name, firstSensor, secondSensor, icon: String?
    var cateName, deviceName, channel, filter, name, firstSensor, secondSensor, icon: String?
    var checked: Bool?
//    var channel, filter, name, firstSensor, secondSensor: String?
    
//    enum CodingKeys: String, CaseIterable, CodingKey {
//        case channel, filter, name, firstSensor, secondSensor
//    }
//
//    public init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//
//        if let strfilter = try container.decode(String?.self, forKey: .filter)  {
//            filter = strfilter
//        }
//        else {
//            let intFilter = try container.decode(Int.self, forKey: .filter)
//            filter = String(intFilter)
//        }
//
//        channel = try container.decode(String.self, forKey: .channel)
//        name = try container.decode(String.self, forKey: .name)
//        firstSensor = try container.decode(String.self, forKey: .firstSensor)
//        secondSensor = try container.decode(String.self, forKey: .secondSensor)
//    }
}

struct DeviceExtension : Codable, Hashable {
    var display_check_seconds: Int?
}

//extension DeviceConfig: Decodable {
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        gourd let strFilter = String(try values.decode(<#T##type: Bool.Type##Bool.Type#>, forKey: <#T##KeyedDecodingContainer<CodingKeys>.Key#>))
//    }
//}
