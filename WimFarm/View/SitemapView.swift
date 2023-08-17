//
//  SitemapView.swift
//  WimFarm
//
//  Created by ulalalab on 2021/11/18.
//

import SwiftUI
import Foundation

struct SitemapView: View {
    @EnvironmentObject private var screenRouter: ScreenRouter
    
//    let icons:[String] = ["iconMypageDashboard", "iconMypageAlram", "iconMypageAlramLate", "iconMypageWeather", "iconMypageData", "iconMypageNotice", "iconMypageQna", "iconMypageOption"]
//
//    let titles:[String] = ["dashboard", "alarm_today_title", "alarm_daily_report", "weather", "report", "notices", "question", "setting"]
//
//    let pages:[Page] = [.dashboard, .alarm, .alarmPast, .weather, .report, .notice, .qna, .setting]
    
    let icons:[String] = ["iconMypageDashboard", "iconMypageAlram", "iconMypageAlramLate", "iconMypageWeather", "iconMypageData", "iconMypageOption"]
    
    let titles:[String] = ["dashboard", "alarm_today_title", "alarm_daily_report", "weather", "report", "setting"]
    
    let pages:[Page] = [.dashboard, .alarm, .alarmPast, .weather, .report, .setting]
    
//    let icons:[String] = ["iconMypageDashboard", "iconMypageAlram", "iconMypageAlramLate", "iconMypageWeather", "iconMypageOption"]
//
//    let titles:[String] = ["dashboard", "alarm_today_title", "alarm_daily_report", "weather", "setting"]
//
//    let pages:[Page] = [.dashboard, .alarm, .alarmPast, .weather, .setting]
    
    
    init() {
//        UINavigationBar.appearance().backgroundColor = .white
        UITableView.appearance().backgroundColor = .clear
        UITableView.appearance().separatorStyle = .singleLine
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.colorWFGrayBG.ignoresSafeArea()
                
                VStack {
                    
                    if #available(iOS 16.0, *) {
                        List {
                            ForEach(icons.indices, id: \.self) { index in
                                let titleLocalized: String = titles[index].localized
                                //                            print("title \(titleLocalized)")
                                
                                SitemapItem(screenRouter: screenRouter, assignedPage: pages[index], defIconName: icons[index], titleName: titleLocalized)
                                    .onTapGesture {
                                        screenRouter.currentPage = pages[index]
//                                        MainTabView().screenRouter.currentPage = pages[index]
                                        //                                    ChangeView(screenRouter: $screenRouter)
//                                        NavigationLink(destination: screenRouter.changeScreenRouter(scrRou: screenRouter))
                                    }
                                //                                .listRowInsets(EdgeInsets())
                            }
                            .listRowBackground(Color.colorWFWhite)
                        }
                        .scrollContentBackground(.hidden)
                        .background(Color.colorWFGrayBG)
                        .listStyle(InsetGroupedListStyle())
                    } else {
                        // Fallback on earlier versions
                        List {
                            ForEach(icons.indices, id: \.self) { index in
                                let titleLocalized: String = titles[index].localized
                                //                            print("title \(titleLocalized)")
                                
                                SitemapItem(screenRouter: screenRouter, assignedPage: pages[index], defIconName: icons[index], titleName: titleLocalized)
                                    .onTapGesture {
                                        screenRouter.currentPage = pages[index]
//                                        MainTabView().screenRouter.currentPage = pages[index]
                                        //                                    ChangeView(screenRouter: $screenRouter)
                                    }
                                //                                .listRowInsets(EdgeInsets())
                            }
                            .listRowBackground(Color.colorWFWhite)
                        }
                        .background(Color.colorWFGrayBG)
                        .listStyle(InsetGroupedListStyle())
                    }
//                    .listStyle(GroupedListStyle())
//                    .environment(\.horizontalSizeClass, .regular)
//                    .cornerRadius(10)
                }
                .background(Color.colorWFGrayBG)
//                .padding(10)
                .padding(EdgeInsets(top:-20, leading: 0, bottom: 30, trailing: 0))
//                .cornerRadius(10)
//                .frame(alignment: .top)
//                .edgesIgnoringSafeArea(.top)
            }
            .background(Color.colorWFGrayBG)
            .navigationBarHidden(false)
//            .navigationTitle(Text("Sitemap"))
//            .foregroundColor(Color.colorWFTextBlack)
            .navigationBarBackButtonHidden(true)
//            .edgesIgnoringSafeArea(.top)
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarTitleDisplayMode(.inline)
            .toolbar() {
                ToolbarItem(placement: .principal) {
                    ZStack {
                        Color.colorWFWhite.ignoresSafeArea()

                        Text("service_sitemap")
                            .foregroundColor(Color.colorWFTextBlack)
                    }
                }
            }
        }
    }
}


struct SitemapView_Previews: PreviewProvider {
    static var previews: some View {
//        SitemapView()
        ForEach(["en", "ko"], id: \.self) { id in
            SitemapView()
                .environment(\.locale, .init(identifier: id))
        }
    }
}

struct SitemapItem: View {
//    @Binding var screenRouter: ScreenRouter
    
    @StateObject var screenRouter: ScreenRouter
    
    let assignedPage: Page
    let defIconName, titleName: String
    
    var body: some View {
        VStack {
            HStack(spacing:0) {
                Image(defIconName)
//                    .frame(width: 48.0, height: 48.0, alignment: .center)
                Text(titleName)
                    .foregroundColor(Color.colorWFTextBlack)
                    .padding(EdgeInsets(top:10, leading: 20, bottom: 10, trailing: 0))
                Spacer()
                Image("btnNextNor")
//                    .frame(width: 23.0, height: 38.0, alignment: .center)

            }
            .background(Color.colorWFWhite)
            .padding(0)
            .onTapGesture {
                let _ = print("assssssssignPage = \(assignedPage)")
                screenRouter.exPage = screenRouter.currentPage
                screenRouter.currentPage = assignedPage
                let _ = print("crrrrrrrrrrtPage = \(screenRouter.currentPage)")
//                MainTabView().changeCurrentPage(page: assignedPage)
//                ChangeView(screenRouter: $screenRouter)
            }
        }
//        .background(Color.colorWFWhite)
//        .padding()
//        .padding(EdgeInsets(top:0, leading: 0, bottom: 1, trailing: 0))
    }
}

struct ListBackgroundModifier: ViewModifier {

    @ViewBuilder
    func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            content
                .scrollContentBackground(.hidden)
        } else {
            content
        }
    }
}
