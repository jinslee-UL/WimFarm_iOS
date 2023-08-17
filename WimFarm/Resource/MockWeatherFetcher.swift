//
//  MockWeatherFetcher.swift
//  WimFarm
//
//  Created by ulalalab on 2022/04/01.
//

import Foundation
import Combine

class MockWeatherFetcher: WeatherFetcher {
    func weatherModel(forCity city: String) -> AnyPublisher<WeatherModel, WeatherError> {
        return Just(WeatherModel.createMock())
          .setFailureType(to: WeatherError.self)
          .eraseToAnyPublisher()
    }
}
