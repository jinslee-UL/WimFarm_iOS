//
//  GlobalModel.swift
//  WimFarm
//
//  Created by ulalalab on 2022/02/11.
//

import Foundation

class GlobalModel : ObservableObject {
    @Published var loginData: LoginModel?
//    var loginData: LoginModel?
//    var packetData: NSDictionary?
    var loadData: NSDictionary?
    var dashData: NSDictionary?
    
    var loadedData: LoadedModel?
    var packetData: [String: PacketData]?
    var dashWidgetData : DashWidget?
    
    var loadedUser: User?
    
    var domain: String?
    var serverName: String?
    var deviceToken: String?
    
    // 자동로그인체크
    var autoLoginCheck: String?
    var emailID: String?
    
    static let shared = GlobalModel()
    
    static var instance:GlobalModel = GlobalModel()
    
    static func sharedInstance() -> GlobalModel
    {
        return instance
    }
    
    private init() {
        
    }

}
