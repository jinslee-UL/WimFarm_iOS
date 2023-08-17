//
//  MockWeatherModel.swift
//  WimFarm
//
//  Created by ulalalab on 2022/04/01.
//

import Foundation

#if DEBUG
extension WeatherModel {
  static func createMock() -> WeatherModel {
    let path = Bundle.main.path(forResource: "MockWeatherOneCallResponse", ofType: "json")!
    let url = URL(fileURLWithPath: path)
    let data = try! Data(contentsOf: url)
    let response = try! JSONDecoder().decode(OneCallResponse.self, from: data)
    return WeatherModel.convert(fromResponse: response)
  }
}
#endif

