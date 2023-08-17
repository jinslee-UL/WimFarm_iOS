//
//  SettingView.swift
//  WimFarm
//
//  Created by ulalalab on 2022/12/12.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject private var screenRouter: ScreenRouter
    @EnvironmentObject private var settingVM: SettingVM
    @EnvironmentObject var viewModel: LoginVM
    @State var togglePush: Bool = true
    @State var txtPushRecieve: String = "00:00 ~ 23:59"
    
    init() {
        txtPushRecieve = "00:00 ~ 23:59"
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.colorWFGrayBG.ignoresSafeArea()
                
                VStack {
                    infoBox
                    pushBox
                    logoutBtn
                        .padding(10)
                    
                    Spacer()
                }
                .padding(EdgeInsets(top:80, leading: 0, bottom: 0, trailing: 0))
            }
            .navigationBarHidden(false)
            .navigationBarBackButtonHidden(true)
            .edgesIgnoringSafeArea(.top)
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarTitleDisplayMode(.inline)
            .toolbar() {
                
                ToolbarItem(placement: .principal) {
                    Text("setting")
                        .foregroundColor(Color.colorWFTextBlack)
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Image("btnClose")
                        .onTapGesture {
                            screenRouter.currentPage = screenRouter.exPage
                        }
                }
                
            }
//            Group {
                if(settingVM.isLogout) {
                    let _ = initRouterPage()
                    SplashView()
                }
//            }
        }
    }
    
    
    func initRouterPage() {
        screenRouter.currentPage = Page.dashboard
        screenRouter.exPage = Page.dashboard
        self.viewModel.token = ""
        self.settingVM.isLogout = false
        print("lgModel.token = ", self.viewModel.token)
        SplashView().isActive = false
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["en", "ko"], id: \.self) { id in
            SettingView()
                .environment(\.locale, .init(identifier: id))
        }
    }
}

private extension SettingView {
    var infoBox: some View {
        VStack {
            VStack {
                HStack {
                    Image("iconName")
                    Text(UserDefaults.standard.string(forKey: Common.UserDefaultKey.USERNAME) ?? "울랄라랩")
                        .foregroundColor(Color.colorWFTextBlack)
                        .font(Font.custom("NotoSansCJKkr-Bold", size: 18))
                    Spacer()
                }
                
                HStack {
                    Image("iconMail")
                    Text(UserDefaults.standard.string(forKey: Common.UserDefaultKey.USEREMAIL) ?? "ulalaLab@ulalalab.com")
                        .foregroundColor(Color.colorWFTextBlack)
                        .font(Font.custom("NotoSansCJKkr-Regular", size: 18))
                    Spacer()
                }
                
                HStack {
                    Spacer()
                    changePwBtn
                }
            }
            .padding(18)
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.colorWFWhite))
            
        }
        .lineSpacing(0)
        .padding(10)
    }
    
    var pushBox: some View {
        VStack {
            VStack(spacing:0) {
                HStack {
//                    Text("push_alarm_receive")
//                        .foregroundColor(Color.colorWFTextBlack)
//                        .font(Font.custom("NotoSansCJKkr-Bold", size: 17))
//                    Spacer()
                    
                    Toggle(isOn: $togglePush, label: {
                        Text("push_alarm_receive")
                            .foregroundColor(Color.colorWFTextBlack)
                            .font(Font.custom("NotoSansCJKkr-Bold", size: 17))
                    })
                    
                }
                .padding(18)
                
                Divider()
                
                HStack {
                    Text("push_alarm_receive_time")
                        .foregroundColor(Color.colorWFTextBlack)
                        .font(Font.custom("NotoSansCJKkr-Bold", size: 17))
                    Spacer()
                    alarmReceiveTimeBtn
                }
                .padding(18)
            }
            .lineSpacing(0)
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.colorWFWhite))
            
        }
        .padding(10)
    }
    
    var alarmReceiveTimeBtn: some View {
        Button(role: .destructive, action: {}, label: {
            Text(txtPushRecieve)
                .underline()
                .frame(maxWidth: .infinity, alignment: .trailing)
                .font(.system(size: 15.0))
                .foregroundColor(Color.colorWFBlue)
        })
            .buttonStyle(.borderless)
            .controlSize(.small)
    }
    
    var changePwBtn: some View {
        Button(action: {
//                loginVM.login(withdEmail: email, password: password)
            }, label: {
                Text("passwd_change").frame(maxWidth: .infinity)
                    .font(Font.custom("NotoSansCJKkr-Bold", size: 14))
                    .foregroundColor(Color.colorWFWhite)
        })
            .buttonStyle(.bordered)
            .controlSize(.large)
            .frame(width: 150.0, height: 50.0)
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.colorWFGrayBtnNor))
    }
    
    var logoutBtn: some View {
        Button(action: {
//                settingVM.logout()
                settingVM.unregisterToken()
            }, label: {
                Text("logout").frame(maxWidth: .infinity)
                    .font(.system(size: 18.0))
                    .foregroundColor(Color.colorWFWhite)
        }).frame(maxWidth: .infinity)
            .buttonStyle(.bordered)
            .controlSize(.large)
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.colorWFGrayBtnNor))
    }
}
