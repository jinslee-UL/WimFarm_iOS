//
//  SplashView.swift
//  WimFarm
//
//  Created by ulalalab on 2021/11/17.
//

import SwiftUI

struct SplashView: View {
    @State var isActive:Bool = false
    @EnvironmentObject var viewModel: LoginVM
    
    var body: some View {
//        NavigationView {
            ZStack {
                Color.colorUlala.ignoresSafeArea()
                
                // Your other content here
                // Other layers will respect the safe area edges
                let _ = print("스플래시")
                if self.isActive {
                    
                    let _ = print("2초 지남")
//                    Group {
                        if (viewModel.token != "") {
                            let _ = print("토큰 있음 : \(viewModel.token)")
                            let _ = print("토큰 있음 : \(viewModel.email)")
                            let _ = print("토큰 있음 : \(viewModel.passwd)")
                            MainTabView()
                                .environmentObject(ScreenRouter())
                                .onAppear {
                                    viewModel.login(withdEmail: viewModel.email, password: viewModel.passwd)
                                }
//                            HomeTabView()
//                            RootTabView()
//                                .environmentObject(TabViewState())
                        }
                        else {
                            let _ = print("토큰 없음")
                            LoginView()
                        }
//                    }
                } else {
                    let _ = print("2초 안지남")
//                    Image("SplashLogo")
                    Image("SplashLogoWell")
                        .padding([.bottom], 100)
                }
//                NavigationLink(destination: LoginView()
//                                .navigationBarHidden(true)
//                                .navigationBarBackButtonHidden(true)
//                                .edgesIgnoringSafeArea(.top)) {
//                    Image("SplashLogo")
//                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
//            .navigationBarHidden(true)
//            .navigationBarBackButtonHidden(true)
//            .edgesIgnoringSafeArea(.top)
//        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
