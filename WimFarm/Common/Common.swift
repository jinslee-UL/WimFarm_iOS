//
//  Common.swift
//  WimFarm
//
//  Created by ulalalab on 2021/12/13.
//

import Foundation

struct Common {
    public struct UserDefaultKey{
        static let UUID                 = "uuid"
        static let AUTOLOGIN            = "autoLogin"
        static let USERID               = "userID"
        static let USERPW               = "userPW"
        static let USERNAME             = "userName"
        static let USEREMAIL            = "userEmail"
        static let SERVER_NAME          = "serverName"
        static let SERVER_URL           = "serverURL"
        static let TOKEN                = "token"
        static let DEVICE_TOKEN         = "deviceToken"
        static let ALARM_SET            = "alarmSet"
        static let NOTI_OS_TOKEN        = "iOS"
        static let NOTI_TYPE            = "farm"
        static let CURRENT_VIEW         = "currentView"
        static let LOADED               = "loaded"
        static let PACKET               = "packet"
        static let DASH_WIDGET_LIST     = "dashWidget"
        static let LOADED_USER          = "loadedUser"
    }

    public struct Link{
//        static let APPSTORE             = "https://itunes.apple.com/app/id1470361790"
    }
    
    public struct Key{
//        static let ADBRIX_APP_KEY       = "eXcBJaA78UyEuVtk2oYSpA"
//        static let ADBRIX_SECRET_KEY    = "j9zHwwU7kke6IhBrlWHalQ"
    }
    
    public struct ScreenView {
        static let DASHBOARD            = "dashboard"
        static let ALARM                = "alarm"
        static let ALARM_PAST           = "alarmPast"
        static let SITEMAP              = "sitemap"
        static let WEATHER              = "weather"
        static let REPORT               = "report"
        static let NOTICE               = "notices"
        static let QNA                  = "question"
        static let SETTING              = "setting"
    }
}

