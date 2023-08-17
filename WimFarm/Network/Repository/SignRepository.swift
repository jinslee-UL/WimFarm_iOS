//
//  SignRepository.swift
//  WimFarm
//
//  Created by ulalalab on 2021/12/13.
//

import Foundation
import Alamofire

class SignRepository {
    
//    func getData() {
//        let request = AF.request("https://northwind.vercel.app/api/categories")
//
//        request.responseJSON { data in
//            print(data)
//        }.
//    }
//
//    func getAll(completionHandler: @escaping ([CategoryModel]) -> Void) {
//        let request = AF.request("https://northwind.vercel.app/api/categories")
//
//        request.responseDecodable(of: [CategoryModel].self) { response in
//            completionHandler(response.value!)
//        }
//    }
    
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
}
