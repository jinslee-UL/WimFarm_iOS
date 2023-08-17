//
//  NetworkManager.swift
//  WimFarm
//
//  Created by ulalalab on 2022/02/21.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case invalidResponse
    case invalidData
    case nilResponse
    case decodingError(err: String)
    case error(err: String)
}

final class NetworkManagerUrlEncoding<T: Codable> {
    
    static func fetch(
        from urlString: String, method: HTTPMethod, parameter: Parameters,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        let headers: HTTPHeaders = [
            "X-SERVER-WIMX": "App",
            "Content-Type": "application/x-www-form-urlencoded",
            "X-Requested-With": "XMLHttpRequest"
        ]
        
        AF.request(urlString, method: method, parameters: parameter, encoding: URLEncoding.default, headers: headers)
            .responseDecodable(of: T.self) { response in
                if let error = response.error {
                    completion(.failure(.invalidResponse))
                    print(error.localizedDescription)
                    return
                }
                if let payload = response.value {
                    completion(.success(payload))
                    return
                }
                completion(.failure(.nilResponse))
            }
    }
}

final class NetworkManagerJSONEncoding<T: Codable> {
    
    static func fetch(
        from urlString: String, method: HTTPMethod, parameter: Parameters,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        
        let headers: HTTPHeaders = [
            "X-SERVER-WIMX": "App",
            "Content-Type": "application/x-www-form-urlencoded",
            "X-Requested-With": "XMLHttpRequest"
        ]
        
        AF.request(urlString, method: method, parameters: parameter, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: T.self) { response in
                if let error = response.error {
                    completion(.failure(.invalidResponse))
                    print(error.localizedDescription)
                    return
                }
                if let payload = response.value {
                    completion(.success(payload))
                    return
                }
                completion(.failure(.nilResponse))
            }
    }
}

final class NetworkManagerUrlEncodingWT<T: Codable> {
    
    static func fetch(
        from urlString: String, method: HTTPMethod, parameter: Parameters, token: String,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        
        let headers: HTTPHeaders = [
            "X-SERVER-WIMX": "App",
            "Content-Type": "application/x-www-form-urlencoded",
            "X-Requested-With": "XMLHttpRequest",
            "X-WIMX-TOKEN" : token
        ]
        
        AF.request(urlString, method: method, parameters: parameter, encoding: URLEncoding.default, headers: headers)
            .responseDecodable(of: T.self) { response in
                if let error = response.error {
                    completion(.failure(.invalidResponse))
                    print(error.localizedDescription)
                    return
                }
                if let payload = response.value {
                    completion(.success(payload))
                    return
                }
                completion(.failure(.nilResponse))
            }
    }
}

final class NetworkManagerJSONEncodingWT<T: Codable> {
    
    static func fetch(
        from urlString: String, method: HTTPMethod, parameter: Parameters, token: String,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        
        let headers: HTTPHeaders = [
            "X-SERVER-WIMX": "App",
            "Content-Type": "application/x-www-form-urlencoded",
            "X-Requested-With": "XMLHttpRequest",
            "X-WIMX-TOKEN" : token
        ]
        
        AF.request(urlString, method: method, parameters: parameter, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: T.self) { response in
                if let error = response.error {
                    completion(.failure(.invalidResponse))
                    print(error.localizedDescription)
                    return
                }
                if let payload = response.value {
                    completion(.success(payload))
                    return
                }
                completion(.failure(.nilResponse))
            }
    }
}

final class NetworkManager<T: Codable> {
    static func fetch(
        from urlString: String,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        AF.request(urlString)
            .responseDecodable(of: T.self) { response in
                if let error = response.error {
                    completion(.failure(.invalidResponse))
                    print(error.localizedDescription)
                    return
                }
                if let payload = response.value {
                    completion(.success(payload))
                    return
                }
                completion(.failure(.nilResponse))
            }
    }
}

final class NetworkManagerUrlEncodingNothing<T: Codable> {
    
    static func fetch(
        from urlString: String, method: HTTPMethod,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Connection": "keep-alive"
        ]
        
        AF.request(urlString, method: method, encoding: URLEncoding.default, headers: headers)
            .responseDecodable(of: T.self) { response in
                if let error = response.error {
                    completion(.failure(.invalidResponse))
                    print(error.localizedDescription)
                    return
                }
                if let payload = response.value {
                    completion(.success(payload))
                    return
                }
                completion(.failure(.nilResponse))
            }
    }
}

final class NetworkManagerUrlEncodingWithoutParam<T: Codable> {
    
    static func fetch(
        from urlString: String, method: HTTPMethod, token: String,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        
        let headers: HTTPHeaders = [
            "X-SERVER-WIMX": "App",
            "Content-Type": "application/x-www-form-urlencoded",
            "X-Requested-With": "XMLHttpRequest",
            "X-WIMX-TOKEN" : token
        ]
        
        AF.request(urlString, method: method, encoding: URLEncoding.default, headers: headers)
            .responseDecodable(of: T.self) { response in
                if let error = response.error {
                    completion(.failure(.invalidResponse))
                    print(error.localizedDescription)
                    return
                }
                if let payload = response.value {
                    completion(.success(payload))
                    return
                }
                completion(.failure(.nilResponse))
            }
    }
}

final class NetworkManagerUrlEncodingUTF8<T: Codable> {
    
    static func fetch(
        from urlString: String, method: HTTPMethod, parameter: Parameters, token: String,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        
        let headers: HTTPHeaders = [
            "X-SERVER-WIMX": "App",
            "Content-Type": "application/json;charset=UTF-8",
            "X-Requested-With": "XMLHttpRequest",
            "X-WIMX-TOKEN" : token
        ]
        
        AF.request(urlString, method: method, parameters: parameter, encoding: URLEncoding.default, headers: headers)
            .responseDecodable(of: T.self) { response in
                if let error = response.error {
                    completion(.failure(.invalidResponse))
                    print(error.localizedDescription)
                    return
                }
                if let payload = response.value {
                    completion(.success(payload))
                    return
                }
                completion(.failure(.nilResponse))
            }
    }
}

final class NetworkManagerJSONEncodingUTF8<T: Codable> {
    
    static func fetch(
        from urlString: String, method: HTTPMethod, parameter: Parameters, token: String,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        
        let headers: HTTPHeaders = [
            "X-SERVER-WIMX": "App",
            "Content-Type": "application/json;charset=UTF-8",
            "X-Requested-With": "XMLHttpRequest",
            "X-WIMX-TOKEN" : token
        ]
        
        AF.request(urlString, method: method, parameters: parameter, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: T.self) { response in
                print("response??? = \(response)")
                if let error = response.error {
                    completion(.failure(.invalidResponse))
                    print(error.localizedDescription)
                    return
                }
                if let payload = response.value {
                    completion(.success(payload))
                    return
                }
                completion(.failure(.nilResponse))
            }
    }
}

final class AlarmPastNetworkManager<T: Codable> {
    static func fetchAlarmPast(for url: URL, completion: @escaping (Result<T, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard error == nil else {
                print(String(describing: error))
                if let error = error?.localizedDescription {
                    completion(.failure(.error(err: error)))
                }
                return
            }
            print("print data = \(data)")
            
            do {
                let json = try JSONDecoder().decode(T.self, from: data)
                completion(.success(json))
            } catch let err {
                print(String(describing: err))
                completion(.failure(.decodingError(err: err.localizedDescription)))
            }
        }.resume()
    }
}
