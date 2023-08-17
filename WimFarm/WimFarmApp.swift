//
//  WimFarmApp.swift
//  WimFarm
//
//  Created by ulalalab on 2021/11/15.
//

import SwiftUI

@main
struct WimFarmApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
//            SplashView()
            SplashView().environmentObject(LoginVM.shared)
                .environmentObject(SettingVM.shared)
                .environmentObject(DashboardVM.shared)
                .environmentObject(AlarmVM.shared)
//                .environmentObject(ChartVM.shared)
                .environmentObject(TrendVM.shared)
                .environmentObject(ReportVM.shared)
                .environmentObject(ReportGraphVM.shared)
//            DashboardView().environmentObject(DashboardVM.shared)
//            MainTabView().environmentObject(DashboardVM.shared)
//            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    static var orientationLock = UIInterfaceOrientationMask.portrait
    
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//        // something to do
//        return true
//    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window:UIWindow?) -> UIInterfaceOrientationMask {
        return AppDelegate.orientationLock
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // APNS 설정
        UNUserNotificationCenter.current().delegate = self

        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .sound, .badge]) {
                [weak self] granted, error in
            
                print("Permission granted: \(granted)")
        }

        // APNS 등록
        application.registerForRemoteNotifications()
        return true
    }
    
    // 실패시
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register for notifications: \(error.localizedDescription)")
    }
        
    // 성공시
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
        let token = tokenParts.joined()
        
        UserDefaults.standard.set(token, forKey: Common.UserDefaultKey.DEVICE_TOKEN)
        print("Device Token: \(token)")
    }
}
