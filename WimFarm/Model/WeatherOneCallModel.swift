//
//  WeatherOneCallModel.swift
//  WimFarm
//
//  Created by ulalalab on 2022/04/01.
//

import Foundation

// MARK: - OneCallResponse
struct OneCallResponse: Codable {
    let lat, lon: Double
    let timezone: String
    let current: CurrentResponse
    let hourly: [HourlyResponse]
    let daily: [DailyResponse]
    
    
    //추가
    static func empty() -> OneCallResponse {
        OneCallResponse(
            lat : 0.0,
            lon : 0.0,
            timezone : "",
            current: CurrentResponse(),
            hourly: [HourlyResponse](repeating: HourlyResponse(),
                              count: 24),
            daily: [DailyResponse](repeating: DailyResponse(),
                                  count: 8)
        )
    }
}

// MARK: - CurrentResponse
struct CurrentResponse: Codable, Identifiable {
    let id = UUID()
    let dt, sunrise, sunset: Int
    let temp, feelsLike: Double
    let pressure, humidity: Int
    let uvi: Double
    let clouds, visibility: Int?
    let windSpeed: Double
    let windDeg: Int
    let weather: [WeatherResponse]
    let rain: RainResponse?

    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, temp
        case feelsLike = "feels_like"
        case pressure, humidity, uvi, clouds, visibility
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case weather, rain
    }
    
    init() {
        dt = 0
        sunrise = 0
        sunset = 0
        temp = 0.0
        feelsLike = 0.0
        pressure = 0
        humidity = 0
        uvi = 0.0
        clouds = 0
        visibility = 0
        windSpeed = 0.0
        windDeg = 0
        weather = []
        rain = RainResponse(the1H: 0.0)
    }
}

// MARK: - RainResponse
struct RainResponse: Codable {
    let the1H: Double?

    enum CodingKeys: String, CodingKey {
        case the1H = "1h"
    }
}

// MARK: - WeatherResponse
struct WeatherResponse: Codable, Identifiable {
    let id: Int
    let main, weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
    
    init() {
        id = 0
        main = ""
        weatherDescription = ""
        icon = ""
    }
}

// MARK: - DailyResponse
struct DailyResponse: Codable, Identifiable {
    let id = UUID()
    let dt, sunrise, sunset: Int
    let temp: TempResponse
    let feelsLike: FeelsLikeResponse
    let pressure, humidity: Int
    let windSpeed: Double
    let windDeg: Int
    let weather: [WeatherResponse]
    let clouds: Int
    let rain: Double?
    let uvi: Double

    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, temp
        case feelsLike = "feels_like"
        case pressure, humidity
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case weather, clouds, rain, uvi
    }
    
    
    
    init() {
        dt = 0
        sunrise = 0
        sunset = 0
        temp = TempResponse(day: 0.0, min: 0.0, max: 0.0, night: 0.0, eve: 0.0, morn: 0.0)
        feelsLike = FeelsLikeResponse(day: 0.0, night: 0.0, eve: 0.0, morn: 0.0)
        pressure = 0
        humidity = 0
        windSpeed = 0.0
        windDeg = 0
        weather = []
        clouds = 0
        rain = 0.0
        uvi = 0.0
    }
}

// MARK: - FeelsLikeResponse
struct FeelsLikeResponse: Codable {
    let day, night, eve, morn: Double
}

// MARK: - TempResponse
struct TempResponse: Codable {
    let day, min, max, night: Double
    let eve, morn: Double
}

// MARK: - HourlyResponse
struct HourlyResponse: Codable, Identifiable {
    let id = UUID()
    let dt: Int
    let temp, feelsLike: Double
    let pressure, humidity, clouds: Int
    let windSpeed: Double
    let windDeg: Int
    let weather: [WeatherResponse]
    let rain: RainResponse?

    enum CodingKeys: String, CodingKey {
        case dt, temp
        case feelsLike = "feels_like"
        case pressure, humidity, clouds
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case weather, rain
    }
    
    init() {
        dt = 0
        temp = 0.0
        feelsLike = 0.0
        pressure = 0
        humidity = 0
        clouds = 0
        windSpeed = 0.0
        windDeg = 0
        weather = []
        rain = RainResponse(the1H: 0.0)
    }
}
