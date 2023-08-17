//
//  GroupExtentModel.swift
//  WimFarm
//
//  Created by ulalalab on 2023/01/31.
//

import Foundation

struct GroupsExtend : Codable {
    var goal: String?
    var operation: Operation?
    var diffSecond: Double = 86400
}

struct Operation : Codable {
    var second: String?
    var reference: Reference?
}

struct Reference : Codable {
    var start: String?
    var end: String?
    var none: [None]?
}

struct None : Codable {
    var comment: String?
    var minute: String?
}

struct Oper : Codable {
    var tCount : Int = 0
    var tHap : Float = 0.0
    var otCount : Int = 0
    var otHap : Float = 0.0

    var packetTime: String?

    var idx: Int = 0
    var operTime: Double = 0
    var percent: Float = 0.0

}
