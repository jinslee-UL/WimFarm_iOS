//
//  CategoryModel.swift
//  WimFarm
//
//  Created by ulalalab on 2023/01/31.
//

import Foundation

struct Category : Codable {
    
    var groups_group, groups_company_idx, groups_factory_idx, groups_parent_group, groups_depth: Int?
    var groups_comment, groups_extend, groups_image: String?
}

//struct Category : Codable {
//    var groupsGroup: Int?
//    var groupsCompanyIdx: Int?
//    var groupsFactoryIdx: Int?
//    var groupsParentGroup: Int?
//    var groupsDepth: Int?
//
//    var groupsComment: String?
//    var groupsImage: String?
//
//    // 어디 그룹에 소속된적이 있는지
//    var groupFlag: Bool? = false
//
//    var groupsExtend: String?
//    var groupExtend : GroupsExtend?
//
//    var categoryList: [Category]?
//
//    var deviceList: [Device]?
//
//    // 가공한 정보
//    var caution: Int = 0
//    var warning: Int = 0
//    var dangers: Int = 0
//    var limit: Int = 0
//
//    var categoryOnoff: Int = 0
//    var deviceOn: Int = 0
//    var deviceOff: Int = 0
//
//    // 설비 가동률 정보
//    var oper: Oper?
//
//
//    enum CodingKeys: String, CodingKey {
//        case groupsGroup = "group_group"
//        case groupsCompanyIdx = "group_company_idx"
//        case groupsFactoryIdx = "group_factory_idx"
//        case groupsParentGroup = "group_parent_group"
//        case groupsDepth = "group_depth"
//
//        case groupsComment = "group_comment"
//        case groupsImage = "group_image"
//
//        case groupsExtend = "group_extend"
//    }
//
////    private fun resetData() {
////        categoryOnoff = 0; deviceOn = 0; deviceOff = 0
////
////        caution = 0; warning = 0
////        dangers = 0; limit = 0
////    }
////
////    fun combineData() {
////        resetData() // 데이터 초기화 하고
////        deviceList.forEach { device ->
////            if (device.deviceOnoff == 1) categoryOnoff = 1 // 설비 가동여부
////            if (device.deviceOnoff == 1) deviceOn += 1 // 디바이스 가동여부 증가
////            else deviceOff += 1 // 디바이스 가동여부 증가
////
////            dangers += device.dangers
////            warning += device.warning
////            caution += device.caution
////            limit += device.limit
////        }
////    }
//}
