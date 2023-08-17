//
//  WeatherView.swift
//  WimFarm
//
//  Created by ulalalab on 2022/03/11.
//

import SwiftUI
import MapKit

struct WeatherView: View {
    @EnvironmentObject private var screenRouter: ScreenRouter
    @ObservedObject var viewModel: WeatherVM
    
    init(viewModel: WeatherVM) {
        self.viewModel = viewModel
    }
    
//    func getWeather() {
//        self.viewModel.fetchWeatherModel(forGeo: <#T##String#>)
//    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.colorWFGrayBG.ignoresSafeArea(.all)
    //            Color(.systemBackground)
    //                .edgesIgnoringSafeArea(.all)
                
                ScrollView(.vertical, showsIndicators: false) {
//                    VStack(spacing: 32) {
                    if self.viewModel != nil {
                        VStack(alignment: .leading, spacing: 10) {
                            currentWeatherView
                                .padding(EdgeInsets(top:10, leading: 10, bottom: 0, trailing: 10))
                            Divider()
                            //                        viewModel.todayInformationViewModel() != nil ?
                            //                        CurrentWeatherView(viewModel: viewModel.todayInformationViewModel()!) : nil
                            Text("시간대별 온도 / 습도")
                                .foregroundColor(Color.colorWFTextEmpty)
                                .padding(10)
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    //                                ForEach(viewModel.hourSummaries) { viewModel in
                                    //                                    HourWeatherView(viewModel: viewModel)
                                    //                                }
                                    ForEach(viewModel.weatherM.hourly) { viewModel in
                                        HourWeatherView(viewModel: viewModel)
                                    }
                                }
                                .padding(EdgeInsets(top:0, leading: 10, bottom: 0, trailing: 10))
                            }
                            Divider()
                            Text("일별 최저/최고 온도, 습도")
                                .foregroundColor(Color.colorWFTextEmpty)
                                .padding(10)
                            VStack {
                                //                            ForEach(viewModel.daySummaries) { viewModel in
                                //                                DayWeatherView(viewModel: viewModel)
                                //                            }
                                ForEach(viewModel.weatherM.daily) { viewModel in
                                    DayWeatherView(viewModel: viewModel)
                                }
                            }
                            .padding(EdgeInsets(top:0, leading: 10, bottom: 0, trailing: 10))
                        }
                        .padding(EdgeInsets(top:0, leading: 0, bottom: 10, trailing: 0))
                        .cornerRadius(10)
                        .background(Color.colorWFWhite)
                    }
                }
                    .cornerRadius(10)
                    .padding(EdgeInsets(top:80, leading: 10, bottom: 60, trailing: 10))
    //        }.onTapGesture {
    //            UIApplication.shared.endEditing()
            }
            .onAppear {
//                getWeather()
            }
            .background(Color.colorWFGrayBG.ignoresSafeArea())
            .navigationBarHidden(false)
    //            .navigationTitle(Text("weather"))
    //            .foregroundColor(Color.colorUlala)
            .navigationBarBackButtonHidden(true)
            .edgesIgnoringSafeArea(.top)
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarTitleDisplayMode(.inline)
            .toolbar() {
                ToolbarItem(placement: .principal) {
                    Text("weather")
                        .foregroundColor(Color.colorWFTextBlack)
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Image("btnClose")
                        .onTapGesture {
                            screenRouter.currentPage = screenRouter.exPage
                        }
                }
            }
        }
        
    }
    
    private var currentWeatherView: some View {
//        if let _ = viewModel.weatherModel {
        if !viewModel.weatherM.current.weather.isEmpty {
            return AnyView(HStack {
                VStack(spacing: 4) {
//                    Text(viewModel.currentTempDescription)
//                    Text("\(viewModel.weatherM.current.weather.first?.weatherDescription ?? "")")
                    Text("\(viewModel.searchText)")
                        .font(.headline)
                        .fontWeight(.medium)
                        .foregroundColor(Color.colorWFTextBlack)
                    HStack {
//                        viewModel.currentWeatherIcon
                        Image(getSWIcon(icon: viewModel.weatherM.current.weather.first?.icon ?? ""))
                            .imageScale(.small)
                            .foregroundColor(.colorWFTextBlack)
//                        Text("\(viewModel.currentTempFmt)")
                        Text("\(String(format: "%.1f", viewModel.weatherM.current.temp))º")
                            .foregroundColor(Color.colorWFTextBlack)
                            .fontWeight(.semibold)
                    }.font(.system(size: 64))
                        .frame(maxWidth: .infinity)
                    HStack {
//                        Text("Feels like \(viewModel.feelsLikeTempFmt)")
//                            .foregroundColor(Color.colorWFTextBlack)
                        Text("lowest")
                            .foregroundColor(Color.colorWFTextBlack)
//                        Text("\(viewModel.minTempFmt)")
                        Text("\(String(format: "%.1f", viewModel.weatherM.daily.first?.temp.min ?? 0.0))º")
                            .foregroundColor(Color.colorWFTextBlack)
                        Text(" / ")
                            .foregroundColor(Color.colorWFTextBlack)
                        Text("best")
                            .foregroundColor(Color.colorWFTextBlack)
//                        Text("\(viewModel.maxTempFmt)")
                        Text("\(String(format: "%.1f", viewModel.weatherM.daily.first?.temp.max ?? 0.0))º")
                            .foregroundColor(Color.colorWFTextBlack)
                    }
                }
                .padding(20)
            })
        } else {
            return AnyView(EmptyView())
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["en", "ko"], id: \.self) { id in
//            WeatherView(viewModel: WeatherVM())
            WeatherView(viewModel: WeatherVM(weatherFetcher: MockWeatherFetcher()))
                .environment(\.locale, .init(identifier: id))
        }
        
    }
}

struct CurrentWeatherView: View {
//  private let viewModel: CurrentWeatherViewModel
  private let viewModel: CurrentResponse
  
//  init(viewModel: CurrentWeatherViewModel) {
  init(viewModel: CurrentResponse) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    VStack {
      ZStack {
        HStack {
          VStack(alignment: .leading) {
//            detailView(text: viewModel.sunriseTimeFmt,
              detailView(text: "\(viewModel.sunrise)",
                       image: .init(systemName: "sunrise"),
                       offset: .init(width: 0, height: -2))
            
//            detailView(text: viewModel.sunsetTimeFmt,
            detailView(text: "\(viewModel.sunset)",
                       image: .init(systemName: "sunset"),
                       offset: .init(width: 0, height: -2))
          }
          Spacer()
        }
        VStack(alignment: .leading) {
//          detailView(text: "UV: \(viewModel.uvIndex)",
          detailView(text: "UV: \(viewModel.uvi)",
                     image: .init(systemName: "sun.max"))
          
          detailView(text: "\(viewModel.humidity)",
                     image: .init(systemName: "thermometer.sun"))
        }
        
        HStack {
          Spacer()
          VStack(alignment: .leading) {
            detailView(text: "\(viewModel.windSpeed)",
                       image: .init(systemName: "wind"))
            
//            detailView(text: viewModel.windDirection,
            detailView(text: "\(viewModel.windDeg)",
                       image: .init(systemName: "arrow.up.right.circle"))
          }
        }
      }
    }
  }
  
  private func detailView(text: String, image: Image, offset: CGSize = .zero) -> some View {
    HStack {
      image
        .imageScale(.medium)
        .foregroundColor(.blue)
        .offset(offset)
      Text(text)
    }
  }
}

struct HourWeatherView: View {
//  private let viewModel: HourlyWeatherViewModel
//  
//  init(viewModel: HourlyWeatherViewModel) {
//      self.viewModel = viewModel
//  }
  private let viewModel: HourlyResponse
  
  init(viewModel: HourlyResponse) {
      self.viewModel = viewModel
  }
  
  var body: some View {
    VStack(spacing: 4) {
        Text("\(getTimeHHMM(date: Date(timeIntervalSince1970: TimeInterval(viewModel.dt))))")
            .foregroundColor(Color.colorWFTextBlack)
            .font(.caption)
            .fontWeight(.medium)
            .layoutPriority(1)
            .fixedSize()
        Image(getSWIcon(icon:viewModel.weather.first?.icon ?? ""))
            .resizable()
            .frame(width: 23.0, height: 23.0)
            .foregroundColor(Color.colorWFTextBlack)
        Text("\(String(format: "%.1f", viewModel.temp))º")
            .foregroundColor(Color.colorWFTextBlack)
            .font(.caption)
            .fontWeight(.medium)
        Text("\(viewModel.humidity)%")
            .foregroundColor(Color.colorWFTextBlack)
            .font(.caption)
            .fontWeight(.medium)
    }.padding(10)
          .background(Color.colorWFWhite)
//      .background(Color.init(.secondarySystemBackground))
//      .cornerRadius(10)
  }
}

struct DayWeatherView: View {
//  private let viewModel: DailyWeatherViewModel
//
//  init(viewModel: DailyWeatherViewModel) {
//    self.viewModel = viewModel
//  }
  private let viewModel: DailyResponse
  
  init(viewModel: DailyResponse) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    HStack  {
        Text("\(getTimeMMDD(date:Date(timeIntervalSince1970: TimeInterval(viewModel.dt))))")
            .foregroundColor(Color.colorWFTextBlack)
            .fontWeight(.medium)
        Spacer()
//        Text("\(round(viewModel.temp.max*10)/10)º / \(round(viewModel.temp.min*10)/10)º")
        Text("\(String(format: "%.1f", viewModel.temp.max))º / \(String(format: "%.1f", viewModel.temp.min))º")
            .foregroundColor(Color.colorWFTextBlack)
            .fontWeight(.light)
        Spacer()
        Image(getSWIcon(icon: viewModel.weather.first?.icon ?? ""))
            .resizable()
            .frame(width: 23.0, height: 23.0)
            .foregroundColor(Color.colorWFTextBlack)
        Spacer()
        Text("\(viewModel.humidity)%")
            .foregroundColor(Color.colorWFTextBlack)
            .fontWeight(.medium)
        }.padding(.horizontal)
          .background(Color.colorWFWhite)
          .padding(.vertical, 4)
//          .background(Color.init(.secondarySystemBackground))
//          .cornerRadius(10)
    }
}


func getWIcon(icon: String) -> String {
    
    switch icon {
        case "01d": return "iconSunny"
        case "01n": return "iconMoon"
        case "02d": return "iconOvercastDay"
        case "02n": return "iconOvercastNight"
        case "03d", "03n", "04d", "04n": return "iconCloud"
        case "09d", "09n": return "iconRainy"
        case "10d", "10n": return "iconDrizzle"
        case "11d", "11n": return "iconThunder"
        case "13d", "13n": return "iconSnow"
        case "50d", "50n": return "iconFog"
        default: return "iconSunny"
    }
}

func getSWIcon(icon: String) -> String {
    
    switch icon {
        case "01d": return "iconSunny"
        case "01n": return "iconMoon"
        case "02d": return "iconOvercastDay"
        case "02n": return "iconOvercastNight"
        case "03d", "03n", "04d", "04n": return "iconCloud"
        case "09d", "09n": return "iconRainy"
        case "10d", "10n": return "iconDrizzle"
        case "11d", "11n": return "iconThunder"
        case "13d", "13n": return "iconSnow"
        case "50d", "50n": return "iconFog"
        default: return "iconSunny"
    }
}

func getTimeHHMM(date: Date) -> String {
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm"
    
    let mmhhDate: String = dateFormatter.string(from: date)
    
    return mmhhDate
}

func getTimeMMDD(date: Date) -> String {
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM/dd"
    
    let mmhhDate: String = dateFormatter.string(from: date)
    
    return mmhhDate
}
