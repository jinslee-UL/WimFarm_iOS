//
//  ScreenRouter.swift
//  WimFarm
//
//  Created by ulalalab on 2021/11/29.
//

import SwiftUI

class ScreenRouter : ObservableObject {
    @Published var currentPage: Page = .dashboard
    @Published var exPage: Page = .dashboard
    
//    func changeScreenRouter(scrRou: ScreenRouter) {
//        switch scrRou.currentPage {
//        case .alarm:
//            AlarmView()
//        case .dashboard:
//            DashboardView()
//        case .sitemap:
//            SitemapView()
//        case .alarmPast:
//            AlarmPastView()
//        case .weather:
//            WeatherView(viewModel: WeatherViewModel(weatherFetcher: MockWeatherFetcher()))
//        case .report:
//            ReportView()
//        case .notice:
//            ReportView()
//        case .qna:
//            ReportView()
//        case .setting:
//            SettingView()
//        }
//    }
}


enum Page {
    case alarm
    case dashboard
    case sitemap
    case alarmPast
    case weather
    case report
    case notice
    case qna
    case setting
}

//enum Pages: Identifiable {
//    case dashboard
//    case alarm
//    case sitemap
//    case alarmPast
//    case weather
//    case report
//    case notice
//    case qna
//    case setting
//
//    var id: Int {
//        switch self {
//        case .dashboard:
//            return 0
//        case .alarm:
//            return 1
//        case .sitemap:
//            return 2
//        case .alarmPast:
//            return 3
//        case .weather:
//            return 3
//        case .report:
//            return 3
//        case .notice:
//            return 3
//        case .qna:
//            return 3
//        case .setting:
//            return 3
//        }
//    }
//
//    var label: String {
//        switch self {
//
//        case .dashboard:
//            return "dashboard"
//        case .alarm:
//            return "alarm_today_title"
//        case .sitemap:
//            return "service_sitemap"
//        case .alarmPast:
//            return "alarm_daily_report"
//        case .weather:
//            return "weather"
//        case .report:
//            return "report"
//        case .notice:
//            return "notices"
//        case .qna:
//            return "question"
//        case .setting:
//            return "setting"
//        }
//    }
//
//    func icon(isSelected: Bool) -> String {
//        switch self {
//
//        case .dashboard:
//            return isSelected ? "btnDashboardOn" : "btnDashboardNor"
//        case .alarm:
//            return isSelected ? "btnAlramOn" : "btnAlramNor"
//        case .sitemap:
//            return isSelected ? "btnMypageOn" : "btnMypageNor"
//        case .alarmPast:
//            return isSelected ? "iconMypageAlramLate" : "iconMypageAlramLate"
//        case .weather:
//            return isSelected ? "iconMypageWeather" : "iconMypageWeather"
//        case .report:
//            return isSelected ? "iconMypageData" : "iconMypageData"
//        case .notice:
//            return isSelected ? "iconMypageNotice" : "iconMypageNotice"
//        case .qna:
//            return isSelected ? "iconMypageQna" : "iconMypageQna"
//        case .setting:
//            return isSelected ? "iconMypageOption" : "iconMypageOption"
//        }
//    }
//}
