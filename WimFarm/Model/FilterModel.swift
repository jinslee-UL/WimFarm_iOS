//
//  FilterModel.swift
//  WimFarm
//
//  Created by ulalalab on 2023/01/31.
//

import Foundation

struct Filter : Codable, Identifiable {
    var id: Int {
        self.sensor_idx!
    }
    
    var sensor_idx, sensor_parent, sensor_depth: Int?
    var sensor_name, sensor_formula, sensor_unit, sensor_icon, sensor_adjust, sensor_comment: String?
}

//struct Filter : Codable {
//    var sensorIdx : Int?
//    var sensorParent : Int?
////    var sensorParentName : String?
//    var sensorDepth : Int?
//
//    var sensorName : String?
//    var sensorUnit : String?
//    var sensorIcon : String?
//
//    var sensorComment : String?
//
//    enum CodingKeys: String, CodingKey {
//
//        case sensorIdx = "sensor_idx"
//        case sensorParent = "sensor_parent"
////        case sensorParentName = "sensor_name"
//        case sensorDepth = "sensor_depth"
//
//        case sensorName = "sensor_name"
//        case sensorUnit = "sensor_unit"
//        case sensorIcon = "sensor_icon"
//
//        case sensorComment = "sensor_comment"
//    }
//}
