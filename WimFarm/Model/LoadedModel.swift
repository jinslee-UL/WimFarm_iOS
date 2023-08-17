//
//  LoadedModel.swift
//  WimFarm
//
//  Created by ulalalab on 2023/01/31.
//

import Foundation

struct LoadedResponse : Codable {
    var data: LoadedModel?
    var code: String?
    
}

struct LoadedModel : Codable {
    /** 참조용 데이터 */
    var filters: [Filter]?
//    var filterMap: [Int: Filter]?
//    /** 구성 데이터 */
    var user: User?
    var group: [Group]?
    var relational: [Relational]?
    var category: [Category]?
    var devices: [Device]?
    var channels: [String: [String: [Int]?]]?
    var filterDic : [Int : Filter]?
//    var channels: Channel?
//    /** 구성 가공 데이터 */
//    var groupMap: [Int: Group]?
//    var deviceMap: [String: Device]?
//    var categoryMap: [Int: Category]?
//    /** 추가 가공 데이터 */
//    // 뎁스가 적용된 그룹리스트
//    var groupList: [Group]?
//    // 디바이스 아이디와 채널로 카테고리 아이디 찾기
//    var categoryFinder: [String: String]?
//    // 추세분석 페이지를 위해서 새로 생성
//    var trendList: [TrendListItem]?
//
//    // 날씨를 위한 공장 정보
    var companys : [Company]?
//
//    // 날씨를 위한 공장 정보
    var factorys : [Factory]?
}
