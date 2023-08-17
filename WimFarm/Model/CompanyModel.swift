//
//  CompanyModel.swift
//  WimFarm
//
//  Created by ulalalab on 2023/01/31.
//

import Foundation

struct Company : Codable {
    var company_idx, company_manager_idx, factory_cnt, device_cnt: Int?
    var company_name, company_ceo, company_logo, company_comment, company_country, company_language, company_business, company_address, company_lat, company_lon, company_manager_type, company_manager_name,company_manager_email, company_manager_tel, company_manager_hp: String?
}

//struct Company : Codable {
////    @SerializedName("company_idx")
//    var companyIdx : Int?
////    @SerializedName("company_name")
//    var companyName : String?
////    @SerializedName("company_ceo")
//    var companyCeo : String?
////    @SerializedName("company_address")
//    var companyAddress : String?
////    @SerializedName("company_logo")
//    var companyLogo : String?
////    @SerializedName("company_lon")
//    var companyLon : String?
////    @SerializedName("company_lat")
//    var companyLat : String?
////    @SerializedName("device_cnt")
//    var deviceCnt : String?
////    @SerializedName("factory_cnt")
//    var factoryCnt : String?
//
//
//    enum CodingKeys: String, CodingKey {
//        case companyIdx = "company_idx"
//        case companyName = "company_name"
//        case companyCeo = "company_ceo"
//        case companyAddress = "company_address"
//        case companyLogo = "company_logo"
//        case companyLon = "company_lon"
//        case companyLat = "company_lat"
//        case deviceCnt = "device_cnt"
//        case factoryCnt = "factory_cnt"
//    }
//}
