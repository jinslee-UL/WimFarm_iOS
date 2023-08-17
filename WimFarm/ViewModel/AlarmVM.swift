//
//  AlarmVM.swift
//  WimFarm
//
//  Created by ulalalab on 2023/04/11.
//

import SwiftUI
import ObjectMapper
import SwiftyJSON
import Alamofire

class AlarmVM : NSObject, ObservableObject {
    @Published private var alarmView = AlarmView()
    @Published private var alarmPastView = AlarmPastView()
    @Published var token: String = ""
    @Published var alarmM = AlarmModel()
    @Published var alarmItemList = [Alarm]()
    @Published var alarmPastList = ADPage()
    @Published var alarmPastContentList = [ADContent]()
    @Published var deviceConfig = [DeviceConfig]()
    @Published var startDate = Date()
    @Published var endDate = Date()
    
    
    static let shared = AlarmVM()
    
    override init() {
        super.init()
        self.token = UserDefaults.standard.string(forKey: Common.UserDefaultKey.TOKEN) ?? ""
        print("init dash Token : \(self.token)")
    }
    
    func alarmCompany() {
        
        let urlString = "\(HttpUrls.URL.FARM_URL)/\(HttpUrls.NAME.ALARM_LIST)"
        
        let loadedModel:LoadedModel = GlobalModel.sharedInstance().loadedData ?? LoadedModel()
        
        let nowDate: Date = Date()
        let yestDate: Date = nowDate.addingTimeInterval(TimeInterval(-60*60*24))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let companys:[Company] = loadedModel.companys ?? [Company]()
        var companyIdx:Int = 0
        
        companys.forEach { company in
            companyIdx = company.company_idx!
        }
        
        let parameters: [String: Any] = [
            "company" : companyIdx,
            "factory" : 0,
            "group" : 0,
            "level" : 0,
            "onoff" : 1,
            "search_start_date" : "\(dateFormatter.string(from: yestDate))",
            "search_end_date" : "\(dateFormatter.string(from: nowDate))",
            "page" : 1,
            "index" : 0
        ]
        
//        companyIdx : 1101 / factoryIdx : 0
//        LEVEL : 0 / ONOFF : 1 / searchStartDate : 2023-04-09 05:00:00 / searchEndDate: 2023-04-11 05:00:00
//        page : 1 / realPage : 1 / totalPage : 1 / index : null
        
//        print("selftoken = \(self.token)")
//        self.token = lvmToken
//        print("lvmToken = \(lvmToken)")
        
        alarmView.startLoading()
        
        NetworkManagerUrlEncodingWT<AlarmResponse>.fetch(from: urlString, method: .post, parameter: parameters, token: self.token) { result in
            switch result {
            case .success(let response):
                if response.code == nil {
                    self.alarmM = response.data!
                    
                    self.alarmItemList = [Alarm]()
                    
                    self.alarmItemList = self.alarmM.lists ?? [Alarm]()
                    
                    
                    self.alarmView.stopLoading()
                }
                else {
                    //에러메시지 출력
                    self.alarmView.stopLoading()
                }
            case .failure(let error):
                print(error)
                print(error.localizedDescription)
                self.alarmView.stopLoading()
            }
        }
    }
    
    func alarmDaily() {
        
        let urlString = "\(HttpUrls.URL.FARM_API_URL)/\(HttpUrls.NAME.ALARM_DAILY_LIST)"
        
        let loadedModel:LoadedModel = GlobalModel.sharedInstance().loadedData!
        
        let nowDate: Date = Date()
        let yestDate: Date = nowDate.addingTimeInterval(TimeInterval(-60*60*24))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let companys:[Company] = loadedModel.companys!
        var companyIdx:Int = 0
        
        companys.forEach { company in
            companyIdx = company.company_idx!
        }
        
        let factorys:[Factory] = loadedModel.factorys!
        var factoryIdx:Int = 0
        factoryIdx = factorys[0].factory_idx!
        
        let parameters: [String: Any] = [
            "wcIdx" : companyIdx,
            "wfIdx" : factoryIdx,
            "page" : 0
        ]
        
//        companyIdx : 1101 / factoryIdx : 0
//        LEVEL : 0 / ONOFF : 1 / searchStartDate : 2023-04-09 05:00:00 / searchEndDate: 2023-04-11 05:00:00
//        page : 1 / realPage : 1 / totalPage : 1 / index : null
        
//        print("selftoken = \(self.token)")
//        self.token = lvmToken
//        print("lvmToken = \(lvmToken)")
        
        alarmView.startLoading()
        
        let fullURL = "\(urlString)?wcIdx=\(companyIdx)&wfIdx=\(factoryIdx)"
//        let fullURL = "\(urlString)?wcIdx=0&wfIdx=0"
        guard let url = URL(string: fullURL) else {return}
        
//        AlarmPastNetworkManager<AlarmPastResponse>.fetchAlarmPast(for: url){ (result) in
//            switch result {
//                case .success(let response):
//                    DispatchQueue.main.async {
////                        self.alarmM = response.data!
//                        print("response : \(response)")
//
//                        self.alarmView.stopLoading()
//                    }
//                case .failure(let error):
//                    print(error)
//            }
//        }
        
//        NetworkManagerUrlEncodingWT<AlarmPastResponse>.fetch(from: urlString, method: .post, parameter: parameters, token: self.token) { result in
        
        NetworkManager<AlarmPastResponse>.fetch(from: fullURL) { result in
//        AlarmPastNetworkManager<AlarmPastResponse>.fetchAlarmPast(for: url) { result in
            switch result {
            case .success(let response):
                if response.code == nil {
//                    self.alarmM = response.data!

//                    self.alarmItemList = [Alarm]()
//
//                    self.alarmItemList = self.alarmM.lists ?? [Alarm]()


                    self.alarmView.stopLoading()
                }
                else {
                    //에러메시지 출력
                    self.alarmView.stopLoading()
                }
            case .failure(let error):
                print(error)
                print(error.localizedDescription)
                self.alarmView.stopLoading()
            }
        }
    }
    
    
    
    func getAlarmDaily() {
        let urlString = "http://api.wim-x.kr:89/api/alarm/daily?wcIdx=1146&wfIdx=0&page=0"
        let request = AF.request(urlString)
        
        request.responseJSON { (response) in
          print(response)
            switch response.result {
            case .success(let res):
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject:res, options: .prettyPrinted)
                    let json = try JSONDecoder().decode(AlarmPastModel.self, from: jsonData)
                    
                    print("json!~! = \(json)")
                    
                    self.alarmPastList = json.page ?? ADPage()
                    self.alarmPastContentList = [ADContent]()
                    
                    
                    let loadedModel:LoadedModel = GlobalModel.sharedInstance().loadedData ?? LoadedModel()
                    
                    if self.alarmPastList.content?.count ?? 0 > 0 {
                        for var apcontent in self.alarmPastList.content! {
                            if apcontent.subList?.count ?? 0 > 0 {
                                var subList:[Sublist] = [Sublist]()
                                
                                var bSet = false
//                                for var sub in apcontent.subList! {
                                for index in apcontent.subList!.indices {
                                    // sub 에 wdName과 chName 채워주기
                                    
                                    for cate in loadedModel.category! {
                                        let channel = loadedModel.channels![String(cate.groups_group!)]
                                        
                                        if(channel != nil) {
                                            print("channel = \(String(describing: channel))")
                                            
                                            for ch in channel! {
//                                                if ch.key == sub.wdCode {
                                                if ch.key == apcontent.subList![index].wdCode {
//                                                    for vCh in values! {
//                                                        print("value Channel = \(String(describing: vCh))")
//                                                        let ch = "ch_\(vCh)"
//                                                        print("chchc = \(ch)")
//
//                                                        if ch == sub.wnChannel {                                                        }
//                                                    }
                                                    
//                                                    sub.wdName = cate.groups_comment
                                                    apcontent.subList![index].wdName = cate.groups_comment

                                                    
                                                    for device in loadedModel.devices! {
                                                        print("deviceConfig = \(String(describing: device.device_config))")
                                                        let data = device.device_config!.data(using: .utf8)
                                                        let json = try? JSON(data: data!)
                                                        
                                                        print("deviceConfigJson = \(String(describing: json))")
                                                        
                                                        let widgetConfigData = JSON(device.device_config as Any).stringValue
                                                        
                                                        let config = JSON(widgetConfigData as Any)
                                                        let configStr:String = config.stringValue.removingPercentEncoding!
                                                        
                                                        print("configStr = \(String(describing: configStr))")
                                                        
                                                        var deviceConfig:[DeviceConfig] = [DeviceConfig]()
                                                        if let data = configStr.data(using: .utf8) {
                                                            deviceConfig = try! JSONDecoder().decode([DeviceConfig].self, from: data)
                                                        }
                                                        
                                                        for dc in deviceConfig {
                                                            print("dcdcdc = \(dc)")
//                                                            if dc.channel == sub.wnChannel {
                                                            if dc.channel == apcontent.subList![index].wnChannel {
//                                                                sub.chName = dc.name
                                                                apcontent.subList![index].chName = dc.name
                                                                print("channel Name = \(String(describing: dc.name))")
                                                                
                                                                bSet = true
                                                                break
                                                            }
                                                        }
                                                        if bSet {
                                                            break
                                                        }
                                                    }
                                                }
                                                if bSet {
                                                    break
                                                }
                                            }
                                        }
//                                        if bSet {
//                                            break
//                                        }
                                    }
                                    print("subsub = \(apcontent.subList![index])")
                                    subList.append(apcontent.subList![index])
                                }
//                                apcontent.subList = subList
                            }
                            print("appCntnt = \(String(describing: apcontent.subList))")
                            self.alarmPastContentList.append(apcontent)
                        }
                    }
                    
                    self.alarmView.stopLoading()
                } catch (let err) {
                    print(err.localizedDescription)
                    self.alarmView.stopLoading()
                }
            case .failure(let err):
                print(err.localizedDescription)
                self.alarmView.stopLoading()
            }
        }
        
////        NetworkManagerUrlEncodingWT<AlarmResponse>.fetch(from: urlString, method: .post, parameter: parameters, token: self.token) { result in
////            switch result {
////            case .success(let response):
//        NetworkManager<AlarmPastResponse>.fetch(from: urlString) { result in
////        AlarmPastNetworkManager<AlarmPastResponse>.fetchAlarmPast(for: url) { result in
//            switch result {
//            case .success(let response):
//                if response.code == nil {
////                    self.alarmM = response.data!
//
////                    self.alarmItemList = [Alarm]()
////
////                    self.alarmItemList = self.alarmM.lists ?? [Alarm]()
//
//
//                    self.alarmView.stopLoading()
//                }
//                else {
//                    //에러메시지 출력
//                    self.alarmView.stopLoading()
//                }
//            case .failure(let error):
//                print(error)
//                print(error.localizedDescription)
//                self.alarmView.stopLoading()
//            }
//        }
    }
    
    func getDeviceConfig(subList: Sublist, aDate: String){
        var dConfig = DeviceConfig()
        
        let loadedModel:LoadedModel = GlobalModel.sharedInstance().loadedData ?? LoadedModel()
        
        for device in loadedModel.devices! {
            if device.device_code == subList.wdCode {
                let data = device.device_config!.data(using: .utf8)
                let json = try? JSON(data: data!)
                
                print("deviceConfigJson = \(String(describing: json))")
                
                let widgetConfigData = JSON(device.device_config as Any).stringValue
                
                let config = JSON(widgetConfigData as Any)
                let configStr:String = config.stringValue.removingPercentEncoding!
                
                print("configStr = \(String(describing: configStr))")
                
                var deviceConfig:[DeviceConfig] = [DeviceConfig]()
                if let data = configStr.data(using: .utf8) {
                    deviceConfig = try! JSONDecoder().decode([DeviceConfig].self, from: data)
                }
                
                for dc in deviceConfig {
                    print("dcdcdc = \(dc)")
                    if dc.channel == subList.wnChannel {
                        dConfig = dc
                        dConfig.cateName = subList.wdName
                        dConfig.deviceName = subList.wdCode
                        
                        break
                    }
                }
                break
            }
        }
        
        var arrDC:[DeviceConfig] = [DeviceConfig]()
        arrDC.append(dConfig)
        
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        format.timeZone = TimeZone(identifier:  "UTC")
        
        let startDate = "\(aDate) 00:00:00"
        let endDate = "\(aDate) 23:59:59"
        
        self.deviceConfig = arrDC
        self.startDate = format.date(from: startDate) ?? Date()
        self.endDate = format.date(from: endDate) ?? Date()
        
//        self.alarmPastView.linkToGraph(dConfig: arrDC, aDate: date)
    }
}
