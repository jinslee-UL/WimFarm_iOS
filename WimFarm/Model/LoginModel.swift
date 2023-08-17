//
//  LoginModel.swift
//  WimFarm
//
//  Created by ulalalab on 2021/12/10.
//

import Foundation
//import ObjectMapper

struct LoginResponse: Codable {
    var code: String?
    var data: LoginModel?
}

struct LoginModel: Codable { //  Mappable {
    var abnormal:Int?
    var auto:Int?
    var companyIdx:Int?
    var companyLogo:String?
    var companyName:String?
    var companyComment:String?
    var config:[Config]?
    var email:String?
    var factory:String?
    var factoryIdx:Int?
    var grade:String?
    var idx:Int?
    var language:String?
    var manager:Bool?
    var name:String?
    var partname:String?
    var partner:String?
    var theme:Int?
    var timezone:String?
    var token:String?
    var latitude:String?
    var longitude:String?
    
//    init?(map: Map) {
//
//    }
//
//    mutating func mapping(map: Map) {
//        abnormal <- map["abnormal"]
//        auto <- map["auto"]
//        companyIdx <- map["companyIdx"]
//        companyLogo <- map["companyLogo"]
//        companyName <- map["companyName"]
//        companyName <- map["companyComment"]
//        config <- map["config"]
//        email <- map["email"]
//        factory <- map["factory"]
//        factoryIdx <- map["factoryIdx"]
//        grade <- map["grade"]
//        idx <- map["idx"]
//        language <- map["language"]
//        manager <- map["manager"]
//        name <- map["name"]
//        partname <- map["partname"]
//        partner <- map["partner"]
//        theme <- map["theme"]
//        timezone <- map["timezone"]
//        token <- map["token"]
//    }
}

struct Config: Codable {//Mappable {
    var userIdx: Int?
    var deviceIdx: Int?
    var userDeviceConfig: Int?
    
//    init?(map: Map) {
//    }
//
//    mutating func mapping(map: Map) {
//        userIdx <- map["user_idx"]
//        deviceIdx <- map["device_idx"]
//        userDeviceConfig <- map["user_device_config"]
//    }
}

struct TokenRegisterResponse: Codable {
    var code: String?
    var data: TokenRegisterModel?
}

struct TokenRegisterModel: Codable {
//    var abnormal: Int?
//    var companyIdx: Int?
//    var companyLogo: String?
//    var compnayName: String?
//    var email: String?
//    var factory: String?
//    var factoryIdx: Int?
//    var grade: String?
//    var idx: Int?
//    var language: String?
//    var manager: Int?
//    var name: String?
//    var partname: String?
//    var partner: String?
//    var theme: Int?
//    var timezone: String?
//    var token: String?
}
