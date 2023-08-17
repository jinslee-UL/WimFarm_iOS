//
//  LoginView.swift
//  WimFarm
//
//  Created by ulalalab on 2021/11/17.
//

import SwiftUI

struct LoginView: View {
//    @StateObject private var loginVM = LoginVM()
    @EnvironmentObject private var loginVM: LoginVM
    @State private var email = "dev1@ulalalab.com"
    @State private var password = "ulab0605"
//    @State private var email = "admin@showmywell.com"
//    @State private var password = "test1234!"
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.colorWFWhite.ignoresSafeArea()
                VStack {
    //                Color.colorWFWhite.ignoresSafeArea()
                    
                    // Your other content here
                    // Other layers will respect the safe area edges
                    logo
                    emailTF
                    passwordTF
                    VStack {
                        loginBtn
                        findPwBtn
                    }
                    .frame(width: 300)
                    Spacer()
                    textCopyright
                    
                    
                    
//                    Image("LoginLogo")
//                        .padding([.top], 100)
//
//                    Text("스마트 온습도 모니터링 서비스")
//                        .foregroundColor(Color.colorUlala)
//                        .padding([.top], 2)
//                        .padding([.bottom], 40)
//
//
//                    TextField("input_ID", text: $loginVM.email)
//                        .foregroundColor(Color.colorWFTextBlack)
//                        .keyboardType(.emailAddress)
//                        .frame(width: 280.0, height: 50.0)
//                        .padding([.leading, .trailing], 10)
//                        .background(
//                            RoundedRectangle(cornerRadius: 4, style: .continuous)
//                                .stroke(Color.colorWFGrayF0F1F6, lineWidth: 1)
//                        ).padding(2)
//
//                    SecureField("input_password", text: $loginVM.passwd)
//                        .foregroundColor(Color.colorWFTextBlack)
//                        .keyboardType(.default)
//                        .frame(width: 280.0, height: 50.0)
//                        .padding([.leading, .trailing], 10)
//                        .background(
//                            RoundedRectangle(cornerRadius: 4, style: .continuous)
//                                .stroke(Color.colorWFGrayF0F1F6, lineWidth: 1)
//                        ).padding(2)
                    
        //                .background(Capsule().fill(Color.colorWFWhite))
//
//                    VStack (alignment: .trailing){
//                        Button(role: .destructive,
//                               action: {
//                            loginVM.login()
//                        }, label: {
////                            NavigationLink(destination: MainTabView()
////                                            .navigationBarHidden(true)
////                                            .navigationBarBackButtonHidden(true)
////                                            .edgesIgnoringSafeArea(.top)
////                                            .navigationBarTitleDisplayMode(.inline)) {
//                            Text("login").frame(maxWidth: .infinity)
//                                .font(.system(size: 20.0))
//                                .foregroundColor(Color.colorWFWhite)
////                            }
//                        })
//                            .alert(isPresented: $showingAlert) {
//                                        Alert(title: Text("email_not_input"), message: nil,
//                                              dismissButton: .default(Text("OK")))
//                                    }
//
//                            .buttonStyle(.bordered)
//                            .controlSize(.large)
//                            .frame(width: 300.0, height: 50.0)
//                            .background(Color.colorWFGreenBG)
//
//                        Button(role: .destructive, action: {}, label: {
//                            Text("find_password").frame(maxWidth: .infinity)
//                                .font(.system(size: 15.0))
//                                .foregroundColor(Color.colorWFBlue)
//                        })
//                            .buttonStyle(.borderless)
//                            .controlSize(.small)
//                    }
//                    .frame(width: 300, alignment: .trailing)
//
//                    Spacer()
//
//                    Text("ⓒ 울랄라랩")
//                        .padding(.bottom, 10)
                }
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .edgesIgnoringSafeArea(.top)
            .onAppear {
                let _ = print("2초 지남")
//                    Group {
                    if (loginVM.token != "") {
                        let _ = print("토큰 있음 : \(loginVM.token)")
                        loginVM.login(withdEmail: loginVM.email, password: loginVM.passwd)
                        
//                        MainTabView()
//                            .environmentObject(ScreenRouter())
//                            HomeTabView()
//                            RootTabView()
//                                .environmentObject(TabViewState())
                    }
                    else {
                        let _ = print("토큰 없음")
//                        LoginView()
                    }
            }
        }
    }
}

private extension LoginView {
    var logo: some View {
        VStack {
//            Image("LoginLogo")
            Image("loginLogoWell")
                .padding([.top], 140)
            
            Text("스마트 온습도 모니터링 서비스")
                .foregroundColor(Color.colorUlala)
                .padding([.top], 2)
                .padding([.bottom], 40)
        }
    }
    
    var emailTF: some View {
        TextFieldWPH(placeholder: Text("input_ID"), text: $email)
            .foregroundColor(Color.colorWFTextBlack)
            .keyboardType(.emailAddress)
            .frame(width: 280.0, height: 50.0)
            .padding([.leading, .trailing], 10)
            .background(
                RoundedRectangle(cornerRadius: 4, style: .continuous)
                    .stroke(Color.colorWFGrayEdgeOfBox, lineWidth: 1)
            ).padding(2)
    }
    
    var passwordTF: some View {
        SecureFieldWPH(placeholder: Text("input_password"), password: $password)
            .foregroundColor(Color.colorWFTextBlack)
            .keyboardType(.default)
            .frame(width: 280.0, height: 50.0)
            .padding([.leading, .trailing], 10)
            .background(
                RoundedRectangle(cornerRadius: 4, style: .continuous)
                    .stroke(Color.colorWFGrayEdgeOfBox, lineWidth: 1)
            ).padding(2)
    }
    
    var loginBtn: some View {
        Button(action: {
//            loginVM.login()
                loginVM.login(withdEmail: email, password: password)
            }, label: {
                Text("login").frame(maxWidth: .infinity)
                    .font(.system(size: 20.0))
                    .foregroundColor(Color.colorWFWhite)
        })
            .alert(isPresented: $showingAlert) {
                        Alert(title: Text("email_not_input"), message: nil,
                              dismissButton: .default(Text("OK")))
                    }
        
            .buttonStyle(.bordered)
            .controlSize(.large)
            .frame(width: 300.0, height: 50.0)
            .background(Color.colorWFGreenBG)
    }
    
    var findPwBtn: some View {
        Button(role: .destructive, action: {}, label: {
            Text("find_password")
                .underline()
                .frame(maxWidth: .infinity, alignment: .trailing)
                .font(.system(size: 15.0))
                .foregroundColor(Color.colorWFBlue)
        })
            .buttonStyle(.borderless)
            .controlSize(.small)
    }
    
    var textCopyright: some View {
        Text("ⓒ 울랄라랩")
            .foregroundColor(Color.colorWFTextBlack)
            .padding(.bottom, 10)
            .font(.system(size: 12.0))
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
//        LoginView()
        
        ForEach(["en", "ko"], id: \.self) { id in
                    LoginView()
                        .environment(\.locale, .init(identifier: id))
                }
    }
}
