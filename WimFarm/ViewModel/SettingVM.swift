//
//  SettingVM.swift
//  WimFarm
//
//  Created by ulalalab on 2023/01/12.
//

import SwiftUI
import ObjectMapper
import SwiftyJSON

class SettingVM : NSObject, ObservableObject {
    
    
    @Published private var settingView = SettingView()
    @Published var apiControl = ApiControl()
    @Published var token: String = ""
    @Published var device_detect: String = "iOS"
    @Published var device_token: String = ""
    @Published var isLogout:Bool = false
    @Published var loginM = EmptyModel()
    @State private var showingAlert = false
    
    static let shared = SettingVM()
    
    
    override init() {
        super.init()
        self.token = UserDefaults.standard.string(forKey: Common.UserDefaultKey.TOKEN) ?? ""
        print("init Token : \(self.token)")
//        loginM = GlobalModel.sharedInstance().loginData ?? LoginModel()
        fetchUser()
    }
    
    func fetchUser() {
//        guard let uid = userSession?.uid else { return }
        
//        COLLECTION_USERS.document(uid).getDocument { snapshot, error in
//            if let (errorMessage) = error?.localizedDescription {
//                self.showErrorAlert = true
//                self.errorMessage = errorMessage
//                return
//            }
//
//            guard let user = try? snapshot?.data(as: User.self) else { return }
//            self.currentUser = user
//        }
    }
    
//    func login() {
    func logout() {
        
        let urlString = "\(HttpUrls.URL.FARM_URL)/\(HttpUrls.NAME.LOGOUT)"
        let parameters: [String: Any] = [
            "token" : self.token,
            "email" : UserDefaults.standard.string(forKey: Common.UserDefaultKey.USEREMAIL) ?? ""
//            "email" : GlobalModel.sharedInstance().emailID! as Any
        ]
        print("Paramiter")
        
        NetworkManagerUrlEncoding<LogoutResponse>.fetch(from: urlString, method: .post, parameter: parameters) { result in
            switch result {
            case .success(let response):
                if response.code == nil {
                    self.loginM = response.data!
//                    self.registerToken()
//                    GlobalModel.sharedInstance().loginData = self.loginM
                    GlobalModel.sharedInstance().loadedData = LoadedModel()
                    GlobalModel.sharedInstance().loginData = LoginModel()
                    print("LoginModel : \(self.loginM)")
                    
//                    self.token = self.loginM.token!
//                    print("Token : \(self.token)")
                    
                    UserDefaults.standard.set("N", forKey: Common.UserDefaultKey.AUTOLOGIN)
                    UserDefaults.standard.set("", forKey: Common.UserDefaultKey.USERID)
                    UserDefaults.standard.set("", forKey: Common.UserDefaultKey.USERPW)
                    UserDefaults.standard.set("", forKey: Common.UserDefaultKey.TOKEN)
                    UserDefaults.standard.set("", forKey: Common.UserDefaultKey.USERNAME)
                    UserDefaults.standard.set("", forKey: Common.UserDefaultKey.USEREMAIL)
                    UserDefaults.standard.set("", forKey: Common.UserDefaultKey.SERVER_URL)
                    UserDefaults.standard.set("", forKey: Common.UserDefaultKey.SERVER_NAME)
                    
                    self.settingView.stopLoading()
                    
                    self.isLogout = true
                    
//                    self.unregisterToken()
                }
                else {
                    //에러메시지 출력
                    self.settingView.stopLoading()
                }
            case .failure(let error):
                print(error.localizedDescription)
                self.settingView.stopLoading()
            }
        }
        
//        self.apiControl.requestLogout(url: GlobalModel.sharedInstance().domain! + HttpUrls.NAME.LOGOUT, method: .post, parameter: parameters) { response in
//            switch response.result {
//            case .success(let value):
//                print(value)
//                
//                UserDefaults.standard.set("N", forKey: Common.UserDefaultKey.AUTOLOGIN)
//                UserDefaults.standard.set("", forKey: Common.UserDefaultKey.USERID)
//                UserDefaults.standard.set("", forKey: Common.UserDefaultKey.USERPW)
//                UserDefaults.standard.set("", forKey: Common.UserDefaultKey.USERNAME)
//                UserDefaults.standard.set("", forKey: Common.UserDefaultKey.USEREMAIL)
//                UserDefaults.standard.set("", forKey: Common.UserDefaultKey.SERVER_URL)
//                UserDefaults.standard.set("", forKey: Common.UserDefaultKey.SERVER_NAME)
//                
//                self.settingView.stopLoading()
//                
//            case .failure(let error):
//                self.settingView.stopLoading()
//                print("error : \(error)")
//            }
//        }
    }
    
    //토큰 등록
    func unregisterToken() {
        let urlString = "\(HttpUrls.URL.FARM_URL)/\(HttpUrls.NAME.TOKEN_UNREGISTER)"
//        GlobalModel.sharedInstance().loginData = self.loginM
//        GlobalModel.sharedInstance().emailID = email

//        UserDefaults.standard.set("Y", forKey: Common.UserDefaultKey.AUTOLOGIN)
//        UserDefaults.standard.set(email, forKey: Common.UserDefaultKey.USERID)
//        UserDefaults.standard.set(passwd, forKey: Common.UserDefaultKey.USERPW)
//        UserDefaults.standard.set(GlobalModel.sharedInstance().domain, forKey: Common.UserDefaultKey.SERVER_URL)
//        UserDefaults.standard.set(GlobalModel.sharedInstance().serverName, forKey: Common.UserDefaultKey.SERVER_NAME)
        
        self.settingView.startLoading()


        //디바이스 토큰 등록 추가
        let parameter: [String: Any] = [
            "X-WIMX-TOKEN" : UserDefaults.standard.string(forKey: Common.UserDefaultKey.TOKEN)!,
            "device" : Common.UserDefaultKey.NOTI_OS_TOKEN,
            "token" : UserDefaults.standard.string(forKey: Common.UserDefaultKey.DEVICE_TOKEN)!
        ]
        
        //수정해야함
        NetworkManagerUrlEncodingWT<TokenRegisterResponse>.fetch(from: urlString, method: .post, parameter: parameter, token: self.token) { result in
            switch result {
            case .success(let response):
                if response.code == nil {
                    
                    self.settingView.stopLoading()
                    
                    self.logout()
                }
                else {
                    //에러메시지 출력
                    self.settingView.stopLoading()
//                    self.loginView.showErrorMessage(showAlert: self.showingAlert, message: "\(response.code)")
                }
            case .failure(let error):
                print(error.localizedDescription)
                self.settingView.stopLoading()
            }
        }
    }
}
