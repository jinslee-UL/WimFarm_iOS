//
//  ReportVM.swift
//  WimFarm
//
//  Created by ulalalab on 2023/07/03.
//

import SwiftUI
import ObjectMapper
import SwiftyJSON


class ReportVM : NSObject, ObservableObject {
    
    @Published private var reportView = ReportView()
    @Published var token: String = ""
    @Published var device_detect: String = "iOS"
    @Published var device_token: String = ""
    @Published var loadedM = LoadedModel()
    @Published var deviceList = [Device]()
    @Published var deviceMapList = [String : Device]()
    @Published var deviceConfigList = [DeviceConfig]()
//    @Published var reportDeviceList = [String : DeviceConfig]()
    @Published var reportDeviceList = [DeviceConfig]()
    @Published var selectedDeviceList = [DeviceConfig]()
    @Published var filterList = [Filter]()
    @State private var showingAlert = false
    
    static let shared = ReportVM()
    
    
    override init() {
        super.init()
        self.token = UserDefaults.standard.string(forKey: Common.UserDefaultKey.TOKEN) ?? ""
        print("init dash Token : \(self.token)")
    }
    
    func loaded(lvmToken:String) {
        
        let urlString = "\(HttpUrls.URL.FARM_URL)/\(HttpUrls.NAME.LOADED)"
        
        print("selftoken = \(self.token)")
        self.token = lvmToken
        print("lvmToken = \(lvmToken)")
        
        reportView.startLoading()
        
        NetworkManagerUrlEncodingWithoutParam<LoadedResponse>.fetch(from: urlString, method: .post, token: self.token) { result in
            switch result {
            case .success(let response):
                if response.code == nil {
                    self.loadedM = response.data!
                    //                    self.registerToken()
                    GlobalModel.sharedInstance().loadedData = self.loadedM
                    print("LoadedModel : \(self.loadedM)")
                    print("GlobalModel : \(GlobalModel.sharedInstance().loadedData)")
                    
                    
                    let encode = JSONEncoder()
                    let data = try? encode.encode(self.loadedM)
                    
                    print("endoedData : \(data)")
                    
                    let loadedUser = self.loadedM.user
                    let eLoadedUser = try? encode.encode(self.loadedM.user)
                    
                    UserDefaults.standard.set(eLoadedUser, forKey: Common.UserDefaultKey.LOADED_USER)
                    UserDefaults.standard.set(data , forKey: Common.UserDefaultKey.LOADED)
                    
                    
                    print("loadedUser = \(self.loadedM.user)")
                    print("loadedUser = \(loadedUser)")
                    print("encoded loadedUser = \(eLoadedUser)")
                    
//                    let dLoadedUser = try? decode.decode(User.self, from: eLoadedUser!)
                    if let dLoadedUser = UserDefaults.standard.object(forKey: Common.UserDefaultKey.LOADED_USER) as? Data {
                        let decode = JSONDecoder()
                        if let savedObject = try? decode.decode(User.self, from: dLoadedUser) {
                            print("decoded loadedUser = \(savedObject)")
                        }
                    }
                    
                    self.loadedM.filterDic = [Int: Filter]()
                    for filter in self.loadedM.filters! {
//                        self.loadedM.filterDic![filter.sensor_idx!] = filter
                        self.loadedM.filterDic?.updateValue(filter, forKey: filter.sensor_idx!)
                    }
                    
                    
                    
                    self.deviceConfigList = [DeviceConfig]()
                    self.reportDeviceList = [DeviceConfig]()
                    self.selectedDeviceList = [DeviceConfig]()
                    self.filterList = [Filter]()
                    
                    for device in self.loadedM.devices! {
                        print("deviceConfig = \(String(describing: device.device_config))")
                        let strDecodeConfig: String = device.device_config!.utf8DecodedString()
//                        var strDecodeConfig: String = device.device_config!.decode(data: device.device_config!) ?? ""
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
                        
                        for var dc in deviceConfig {
                            dc.deviceName = device.device_code
                            
                            var ft:Filter = Filter()
                            
                            ft = self.loadedM.filterDic![Int(dc.filter!)!]!
                            
                            while(ft.sensor_depth! >= 2) {
                                ft = self.loadedM.filterDic![ft.sensor_parent!]!
                            }
                            
                            if self.filterList.isEmpty {
                                self.filterList.append(ft)
                            }
                            else {
                                var exist = 0
                                for uniqF in self.filterList {
                                    if uniqF.sensor_idx == ft.sensor_idx {
                                        exist = 1
                                        break
                                    }
                                }
                                
                                if exist == 0 {
                                    self.filterList.append(ft)
                                }
                            }
//                            for filter in self.loadedM.filters! {
//                                if filter.sensor_idx == Int(dc.filter!) {
//                                    if filter.sensor_depth == 1 {
//
//                                    }
//                                    else {
//
//                                    }
//                                }
//                            }
                        }
                        
                        var dv:Device = Device()
                        dv = device
                        dv.deviceConfig = deviceConfig
                        
                        self.deviceList.append(dv)
                        self.deviceMapList.updateValue(dv, forKey: dv.device_code!)
                        
                        print("deviceConfig = \(strDecodeConfig)")
                    }
                    
//                    let uniqFL = self.filterList.removeDuplicates()
                    
                    for cate in self.loadedM.category! {
                        let channel = self.loadedM.channels![String(cate.groups_group!)]
                        
                        if(channel != nil) {
                            print("channel = \(String(describing: channel))")
                            
                            for (key, values) in channel! {
                                let dconfig = self.deviceMapList[key]?.deviceConfig
                                print("dConfig = \(String(describing: dconfig))")
                                
                                for vCh in values! {
                                    print("value Channel = \(String(describing: vCh))")
                                    let ch = "ch_\(vCh)"
                                    print("chchc = \(ch)")
                                    
                                    for var dc in dconfig! {
                                        if(dc.channel == ch) {
                                            print("dcdc = \(dc)")
                                            dc.deviceName = key
                                            dc.cateName = cate.groups_comment
                                            dc.checked = false
                                            
                                            let rkey = "\(key)_\(vCh)"
                                            
//                                            self.reportDeviceList.updateValue(dc, forKey: rkey)
                                            
                                            self.deviceConfigList.append(dc)
                                            self.reportDeviceList.append(dc)
                                        }
                                    }
                                }
                            }
                        }
//                        cate.groups_group
                    }
                    
//                    for channel in self.loadedM.channels! {
//                        print("channel key = \(String(describing: channel.key))")
//                        print("channel value = \(channel.value)")
//                        print("channel value = \(channel.value.keys) count = \(channel.value.keys.count)")
//
//
//                    }
                    
                    
                    // 카테고리부터 돌아서 group_group 가지고 channel key값 검색. 디바이스 찾아서 채털 추가 (카테고리이름, 디바이스id, 채널, 필터, 부모필터?) 어레이로...
                    // 위에 채널에서 빼낸 디바이스 컨피그는 키값을 디바이스코드_채널 로 만들어보기?
                    
                    self.reportView.stopLoading()
                    
//                    self.dashWidgetList()
                }
                else {
                    //에러메시지 출력
                    self.reportView.stopLoading()
                }
            case .failure(let error):
                print(error)
                print(error.localizedDescription)
                self.reportView.stopLoading()
            }
        }
    }
    
    func selectedChannel(filterIdx: Int) {
        let filter = self.loadedM.filterDic![filterIdx]
        
//        if (filter?.sensor_depth == 2) {
//            filter = self.loadedM.filterDic![(filter?.sensor_parent!)!]
//        }
        
        self.selectedDeviceList = [DeviceConfig]()
        self.reportDeviceList = [DeviceConfig]()
        
        for dConfig in self.deviceConfigList {
            var cFilter = self.loadedM.filterDic![Int(dConfig.filter!)!]
            if(cFilter?.sensor_depth == 2) {
                print("cfilter = \(String(describing: cFilter?.sensor_idx)) , parent = \(String(describing: cFilter?.sensor_parent))")
                cFilter = self.loadedM.filterDic![(cFilter?.sensor_parent!)!]
            }
            
            if(filter?.sensor_name == cFilter?.sensor_name) {
                self.reportDeviceList.append(dConfig)
            }
        }
        
        let uniqDevConfig = self.reportDeviceList.removeDuplicates()
        
        self.reportDeviceList = uniqDevConfig
        
        print("reportDeviceList = \(self.reportDeviceList)")
    }
    
    func selectedDevice(dConfig: DeviceConfig) {
        if(dConfig.checked!) {
            for var (index, dc) in self.reportDeviceList.enumerated() {
                if(dc.deviceName == dConfig.deviceName && dc.filter == dConfig.filter && dc.channel == dConfig.channel) {
                    dc.checked = false
                    self.reportDeviceList[index] = dc
                    break
                }
            }
        }
        else {
            for var (index, dc) in self.reportDeviceList.enumerated() {
                if(dc.deviceName == dConfig.deviceName && dc.filter == dConfig.filter && dc.channel == dConfig.channel) {
                    dc.checked = true
                    self.reportDeviceList[index] = dc
                    break
                }
            }
        }
        
        if self.selectedDeviceList.isEmpty {
            self.selectedDeviceList.append(dConfig)
        }
        else {
            var i = -1
            for (index, dc) in self.selectedDeviceList.enumerated() {
                if(dc.deviceName == dConfig.deviceName && dc.filter == dConfig.filter && dc.channel == dConfig.channel) {
                    i = index
                    break
                }
            }
            
            if i >= 0 {
                self.selectedDeviceList.remove(at: i)
            }
            else {
                self.selectedDeviceList.append(dConfig)
            }
        }
        
        print("selectedDeviceList = \(self.selectedDeviceList)")
    }
}
