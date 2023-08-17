//
//  LastModel.swift
//  WimFarm
//
//  Created by ulalalab on 2023/01/31.
//

import Foundation

struct LastResponse: Codable {
    var data: LastData?
    var code: String?
}

struct LastData: Codable {
    var packetTime: String?
    var packet: String?

    var onoff: Int?

    var last: [String: String?]? // Any
    var lastVo: Packet?

    var caution : Int?
    var warning : Int?
    var dangers : Int?
    var limit : Int?
}
