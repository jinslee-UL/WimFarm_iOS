//
//  PacketModel.swift
//  WimFarm
//
//  Created by ulalalab on 2023/01/31.
//

import Foundation

/**
 * Packet으로 호출한 경우
 */
struct PacketResponse: Codable {
    var data: [String: PacketData]?
    var code: String?
}

struct PacketData: Codable {
    var device: String?
    var onoff: Int?
    var packet_time: String?

    var packet: Packet?
//    var packet: [String: String?]? // Any
//    var packetVo: Packet?

    /*
    var caution : Int?
    var warning : Int?
    var dangers : Int?
    var limit : Int?
    */
}

struct Packet : Codable {
    var client_packet_time: String?
    var reference: String?
    var channel: [String: Float?]?
    var hash: [String: Float?]?
}
