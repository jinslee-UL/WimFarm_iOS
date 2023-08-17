//
//  ApiControl.swift
//  WimFarm
//
//  Created by ulalalab on 2022/02/14.
//

import UIKit
import Foundation
import Alamofire

class ApiControl {
    static let shared = ApiControl()
    
    func requestGetLanguage(url:String, method: HTTPMethod, complateHandle:@escaping (AFDataResponse<Any>)->())
    {
        let headers: HTTPHeaders = [
            "X-SERVER-WIMX": "App",
            "Content-Type": "application/x-www-form-urlencoded",
            "X-Requested-With": "XMLHttpRequest",
        ]
        
        AF.request(url, method: method, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            print("Requesturl : \(url)")
            switch response.result {
                case .success( _):
                    print("👌🏻Response : \n\(response)")
                    complateHandle(response)
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    func requestServerList(url:String, method: HTTPMethod, complateHandle:@escaping (AFDataResponse<Any>)->())
    {
        let headers: HTTPHeaders = [
            "X-SERVER-WIMX": "App",
            "Content-Type": "application/x-www-form-urlencoded",
            "X-Requested-With": "XMLHttpRequest",
        ]
        
        AF.request(url, method: method, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            print("Requesturl : \(url)")
            switch response.result {
                case .success( _):
                    print("👌🏻Response : \n\(response)")
                    complateHandle(response)
                case .failure(let error):
                    print(error)
            }
        }
    }
   
    func requestLogin(url:String, method: HTTPMethod, parameter:Parameters, complateHandle:@escaping (AFDataResponse<Any>)->())
    {
        let headers: HTTPHeaders = [
            "X-SERVER-WIMX": "App",
            "Content-Type": "application/x-www-form-urlencoded",
            "X-Requested-With": "XMLHttpRequest"
        ]
        
        AF.request(url, method: method, parameters: parameter, encoding: URLEncoding.default, headers: headers).responseJSON { response in
            print("Requesturl : \(url)")
            switch response.result {
                case .success( _):
                    print("👌🏻Response : \n\(response)")
                    complateHandle(response)
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    func requestPWSearch(url:String, method: HTTPMethod, parameter:Parameters, complateHandle:@escaping (AFDataResponse<Any>)->())
    {
        let headers: HTTPHeaders = [
            "X-SERVER-WIMX": "App",
            "Content-Type": "application/x-www-form-urlencoded",
            "X-Requested-With": "XMLHttpRequest",
        ]
        
        AF.request(url, method: method, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            print("Requesturl : \(url)")
            switch response.result {
                case .success( _):
                    print("👌🏻Response : \n\(response)")
                    complateHandle(response)
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    func requestLogout(url:String, method: HTTPMethod, parameter:Parameters, complateHandle:@escaping (AFDataResponse<Any>)->())
    {
        let headers: HTTPHeaders = [
            "X-SERVER-WIMX": "App",
            "Content-Type": "application/x-www-form-urlencoded",
            "X-Requested-With": "XMLHttpRequest"
        ]
        
        AF.request(url, method: method, parameters: parameter, encoding: URLEncoding.default, headers: headers).responseJSON { response in
            print("Requesturl : \(url)")
            switch response.result {
                case .success( _):
                    print("👌🏻Response : \n\(response)")
                    complateHandle(response)
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    func requestDashList(url:String, method: HTTPMethod, complateHandle:@escaping (AFDataResponse<Any>)->())
    {
        let headers: HTTPHeaders = [
            "X-SERVER-WIMX": "App",
            "Content-Type": "application/x-www-form-urlencoded",
            "X-Requested-With": "XMLHttpRequest",
        ]
        
        AF.request(url, method: method, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            print("Requesturl : \(url)")
            switch response.result {
                case .success( _):
//                    print("👌🏻Response : \n\(response)")
                    complateHandle(response)
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    func requestDashPacket(url:String, method: HTTPMethod, complateHandle:@escaping (AFDataResponse<Any>)->())
    {
        let headers: HTTPHeaders = [
            "X-SERVER-WIMX": "App",
            "Content-Type": "application/x-www-form-urlencoded",
            "X-Requested-With": "XMLHttpRequest",
        ]
        
        AF.request(url, method: method, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            print("Requesturl : \(url)")
            switch response.result {
                case .success( _):
//                    print("👌🏻Response : \n\(response)")
                    complateHandle(response)
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    func requestAlarm(url:String, method: HTTPMethod, parameter:Parameters, complateHandle:@escaping (AFDataResponse<Any>)->())
    {
        let headers: HTTPHeaders = [
            "X-SERVER-WIMX": "App",
            "Content-Type": "application/x-www-form-urlencoded",
            "X-Requested-With": "XMLHttpRequest"
        ]
        
        AF.request(url, method: method, parameters: parameter, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            print("Requesturl : \(url)")
            switch response.result {
                case .success( _):
//                    print("👌🏻Response : \n\(response)")
                    complateHandle(response)
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    func requestNotice(url:String, method: HTTPMethod, complateHandle:@escaping (AFDataResponse<Any>)->())
    {
        let headers: HTTPHeaders = [
            "X-SERVER-WIMX": "App",
            "Content-Type": "application/x-www-form-urlencoded",
            "X-Requested-With": "XMLHttpRequest",
        ]
        
        AF.request(url, method: method, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            print("Requesturl : \(url)")
            switch response.result {
                case .success( _):
//                    print("👌🏻Response : \n\(response)")
                    complateHandle(response)
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    func requestTokenRegister(url:String, method: HTTPMethod, parameter:Parameters, complateHandle:@escaping (AFDataResponse<Any>)->())
    {
        let headers: HTTPHeaders = [
            "X-SERVER-WIMX": "App",
            "Content-Type": "application/x-www-form-urlencoded",
            "X-Requested-With": "XMLHttpRequest"
        ]
        
        AF.request(url, method: method, parameters: parameter, encoding: URLEncoding.default, headers: headers).responseJSON { response in
            print("Requesturl : \(url)")
            switch response.result {
                case .success( _):
                    print("👌🏻Response : \n\(response)")
                    complateHandle(response)
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    func requestTokenUnRegister(url:String, method: HTTPMethod, parameter:Parameters, complateHandle:@escaping (AFDataResponse<Any>)->())
    {
        let headers: HTTPHeaders = [
            "X-SERVER-WIMX": "App",
            "Content-Type": "application/x-www-form-urlencoded",
            "X-Requested-With": "XMLHttpRequest"
        ]
        
        AF.request(url, method: method, parameters: parameter, encoding: URLEncoding.default, headers: headers).responseJSON { response in
            print("Requesturl : \(url)")
            switch response.result {
                case .success( _):
                    print("👌🏻Response : \n\(response)")
                    complateHandle(response)
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    func apiRequest(url:String, parameter:Parameters, complateHandle:@escaping (AFDataResponse<Any>)->())
    {
        let tokenValue = GlobalModel.sharedInstance().loginData?.token
        let headers: HTTPHeaders = [
            "X-SERVER-WIMX": "App",
            "Content-Type": "application/x-www-form-urlencoded",
            "X-Requested-With": "XMLHttpRequest",
            "X-WIMX-TOKEN":tokenValue!
        ]
        
        AF.request(url, method: .post, parameters: parameter, encoding: URLEncoding.default, headers: headers).responseJSON { response in
            print("Requesturl : \(url)")
            switch response.result {
                case .success( _):
//                    print("👌🏻Response : \(response)")
                    complateHandle(response)
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    func apiTestRequest(url:String, token:String, complateHandle:@escaping (AFDataResponse<Any>)->())
    {
        let headers: HTTPHeaders = [
            "X-SERVER-WIMX": "App",
            "Content-Type": "application/x-www-form-urlencoded",
            "X-Requested-With": "XMLHttpRequest",
            "X-WIMX-TOKEN": token
        ]
        
        AF.request(url, method: .post, parameters: nil, encoding: URLEncoding.default, headers: headers).responseJSON { response in
            print("Requesturl : \(url)")
            switch response.result {
                case .success( _):
//                    print("👌🏻Response : \(response)")
                    complateHandle(response)
                case .failure(let error):
                    print(error)
            }
        }
    }
}
