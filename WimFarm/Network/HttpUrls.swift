//
//  HttpUrls.swift
//  WimFarm
//
//  Created by ulalalab on 2021/12/13.
//

import UIKit

struct HttpUrls {
    struct URL {
        static let COMMON = "http://www.wim-x.kr"
        static let FARM_URL = "http://www.wim-x.kr"
        static let FARM_API_URL = "http://api.wim-x.kr:89"
        static let WEATHER_API_URL = "https://api.openweathermap.org/data/2.5"
    }
    
    struct LANGUAGE {
        static let LANGUAGE =  "http://211.62.140.72:80/manager/language"
    }
    
    struct HEADER {
        static let HEADERS = [
            "X-SERVER-WIMX": "App",
            "Content-Type": "application/x-www-form-urlencoded",
            "X-Requested-With": "XMLHttpRequest"
        ]
        
        static let FARM_HEADER = [
            "Content-Type: application/json"
        ]
    }
    
    struct NAME {
        // 서버목록
        static let SERVERS = URL.COMMON + "/manager/services"
        // 로그인
        static let LOGIN = "user/login"
        // 로그아웃
        static let LOGOUT = "user/logout"
        // 비밀번호 찾기
        static let PW_SEARCH = "user/email"
        // 비밀번호 찾기2
        static let PW_RESET = "api/user/resetPw"
        
        // 디바이스 토큰 등록
        static let TOKEN_REGISTER = "dashboard/token/register"
        // 디바이스 토큰 해제
        static let TOKEN_UNREGISTER = "dashboard/token/unregister"
        
        // 대시보드
        static let LOADED = "dashboard/loaded"
        // 대시보드 Packet
        static let PACKET = "dashboard/packet"
        // 대시보드 Packet
        static let LAST = "manager/device/last"
        // 대시보드 위젯 리스트
        static let DASH_WIDGET_LIST = "dashboard/widget/transition/lists"
        
        // 알람
        static let ALARM_LIST = "dashboard/device/alarm/company"
        // 데일리 알람
        static let ALARM_DAILY_LIST = "api/alarm/daily"
        
        
        // 트랜드 분석
        static let  SUMMARY = "dashboard/device/report/summary"
        // 히스토리 저장
        static let  ARCHIVE = "dashboard/device/report/archive"
        
        
        // 공지사항
        static let NOTICE = "dashboard/board/notice/lists"
        // FAQ
        static let FAQ = "dashboard/board/faq/lists"
        
        static let WEATHER_KEY = "871e998f753c9217f41114a8c5a5f0f6"
    }
}
