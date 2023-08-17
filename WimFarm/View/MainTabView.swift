//
//  MainTabView.swift
//  WimFarm
//
//  Created by ulalalab on 2021/11/18.
//

import SwiftUI

struct MainTabView: View {
    
    @State var selection = 1
    
    init() {
        UINavigationBar.appearance().backgroundColor = .white
        
        UITabBar.appearance().backgroundColor = .white
//        UITabBar.appearance().itemSpacing = 10
        UITabBar.appearance().unselectedItemTintColor = .darkGray
    }
    
    @EnvironmentObject private var screenRouter: ScreenRouter
    @State var showPopUp = false
    
    var body: some View {
        ZStack{
            VStack{
//                Spacer()
                let _ = print("tossssssssssPage = \(screenRouter.currentPage)")
                ChangeMainView(screenRouter: screenRouter)
                    .environmentObject(screenRouter)
                
//                Spacer()
                
            }
            BottomTabbar(screenRouter: screenRouter)
            let _ = print("bossssssssssPage = \(screenRouter.currentPage)")

        }
        .edgesIgnoringSafeArea(.top)
//        .edgesIgnoringSafeArea(.bottom)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
//        MainTabView()
        ForEach(["en", "ko"], id: \.self) { id in
            MainTabView()
                .environment(\.locale, .init(identifier: id))
        }
    }
}

struct ChangeMainView: View {
//    @StateObject var screenRouter: ScreenRouter
    @StateObject var screenRouter = ScreenRouter()

    var body: some View{
        let _ = print("crt page = \(screenRouter.currentPage)")
        let _ = print("ex page = \(screenRouter.exPage)")
        let pg:Page = screenRouter.currentPage
        let _ = print("crt page = \(pg)")
        switch screenRouter.currentPage{
            case .alarm:
                AlarmView()
                .environmentObject(screenRouter)
            case .dashboard:
                DashboardView()
                .environmentObject(screenRouter)
            case .sitemap:
                SitemapView()
                .environmentObject(screenRouter)
            case .alarmPast:
                AlarmPastView()
                .environmentObject(screenRouter)
            case .weather:
                WeatherView(viewModel: WeatherVM(weatherFetcher: MockWeatherFetcher()))
                .environmentObject(screenRouter)
            case .report:
                ReportView()
                .environmentObject(screenRouter)
            case .notice:
                ReportView()
                .environmentObject(screenRouter)
            case .qna:
                ReportView()
                .environmentObject(screenRouter)
            case .setting:
                SettingView()
                .environmentObject(screenRouter)
        }
    }
}

//struct TabbarOneIcons: View{
//    @StateObject var screenRouter: ScreenRouter
//    
//    let assignedPage: Page
//    let defIconName, tabName: String
//    
//    var body: some View{
//        
//        HStack{
//            Spacer()
//            VStack{
//                
////                Image(systemName: screenRouter.currentPage != assignedPage ? defIconName : "minus")
////                Image(screenRouter.currentPage != assignedPage ? defIconName+"Nor" : defIconName+"On")
//////                var imgName: String = defIconName
//////
//////                if screenRouter.currentPage == assignedPage {
//////                    imgName = imgName + "On"
//////                }
//////                else {
//////                    imgName = imgName + "Nor"
//////                }
//////
//////
//////                Image(imgName)
////                    .resizable()
////                    .aspectRatio(contentMode: .fit)
//////                    .frame(maxWidth: 44, maxHeight: 44, alignment: .center)
////                    .foregroundColor(screenRouter.currentPage == assignedPage ? Color.colorWFGrayTbDark : Color.colorUlala)
////                    .transition(AnyTransition.scale)
//                
//                if screenRouter.currentPage == assignedPage {
//                    Image(defIconName+"On")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
////                        .foregroundColor(screenRouter.currentPage == assignedPage ? Color.colorWFGrayTbDark : Color.colorUlala)
////                        .transition(AnyTransition.scale)
////                    Text(defIconName+"On")
//////                        .font(.footnote)
////                        .foregroundColor(Color.colorWFBlue)
////                        .transition(AnyTransition.scale)
//                }
//                else {
//                    Image(defIconName+"Nor")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
////                        .foregroundColor(screenRouter.currentPage == assignedPage ? Color.colorWFGrayTbDark : Color.colorUlala)
////                        .transition(AnyTransition.scale)
////                    Text(defIconName+"Nor")
//////                        .font(.footnote)
////                        .foregroundColor(Color.colorWFBlue)
////                        .transition(AnyTransition.scale)
//                }
//            }
//            
//            .onTapGesture {
////                withAnimation{
//                    screenRouter.currentPage = assignedPage
//                    
////                }
//                
//            }
//            Spacer()
//        }
//        
//    }
//}
