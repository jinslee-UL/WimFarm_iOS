//
//  SettingModel.swift
//  WimFarm
//
//  Created by ulalalab on 2023/01/12.
//

import Foundation
//import ObjectMapper

struct LogoutResponse: Codable {
    var code: String?
    var data: EmptyModel?
}

struct EmptyModel: Codable {
    
}
