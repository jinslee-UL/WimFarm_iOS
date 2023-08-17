//
//  UserModel.swift
//  WimFarm
//
//  Created by ulalalab on 2023/01/31.
//

import Foundation


struct UserRes: Codable {
    var data: User?
    var code: String? 
}

struct User: Codable {
    var idx, compan_idx, factory_idx : Int?
    var name, company_name, company_logo, company_comment, email, tel, hp, country, language, grade : String?
    
   
}

/**
 * 로그인 할때 리턴
 */
//struct UserRes: Codable {
//    var data: User?
//    var code: String?
//}
//
//struct UserListRes: Codable {
//    var data: UserData?
//    var code: String?
//}
//
//struct UserData : Codable {
//    var lists: [User]?
//    var paginator: [String: Int]?
//}
//
///**
// * 마이피 조회시 리턴
// */
//struct MyPageRes: Codable {
//    var data: MyPageData?
//    var code: String?
//}
//struct MyPageData: Codable {
//    var permission: [String]?
//    var grade: String?
//
//    var userInfo: User?
//
////    @SerializedName("alarm_config")
//    var alarmConfig: [AlarmConfig]?
//}
//
//struct AlarmConfig: Codable {
////    @SerializedName("user_idx")
//    var userIdx : Int?
//
////    @SerializedName("device_idx")
//    var deviceIdx : Int?
//
////    @SerializedName("user_device_config")
//    var userDeviceConfig : String?
//
//    var alarmConfigMap : UserDeviceConfig?
//}
//
//struct UserDeviceConfig: Codable {
//
////    @SerializedName("receive_time")
//    var receiveTime : ReceiveTime?
//
////    @SerializedName("is_use")
//    var isUse : Int?
//
////    @SerializedName("maintain_time")
//    var maintainTime : Int?
//
////    @SerializedName("first_page_url")
//    var firstPageUrl : String?
//}
//
//struct ReceiveTime: Codable {
//    var start : String?
//    var end : String?
//}
//
//struct User: Codable {
//    var idx: Int?
//    var grade : String?
//    var name : String?
//    var tel : String?
//    var email : String?
//    var language : String?
//
//    var manager : Bool? = false
//    var passwd : String?
//    var partname : String?
//
//    var timezone : String?
//    var token : String?
//
//    var companyLogo : String?
//
//    var abnormal: Int?
//
////    var userIdx: Int?
////    var roleName : String?
////    var userName : String?
////    var userEmail : String?
////    var userTel : String?
//
//    var use : Bool? = false
//
//    var companyIdx : Int?
//    var companyName : String?
//    var companyComment : String?
//    var factoryIdx : Int?
//
////    // 주소 (회사관리자는 회사주소, 공장관리자는 공장주소)
////    var address : String?
////    // 위도
////    var latitude : String?
////    // 경도
////    var longitude : String?
//
//
//
//    enum CodingKeys: String, CodingKey {
//        case idx
//        case grade
//        case name
//        case tel
//        case email
//        case language
//
//        case manager
//        case passwd
//        case partname
//
//        case timezone
//        case token
//
//        case companyLogo = "company_logo"
//
//        case abnormal
//
//        case companyIdx = "company_idx"
//        case companyName = "company_name"
//        case companyComment = "company_comment"
//        case factoryIdx = "factory_idx"
//    }
//}
//
//struct ResetPw: Codable {
//    var err : Int? = 0
//    var msg : String?
//    var sendCnt : Int? = 0
//}
