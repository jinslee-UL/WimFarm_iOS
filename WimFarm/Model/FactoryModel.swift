//
//  FactoryModel.swift
//  WimFarm
//
//  Created by ulalalab on 2023/01/31.
//

import Foundation

struct Factory : Codable {
    var factory_idx, factory_company_idx, factory_manager_idx: Int?
    var factory_name, factory_plant, factory_comment, factory_business, factory_country, factory_address, factory_lat, factory_lon, factory_manager_name, factory_manager_email, factory_manager_tel, factory_manager_hp, factory_user_email, factory_user_name, factory_user_tel, factory_user_hp: String?
}

//struct Factory : Codable {
////    @SerializedName("factory_idx")
//    var factoryIdx : Int?
////    @SerializedName("factory_name")
//    var factoryName : String?
////    @SerializedName("factory_address")
//    var factoryAddress : String?
//    var factoryLon : String?
//    var factoryLat : String?
//
//
//    enum CodingKeys: String, CodingKey {
//        case factoryIdx = "factory_idx"
//        case factoryName = "factory_name"
//        case factoryAddress = "factory_address"
//        case factoryLon = "factory_lon"
//        case factoryLat = "factory_lat"
//    }
//}
