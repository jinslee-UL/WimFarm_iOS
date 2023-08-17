//
//  WeatherApi.swift
//  WimFarm
//
//  Created by ulalalab on 2023/05/16.
//

import Foundation

struct WeatherApi {
    static let key = HttpUrls.NAME.WEATHER_KEY
}

extension WeatherApi {
    static let baseURL = HttpUrls.URL.WEATHER_API_URL

    static func getCurrentWeatherURL(latitude: Double, longitude: Double, units: String) -> String {
        let excludeFields = "minutely"
        return "\(baseURL)/onecall?lat=\(latitude)&lon=\(longitude)&appid=\(key)&exclude=\(excludeFields)&units=\(units)"
    }
}

final class WeatherNetworkManager<T: Codable> {
    static func fetchWeather(for url: URL, completion: @escaping (Result<T, NetworkError>) -> Void) {
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

//enum NetworkError: Error {
//    case invalidResponse
//    case invalidData
//    case decodingError(err: String)
//    case error(err: String)
//}
