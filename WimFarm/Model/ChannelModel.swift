//
//  ChannelModel.swift
//  WimFarm
//
//  Created by ulalalab on 2023/01/31.
//

import Foundation

struct Channel: Codable {
    var channel: [String: [String: [Int]?]]?
}
//struct ChannelResponse: Codable {
//    var data: Channel?
//    var code: String?
//}
//
//struct Channel: Codable {
//    var seq:Int?
//    var channel:String?
//    var name:String?
//
//    var correction:String?
//
//    var filter: String? //Any
//    var filterValue: Int?
//    var filterVo: Filter?
//
////    @SerializedName("alarm_input")
//    var alarmInput: [AlarmInput]?
//
//    var alarmInputMap:[String: AlarmInput]?
//
//    /** 디바이스에서 찾아 넣는 값 */
//    var device: Device?
//
//    /** 패킷에서 받아서 넣어주는 값 */
//    var value:Float?
//
//    var valueOld:Float?
//
//    var onoff:Int? = 0
//    var clientPacketTime:Date?
//
//    var caution:Int = 0
//    var warning:Int = 0
//    var dangers:Int = 0
//    var limit:Int = 0
//}
