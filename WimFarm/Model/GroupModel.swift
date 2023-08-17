//
//  GroupModel.swift
//  WimFarm
//
//  Created by ulalalab on 2023/01/31.
//

import Foundation

struct Group: Codable {
    var group_group, user_idx, group_type, group_parent_group, group_depth: Int?
    var group_comment: String?
}

//struct Group : Codable {
//    var groupGroup: Int?
//    var userIdx: Int?
//    var groupType: Int?
//    var groupParentGroup: Int?
//    var groupDepth: Int?
//    var groupComment: String?
//
//    // 트리구조 만들때 사용
//    var groupTree: String = ""
//
//    var groupList: [Group]?
//    var categoryList: [Category]?
//
//    // 가공한 정보
//    var deviceOn: Int = 0
//    var deviceOff: Int = 0
//
//    var caution: Int = 0
//    var warning: Int = 0
//    var dangers: Int = 0
//    var limit: Int = 0
//
//
//    enum CodingKeys: String, CodingKey {
//        case groupGroup = "group_group"
//        case userIdx = "group_idx"
//        case groupType = "group_rype"
//        case groupParentGroup = "group_parent_group"
//        case groupDepth = "group_depth"
//        case groupComment = "group_comment"
//    }

//    private fun resetData() {
//        deviceOn = 0; deviceOff = 0
//
//        caution = 0; warning = 0
//        dangers = 0; limit = 0
//    }
//
//    fun combineData() {
//        resetData() // 데이터 초기화 하고
//        categoryList.forEach { category ->
//            deviceOn += category.deviceOn // 디바이스 가동여부 증가
//            deviceOff += category.deviceOff // 디바이스 가동여부 증가
//
//            dangers += category.dangers
//            warning += category.warning
//            caution += category.caution
//            limit += category.limit
//        }
//    }
//}
