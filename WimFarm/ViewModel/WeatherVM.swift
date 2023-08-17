//
//  WeatherVM.swift
//  WimFarm
//
//  Created by ulalalab on 2022/04/01.
//

import Foundation
import SwiftUI
import Combine

class WeatherVM: ObservableObject {
    private var weatherFetcher: WeatherFetcher
    private var disposable = Set<AnyCancellable>()
    
    @Published var searchText: String = "Texas"
    @Published var weatherModel: WeatherModel?
    @Published var weatherM = OneCallResponse.empty()
    
    var currentTempFmt: String {
        guard let temp = weatherModel?.current.actualTemp.fahrenheight else { return "--º" }
        return String(format: "%.0fº", temp)
    }
    
    var feelsLikeTempFmt: String {
        guard let temp = weatherModel?.current.feelsLikeTemp.fahrenheight else { return "--º" }
        return String(format: "%.0fº", temp)
    }
    
    var minTempFmt: String {
        guard let temp = weatherModel?.daily[0].minTemp.fahrenheight else { return "--º" }
        return String(format: "%.0fº", temp)
    }
    
    var maxTempFmt: String {
        guard let temp = weatherModel?.daily[0].maxTemp.fahrenheight else { return "--º" }
        return String(format: "%.0fº", temp)
    }
    
    var currentTempDescription: String {
        guard let description = weatherModel?.current.weatherDetails.first?.weatherDescription else {
            return ""
        }
        return description.localizedCapitalized
    }
    
    var currentWeatherIcon: Image? {
        weatherModel?.current.weatherDetails.first?.weatherIcon
    }
    
    var hourSummaries: [HourlyWeatherViewModel] = []
    var daySummaries: [DailyWeatherViewModel] = []
    
    init (weatherFetcher: WeatherFetcher) {
        self.weatherFetcher = weatherFetcher
        
        getWeather()
    }

//    init(weatherFetcher: WeatherFetcher) {
//        self.weatherFetcher = weatherFetcher
//
//        let searchTextScheduler: DispatchQueue = .init(label: "weatherSearch", qos: .userInteractive)
//        $searchText
//            .dropFirst()
//            .debounce(for: .seconds(0.5),
//                         scheduler: searchTextScheduler)
//            .sink(receiveValue: fetchWeatherModel(forLocation:))
//            .store(in: &disposable)
//
//        fetchWeatherModel(forLocation: searchText)
//    }
    
    func fetchWeatherModel(forLocation location: String) {
        weatherFetcher.weatherModel(forCity: location)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] (value) in
                switch value {
                case .failure(let error):
                    self?.weatherModel = nil
                    self?.hourSummaries = []
                    self?.daySummaries = []
                    print(error)
                case .finished:
                    break
                }
            }) { [weak self] weatherModel in
                self?.weatherModel = weatherModel
                self?.hourSummaries = weatherModel.hourly.map { HourlyWeatherViewModel(hourModel: $0) }
                self?.daySummaries = weatherModel.daily.map { DailyWeatherViewModel(dayModel: $0) }
            }.store(in: &disposable)
    }
    
    func todayInformationViewModel() -> CurrentWeatherViewModel? {
        guard let weatherModel = weatherModel else { return nil }
        return .init(weatherModel: weatherModel.current)
    }
    
    func getWeather() {
        var udLoaded = LoadedModel()
        var units = "standard"
        if let dLoaded = UserDefaults.standard.object(forKey: Common.UserDefaultKey.LOADED) as? Data {
            let decode = JSONDecoder()
            if let savedObject = try? decode.decode(LoadedModel.self, from: dLoaded) {
                print("decoded loaded = \(savedObject)")
                udLoaded = savedObject
            }
        }
        
        self.searchText = udLoaded.companys?.first?.company_address ?? "Company Address"
        let comanyLat = Double(udLoaded.companys?.first?.company_lat ?? "30.3723260")
        let comanyLon = Double(udLoaded.companys?.first?.company_lon ?? "-95.137526")
        
        if udLoaded.companys?.first?.company_language == "en" {
            units = "imperial"
        }
        else {
            units = "metric"
        }
        
//        let urlString = WeatherApi.getCurrentWeatherURL(latitude: 30.3723260, longitude: -95.137526)
        let urlString = WeatherApi.getCurrentWeatherURL(latitude: comanyLat ?? 37.372223, longitude: comanyLon ?? 126.949337, units: units)
        
        guard let url = URL(string: urlString) else {return}
        WeatherNetworkManager<OneCallResponse>.fetchWeather(for: url) { (result) in
            switch result {
                case .success(let response):
                    DispatchQueue.main.async {
                        self.weatherM = response
//                        self.hourSummaries = response.hourly.map { HourlyWeatherViewModel(hourModel: $0) }
//                        self.daySummaries = response.daily.map { DailyWeatherViewModel(dayModel: $0) }
//                        self.hourSummaries = weatherM.hourly.map { HourlyWeatherViewModel(hourModel: $0) }
//                        self.daySummaries = weatherM.daily.map { DailyWeatherViewModel(dayModel: $0) }
                        print("weather response : \(response)")
                    }
                case .failure(let error):
                    print(error)
            }
        }
    }
}

class CurrentWeatherViewModel {
    private let currentModel: WeatherCurrentModel
    
    var sunriseTimeFmt: String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: currentModel.sunriseTime)
    }
    
    var sunsetTimeFmt: String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: currentModel.sunsetTime)
    }
    
    var windSpeed: String {
        let kmh = currentModel.windSpeed
        let mph = kmh / 1.609
        return String(format: "%.0f mi/h", mph)
    }
    
    var windDirection: String {
        currentModel.windDirection
    }
    
    var uvIndex: String {
        String(format: "%.0f", currentModel.uvIndex)
    }
    
    var humidity: String {
        "\(currentModel.humidity)%"
    }
    
    init(weatherModel: WeatherCurrentModel) {
        self.currentModel = weatherModel
    }
}

class HourlyWeatherViewModel: Identifiable {
    private let hourModel: WeatherHourlyModel
    
    var id = UUID()
    
    var tempFmt: String {
        String(format: "%.0fº", hourModel.actualTemp.fahrenheight)
    }
    
    var humidity: String {
        "\(hourModel.humidity)%"
    }
    
    var icon: Image? {
        hourModel.weatherDetails.first?.weatherIcon
    }
    
    var timeFmt: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:00 a"
        return dateFormatter.string(from: hourModel.time)
    }
    
    var timeFmt24: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:00"
        return dateFormatter.string(from: hourModel.time)
    }
    
    init(hourModel: WeatherHourlyModel) {
        self.hourModel = hourModel
    }
}

class DailyWeatherViewModel: Identifiable {
    private let dayModel: WeatherDailyModel
    
    var id = UUID()
    
    var day: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: dayModel.time)
    }
    
    var date: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd"
        return dateFormatter.string(from: dayModel.time)
    }
    
    var highTempFmt: String {
        String(format: "%.0fº", dayModel.maxTemp.fahrenheight)
    }
    
    var lowTempFmt: String {
        String(format: "%.0fº", dayModel.minTemp.fahrenheight)
    }
    
    var icon: Image? {
        dayModel.weatherDetails.first?.weatherIcon
    }
    
    var humidity: String {
        "\(dayModel.humidity)%"
    }
    
    init(dayModel: WeatherDailyModel) {
        self.dayModel = dayModel
    }
}
