//
//  LoginVM.swift
//  WimFarm
//
//  Created by ulalalab on 2022/01/27.
//

import SwiftUI
import ObjectMapper
import SwiftyJSON
import Alamofire

class LoginVM : NSObject, ObservableObject {
    
    
    @Published private var loginView = LoginView()
    @Published var email: String = ""
    @Published var passwd: String = ""
    @Published var token: String = ""
    @Published var device_detect: String = "iOS"
    @Published var device_token: String = ""
    @Published var loginM = LoginModel()
    @State private var showingAlert = false
    
    static let shared = LoginVM()
    
    
    override init() {
        super.init()
        self.token = UserDefaults.standard.string(forKey: Common.UserDefaultKey.TOKEN) ?? ""
        self.email = UserDefaults.standard.string(forKey: Common.UserDefaultKey.USERID) ?? ""
        self.passwd = UserDefaults.standard.string(forKey: Common.UserDefaultKey.USERPW) ?? ""
        print("init login Token : \(self.token)")
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
    func login(withdEmail email: String, password: String) {
        
        let urlString = "\(HttpUrls.URL.FARM_URL)/\(HttpUrls.NAME.LOGIN)"
        let parameters: [String: Any] = [
            "email" : email,
            "passwd" : password,
            "device_detect" : "iOS",
            "device_token" : GlobalModel.sharedInstance().deviceToken ?? "" // 토큰이 없을 시 빈값으로
            
        ]
        
        let headers: HTTPHeaders = [
            "X-SERVER-WIMX": "App",
            "Content-Type": "application/json",
            "X-Requested-With": "XMLHttpRequest"
        ]
        
        loginView.startLoading()
        
        let authRequest = AF.request(urlString,
                                 method: .post,
                                 parameters: parameters,
                                 encoding: JSONEncoding.default,
                                 headers: headers)
        
        authRequest.responseString { response in
            switch response.result {
            case .success(let value):
                print("\(value)")
                print("\(response.data!)")
                print("succes")
            case .failure(let error):
                print("Error while querying database: \(String(describing: error))")
            }
        }
        
        NetworkManagerUrlEncoding<LoginResponse>.fetch(from: urlString, method: .post, parameter: parameters) { result in
            switch result {
            case .success(let response):
                if response.code == nil {
                    self.loginM = response.data!
//                    self.registerToken()
                    GlobalModel.sharedInstance().loginData = self.loginM
                    print("LoginModel : \(self.loginM)")
                    
                    self.email = email
                    self.passwd = password
                    self.token = self.loginM.token!
                    print("Token : \(self.token)")
                    
                    UserDefaults.standard.set("Y", forKey: Common.UserDefaultKey.AUTOLOGIN)
                    UserDefaults.standard.set(email, forKey: Common.UserDefaultKey.USERID)
                    UserDefaults.standard.set(password, forKey: Common.UserDefaultKey.USERPW)
                    UserDefaults.standard.set(self.token, forKey: Common.UserDefaultKey.TOKEN)
                    UserDefaults.standard.set(self.loginM.name, forKey: Common.UserDefaultKey.USERNAME)
                    UserDefaults.standard.set(email, forKey: Common.UserDefaultKey.USEREMAIL)
                    UserDefaults.standard.set(GlobalModel.sharedInstance().domain, forKey: Common.UserDefaultKey.SERVER_URL)
                    UserDefaults.standard.set(GlobalModel.sharedInstance().serverName, forKey: Common.UserDefaultKey.SERVER_NAME)
                    
                    self.loginView.stopLoading()
                    
                    self.registerToken()
                }
                else {
                    //에러메시지 출력
                    self.loginView.stopLoading()
                }
            case .failure(let error):
                print(error.localizedDescription)
                self.loginView.stopLoading()
            }
        }
    }
    
    //토큰 등록
    func registerToken() {
        let urlString = "\(HttpUrls.URL.FARM_URL)/\(HttpUrls.NAME.TOKEN_REGISTER)"
        GlobalModel.sharedInstance().loginData = self.loginM
//        GlobalModel.sharedInstance().emailID = email

//        UserDefaults.standard.set("Y", forKey: Common.UserDefaultKey.AUTOLOGIN)
//        UserDefaults.standard.set(email, forKey: Common.UserDefaultKey.USERID)
//        UserDefaults.standard.set(passwd, forKey: Common.UserDefaultKey.USERPW)
//        UserDefaults.standard.set(GlobalModel.sharedInstance().domain, forKey: Common.UserDefaultKey.SERVER_URL)
//        UserDefaults.standard.set(GlobalModel.sharedInstance().serverName, forKey: Common.UserDefaultKey.SERVER_NAME)
        
        self.loginView.startLoading()


        //디바이스 토큰 등록 추가
        let parameter: [String: Any] = [
            "device" : Common.UserDefaultKey.NOTI_OS_TOKEN,
            "token" : UserDefaults.standard.string(forKey: Common.UserDefaultKey.DEVICE_TOKEN)!
        ]
        
        NetworkManagerUrlEncoding<TokenRegisterResponse>.fetch(from: urlString, method: .post, parameter: parameter) { result in
            switch result {
            case .success(let response):
                if response.code == nil {
                    
                    self.loginView.stopLoading()
                }
                else {
                    //에러메시지 출력
                    self.loginView.stopLoading()
//                    self.loginView.showErrorMessage(showAlert: self.showingAlert, message: "\(response.code)")
                }
            case .failure(let error):
                print(error.localizedDescription)
                self.loginView.stopLoading()
            }
        }
    }

//    func loginOld() {
////        if email.validateEmail() == false {
////            .showAlert(message: "email_not_input")
////        }
////         func requestLogin(url:String, method: HTTPMethod, parameter:Parameters, complateHandle:@escaping (AFDataResponse<Any>)->())
//
//        if email.validateEmail() {
//            loginView.showErrorMessage(showAlert: self.$showingAlert, message: "email_not_input")
//        }
//        else {
//            let parameters: [String: Any] = [
//                "email" : email,
//                "passwd" : passwd,
//                "device_detect" : "iOS",
//                "device_token" : GlobalModel.sharedInstance().deviceToken!
//
//            ]
//
//            ApiControl.shared.requestLogin(url: HttpUrls.URL.FARM_URL + HttpUrls.NAME.LOGIN, method: .post, parameter: parameters) { [self] response in
//                switch response.result {
//                case .success(let value):
//                    print(value)
//                    let resultCode = JSON( (value as AnyObject).object(forKey: "code")! ).description
//
//                    if(resultCode == "login_failure") {
//    //                    .alert(isPresented: $showingAlert) {
//    //                        Alert(title: Text("email_not_input"), message: nil,
//    //                              dismissButton: .default(Text("OK")))
//    //                    }
//                        loginView.showErrorMessage(showAlert: self.$showingAlert, message: "login_failure")
//                        loginView.startLoading()
//    //                    showAlert(message: "login_failure")
//    //                    stopLoading()
//                    }
//                    else {
//                        let resultData = JSON( (value as AnyObject).object(forKey: "data")! ).description
//                        let loginInfo = Mapper<LoginModel>().map(JSONString: resultData)
//                        GlobalModel.sharedInstance().loginData = loginInfo
//
//                        GlobalModel.sharedInstance().emailID = email
//
//                        UserDefaults.standard.set("Y", forKey: Common.UserDefaultKey.AUTOLOGIN)
//                        UserDefaults.standard.set(email, forKey: Common.UserDefaultKey.USERID)
//                        UserDefaults.standard.set(passwd, forKey: Common.UserDefaultKey.USERPW)
//                        UserDefaults.standard.set(GlobalModel.sharedInstance().domain, forKey: Common.UserDefaultKey.SERVER_URL)
//                        UserDefaults.standard.set(GlobalModel.sharedInstance().serverName, forKey: Common.UserDefaultKey.SERVER_NAME)
//
//        //                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        //                let mainVC = storyboard.instantiateViewController(withIdentifier: "mainVC") as! MainVC
//        //                let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        //                let containerViewController = ContainerViewController()
//        //                appDelegate.window?.rootViewController = containerViewController
//        //                self.navigationController?.pushViewController(mainVC, animated: false)
//
//                        loginView.stopLoading()
//
//                        //디바이스 토큰 등록 추가
//                        let parameter2: [String: Any] = [
//                            "device" : "iOS",
//                            "token" : UserDefaults.standard.string(forKey: Common.UserDefaultKey.TOKEN)!
//                        ]
//
//                        ApiControl.shared.requestTokenRegister(url: HttpUrls.URL.FARM_URL + HttpUrls.NAME.TOKEN_REGISTER, method: .post, parameter: parameter2) { [self] response in
//                            switch response.result {
//                            case .success(let value):
//                                print(value)
//
//    //                            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//    //                            let mainVC = storyboard.instantiateViewController(withIdentifier: "mainVC") as! MainVC
//    //                            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//    //                            let containerViewController = ContainerViewController()
//    //                            appDelegate.window?.rootViewController = containerViewController
//    //                            self.navigationController?.pushViewController(mainVC, animated: false)
//
//                                NavigationLink(destination: MainTabView()
//                                                .navigationBarHidden(true)
//                                                .navigationBarBackButtonHidden(true)
//                                                .edgesIgnoringSafeArea(.top)
//                                                .navigationBarTitleDisplayMode(.inline)) { EmptyView() }
//                                loginView.stopLoading()
//
//                            case .failure(let error):
//                                loginView.stopLoading()
//                                print("error : \(error)")
//                            }
//                    }
//
//                    }
//
//                case .failure(let error):
//                    loginView.stopLoading()
//                    print("error : \(error)")
//                }
//
//            }
//        }
//    }
    
}

