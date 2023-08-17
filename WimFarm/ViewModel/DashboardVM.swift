//
//  DashboardVM.swift
//  WimFarm
//
//  Created by ulalalab on 2023/02/22.
//

import SwiftUI
import ObjectMapper
import SwiftyJSON

class DashboardVM : NSObject, ObservableObject {
    
    @Published private var dashboardView = DashboardView()
    @Published var token: String = ""
    @Published var device_detect: String = "iOS"
    @Published var device_token: String = ""
    @Published var loadedM = LoadedModel()
    @Published var packetM = [String: PacketData]()
    @Published var dashWidgetM = DashWidgetLists()
    @Published var mobileDashWidget = DashWidget()
    @Published var widgetItemList = [WidgetList]()
    @State private var showingAlert = false
    
    static let shared = DashboardVM()
    
    
    override init() {
        super.init()
        self.token = UserDefaults.standard.string(forKey: Common.UserDefaultKey.TOKEN) ?? ""
        print("init dash Token : \(self.token)")
    }
    
    func loaded(lvmToken:String) {
        
        let urlString = "\(HttpUrls.URL.FARM_URL)/\(HttpUrls.NAME.LOADED)"
//        let parameters: [String: Any] = [
//            "" : "" // 토큰이 없을 시 빈값으로
//        ]
        print("selftoken = \(self.token)")
        self.token = lvmToken
        print("lvmToken = \(lvmToken)")
        
        dashboardView.startLoading()
        
        NetworkManagerUrlEncodingWithoutParam<LoadedResponse>.fetch(from: urlString, method: .post, token: self.token) { result in
            switch result {
            case .success(let response):
                if response.code == nil {
                    self.loadedM = response.data!
                    //                    self.registerToken()
                    GlobalModel.sharedInstance().loadedData = self.loadedM
                    print("LoadedModel : \(self.loadedM)")
                    print("GlobalModel : \(String(describing: GlobalModel.sharedInstance().loadedData))")
                    
//                    ForEach(self.loadedM.devices!) { device in
//                    for var dev in self.loadedM.devices! {
//                        let deviceData = JSON(dev.device_config).stringValue
//                        let config = JSON(deviceData as Any)
//                        let configStr:String = config.stringValue.removingPercentEncoding!
//
//                        if let data = configStr.data(using: .utf8) {
//                            dev.deviceConfig = try! JSONDecoder().decode([DeviceConfig].self, from: data)
//                        }
//                    }
                    
                    self.loadedM.filterDic = [Int: Filter]()
                    for filter in self.loadedM.filters! {
//                        self.loadedM.filterDic![filter.sensor_idx!] = filter
                        self.loadedM.filterDic?.updateValue(filter, forKey: filter.sensor_idx!)
                    }
                    
                    
                    let encode = JSONEncoder()
                    let data = try? encode.encode(self.loadedM)
                    
                    print("endoedData : \(String(describing: data))")
                    
                    let loadedUser = self.loadedM.user
                    let eLoadedUser = try? encode.encode(self.loadedM.user)
                    
                    UserDefaults.standard.set(eLoadedUser, forKey: Common.UserDefaultKey.LOADED_USER)
                    UserDefaults.standard.set(data , forKey: Common.UserDefaultKey.LOADED)
                    
                    
                    print("loadedUser = \(String(describing: self.loadedM.user))")
                    print("loadedUser = \(String(describing: loadedUser))")
                    print("encoded loadedUser = \(String(describing: eLoadedUser))")
                    
//                    let dLoadedUser = try? decode.decode(User.self, from: eLoadedUser!)
                    if let dLoadedUser = UserDefaults.standard.object(forKey: Common.UserDefaultKey.LOADED_USER) as? Data {
                        let decode = JSONDecoder()
                        if let savedObject = try? decode.decode(User.self, from: dLoadedUser) {
                            print("dcoded loadedUser = \(savedObject)")
                        }
                    }
                    
                    self.dashboardView.stopLoading()
                    
                    self.packet()
//                    self.dashWidgetList()
                }
                else {
                    //에러메시지 출력
                    self.dashboardView.stopLoading()
                }
            case .failure(let error):
                print(error)
                print(error.localizedDescription)
                self.dashboardView.stopLoading()
            }
        }
    }
    
    func packet() {
        
        let urlString = "\(HttpUrls.URL.FARM_URL)/\(HttpUrls.NAME.PACKET)"
        let parameters: [String: Any] = [
            "" : "" // 토큰이 없을 시 빈값으로
        ]
        
        dashboardView.startLoading()
        
        NetworkManagerUrlEncodingWT<PacketResponse>.fetch(from: urlString, method: .post, parameter: parameters, token: self.token) { result in
            switch result {
            case .success(let response):
                if response.code == nil {
                    self.packetM = response.data!
                    //                    self.registerToken()
                    GlobalModel.sharedInstance().packetData = self.packetM
                    print("PacketModel : \(self.packetM)")
                    
                    
                    let encode = JSONEncoder()
                    let ePacket = try? encode.encode(self.packetM)
                    
                    UserDefaults.standard.set(ePacket, forKey: Common.UserDefaultKey.PACKET)
                    
                    self.dashboardView.stopLoading()
                    
                    self.dashWidgetList()
                }
                else {
                    //에러메시지 출력
                    self.dashboardView.stopLoading()
                }
            case .failure(let error):
                print(error.localizedDescription)
                self.dashboardView.stopLoading()
            }
        }
    }
    
    func dashWidgetList() {
        
        let urlString = "\(HttpUrls.URL.FARM_URL)/\(HttpUrls.NAME.DASH_WIDGET_LIST)"
        let parameters: [String: Any] = [
            "delete" : 0
//            "device_token" : GlobalModel.sharedInstance().deviceToken ?? "" // 토큰이 없을 시 빈값으로
        ]
        
        print("ddddelete = \(parameters as AnyObject)")
        
        dashboardView.startLoading()
        
        NetworkManagerUrlEncodingWT<DashWidgetResponse>.fetch(from: urlString, method: .post, parameter: parameters, token: self.token) { result in
            switch result {
            case .success(let response):
                if response.code == nil {
                    self.dashWidgetM = response.data!
                    //                    self.registerToken()
                    self.dashWidgetM.lists?.forEach { dashwidget in
                        if dashwidget.widget_type == 2 {
                            self.mobileDashWidget = dashwidget
                        }
                    }
                    GlobalModel.sharedInstance().dashWidgetData = self.mobileDashWidget
                    print("moblieDashModel : \(self.mobileDashWidget)")

                    UserDefaults.standard.set(self.mobileDashWidget.widget_configs, forKey: Common.UserDefaultKey.DASH_WIDGET_LIST)
                    
                    self.makeDashWidget()
                    
                    self.dashboardView.stopLoading()
                    
//                    self.packet()
                }
                else {
                    //에러메시지 출력
                    self.dashboardView.stopLoading()
                }
            case .failure(let error):
                print(error.localizedDescription)
                self.dashboardView.stopLoading()
            }
        }
    }
    
    func makeDashWidget() {
        self.widgetItemList = [WidgetList]()
        
        let widgetConfigData = JSON(self.mobileDashWidget.widget_configs as Any).stringValue
        
        let config = JSON(widgetConfigData as Any)
        let configStr:String = config.stringValue.removingPercentEncoding!
        
        if let data = configStr.data(using: .utf8) {
//                        if let json = try? JSON(data: data) {
            self.mobileDashWidget.widgetConfig = try! JSONDecoder().decode([DashWidgetConfig].self, from: data)
//                            print("kkkkkkkk = \(json)")
////                            }
//                        }
            
//                        ForEach(self.mobileDashWidget.widgetConfig!) { widget in
            for widget in self.mobileDashWidget.widgetConfig! {
                
                let widgetId = widget.id
                
                if widgetId == "channel-mini" {
                    let deviceCode = widget.data?.device_code
                    
                    let rel = getRelational(deviceCode: deviceCode!)
                    
                    var catgr = Category()
                    
                    self.loadedM.category?.forEach { cate in
                        if cate.groups_group == rel.category_group_group {
                            catgr = cate
                        }
                        
                    }
                    
                    var wList = WidgetList()
                    var wItem = WidgetItem()
//                    var title, name, icon, unit: String?
//                    var device: Device?
//                    var filter: Filter?
                    
                    wList.title = widget.data?.title
                    wList.name = catgr.groups_comment
                    wList.type = "single"
                    
                    wItem.title = widget.data?.title
                    wItem.name = catgr.groups_comment
                    
                    wList.select = [WidgetItem]()
                
//                    self.loadedM.devices!.forEach { dev in
                    for dev in self.loadedM.devices! {
                        if dev.id == deviceCode {
                            wList.device = dev
                            wItem.device = dev
                            
                            let deviceData = JSON(dev.device_config as Any).stringValue
                            let config = JSON(deviceData as Any)
                            let configStr:String = config.stringValue.removingPercentEncoding!

                            if let data = configStr.data(using: .utf8) {
//                                dev.deviceConfig = try! JSONDecoder().decode([DeviceConfig].self, from: data)
                                
                                let dcArr = try! JSONSerialization.jsonObject(with: data) as? [[String: Any?]]
                                
                                print("dev.jsonArr = \(String(describing: dcArr))")
                                
                                dcArr?.forEach { dc in
                                    if dc["channel"] as? String == widget.data?.channel! {
                                        let filtr = dc["filter"]
                                        
                                        self.loadedM.filters!.forEach { filter in
                                            if filter.sensor_idx == JSON(filtr as Any).intValue {
                                                wList.filter = filter
                                                
//                                                wList.icon = filter.sensor_icon ?? "no_sensor"
                                                wList.unit = filter.sensor_unit
                                                
                                                print("ffffilter = \(filter)")
                                                wItem.filter = filter
                                                
                                                
                                                
//                                                wItem.icon = filter.sensor_icon ?? "no_sensor"
//                                                wItem.unit = filter.sensor_unit
                                                if (filter.sensor_icon == nil || filter.sensor_icon == "") {
                                                    wList.icon = "no_sensor"
                                                    wItem.icon = "no_sensor"
                                                }
                                                else {
                                                    wList.icon = filter.sensor_icon!
                                                    wItem.icon = filter.sensor_icon!
                                                }
                                                
                                                wItem.unit = filter.sensor_unit
                                                
                                                
                                                wItem.df = "\(widget.data?.device_code ?? "")&\(widget.data?.channel ?? "")&\(filter.sensor_idx ?? 0)"
//                                                wItem.df = "\(String(describing: widget.data?.device_code))_\(String(describing: widget.data?.channel))_\(String(describing: filter.sensor_idx))"
                                            }
                                        }
                                        
                                        let packetData:PacketData = self.packetM[deviceCode!]!
                                        let packetCh = packetData.packet?.channel
                                        
                                        if packetData.onoff == 1 {
                                            if wItem.device?.device_extension?.length == 0 {
                                                //날짜 계산하기
                                                let format = DateFormatter()
                                                format.dateFormat = "yyyy-MM-dd HH:mm:ss"
                                                format.timeZone = TimeZone(identifier:  "UTC")
                                                
                                                let sDate = packetData.packet_time!.components(separatedBy: " ")
                                                let strStime = "\(sDate[0]) \(sDate[1])"
                                                
                                                let startTime = format.date(from: strStime)
                                                
                                                let endTime = Date()
                                                
                                                print("packetData.packet_time! = \(packetData.packet_time!)")
                                                
                                                let useTime = Int(endTime.timeIntervalSince(startTime!))
                                                
                                                if (useTime - 60 > 0) {
                                                    wItem.state = "over"
                                                }
                                                else {
                                                    wItem.state = "on"
                                                    
                                                    if  packetCh![(widget.data?.channel! ?? "")!] == nil {
                                                        wItem.state = "over"
                                                    }
                                                    else {
                                                        wItem.value =  packetCh![(widget.data?.channel! ?? "")!]!!
                                                        wList.value =  packetCh![(widget.data?.channel! ?? "")!]!!
                                                    }
                                                }
                                            }
                                            else {
                                                let deviceExtensionData = JSON(wItem.device?.device_extension as Any).stringValue
                                                
                                                let dExtension = JSON(deviceExtensionData as Any)
                                                let dExStr:String = dExtension.stringValue.removingPercentEncoding!
                                                
                                                if let data = dExStr.data(using: .utf8) {
                                                    let dcs:DeviceExtension = try! JSONDecoder().decode(DeviceExtension.self, from: data)
                                                    
                                                    //날짜 계산하기
                                                    let format = DateFormatter()
                                                    format.dateFormat = "yyyy-MM-dd HH:mm:ss"
                                                    format.timeZone = TimeZone(identifier:  "UTC")
                                                    
                                                    let sDate = packetData.packet_time!.components(separatedBy: " ")
                                                    let strStime = "\(sDate[0]) \(sDate[1])"
                                                    
                                                    let startTime = format.date(from: strStime)
                                                    
                                                    let endTime = Date()
                                                    
                                                    print("packetData.packet_time! = \(packetData.packet_time!)")
                                                    
                                                    let useTime = Int(endTime.timeIntervalSince(startTime!))
                                                    
                                                    if (useTime - dcs.display_check_seconds! > 0) {
                                                        wItem.state = "over"
                                                    }
                                                    else {
                                                        wItem.state = "on"
                                                        
                                                        if  packetCh![(widget.data?.channel! ?? "")!] == nil {
                                                            wItem.state = "over"
                                                        }
                                                        else {
                                                            wItem.value =  packetCh![(widget.data?.channel! ?? "")!]!!
                                                            wList.value =  packetCh![(widget.data?.channel! ?? "")!]!!
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                        else {
                                            wItem.state = "off"
                                        }
                                        
//                                        let packetCh = self.packetM[deviceCode!]?.packet?.channel
//                                        wList.value =  packetCh![(widget.data?.channel! ?? "")!]!!
                                        
                                        wList.channel = widget.data?.channel!
                                        wList.state = wItem.state
                                        
//                                        wItem.value =  packetCh![(widget.data?.channel! ?? "")!]!!
                                        
                                        wItem.channel = widget.data?.channel!
                                        
                                        wList.select?.append(wItem)
                                        print("packetChpacketCh = \(String(describing: packetCh))")
                                        print("widget.data?.channel = \(String(describing: widget.data?.channel))")
                                    }
                                }
                            }
                            print("dev.deviceConfig = \(configStr)")
                            
                        }
                    }
                    
                    print("wwwList = \(wList)")
                    self.widgetItemList.append(wList)
                    
//                    ForEach(self.loadedM.devices!) { device in
//                        if device.device_code == deviceCode {
//
//                        }
//                    }
                }
                else if widgetId == "channel-group-multi" {
                    
                    var wList = WidgetList()
                    
                    wList.title = widget.data?.title
                    wList.type = "multi"
                    wList.select = [WidgetItem]()
                    
                    widget.data?.select?.forEach { selected in
                        let deviceCode = selected.device_code
                        
                        let rel = getRelational(deviceCode: deviceCode!)
                        
                        var catgr = Category()
                        
                        self.loadedM.category?.forEach { cate in
                            if cate.groups_group == rel.category_group_group {
                                catgr = cate
                            }
                            
                        }
                        
                        var wItem = WidgetItem()
                        //                    var title, name, icon, unit: String?
                        //                    var device: Device?
                        //                    var filter: Filter?
                        
                        //                    self.loadedM.devices!.forEach { dev in
                        
                        wItem.title = widget.data?.title
                        wItem.name = catgr.groups_comment
                        
                        for dev in self.loadedM.devices! {
                            if dev.id == deviceCode {
                                wItem.device = dev
                                
                                let deviceData = JSON(dev.device_config as Any).stringValue
                                let config = JSON(deviceData as Any)
                                let configStr:String = config.stringValue.removingPercentEncoding!
                                
                                if let data = configStr.data(using: .utf8) {
                                    //                                dev.deviceConfig = try! JSONDecoder().decode([DeviceConfig].self, from: data)
                                    
                                    let dcArr = try! JSONSerialization.jsonObject(with: data) as? [[String: Any?]]
                                    
                                    print("dev.jsonArr = \(String(describing: dcArr))")
                                    
                                    dcArr?.forEach { dc in
                                        if dc["channel"] as? String == selected.channel! {
                                            let filtr = dc["filter"]
                                            
                                            self.loadedM.filters!.forEach { filter in
                                                if filter.sensor_idx == JSON(filtr as Any).intValue {
                                                    wItem.filter = filter
                                                    
                                                    if (filter.sensor_icon == nil || filter.sensor_icon == "") {
                                                        wItem.icon = "no_sensor"
                                                    }
                                                    else {
                                                        wItem.icon = filter.sensor_icon!
                                                    }
                                                    wItem.unit = filter.sensor_unit
                                                    
                                                    wItem.df = "\(selected.device_code ?? "")&\(selected.channel ?? "")&\(filter.sensor_idx ?? 0)"
//                                                    wItem.df = "\(String(describing:selected.device_code))\(String(describing: selected.channel))\(String(describing: filter.sensor_idx))"
                                                    print("ffffilter = \(filter)")
                                                }
                                            }
                                            
                                            let packetData:PacketData = self.packetM[deviceCode!]!
                                            
//                                            let packetCh = self.packetM[deviceCode!]?.packet?.channel
                                            let packetCh = packetData.packet?.channel
                                            
                                            if packetData.onoff == 1 {
                                                var deviceExtensionData = JSON(wItem.device?.device_extension as Any).stringValue
                                                
                                                if deviceExtensionData.isEmpty {
                                                    deviceExtensionData = "%7B%22display_check_seconds%22%3A60%7D"
                                                }
                                                
                                                let dExtension = JSON(deviceExtensionData as Any)
                                                let dExStr:String = dExtension.stringValue.removingPercentEncoding!
                                                
                                                if let data = dExStr.data(using: .utf8) {
                                                    let dcs:DeviceExtension = try! JSONDecoder().decode(DeviceExtension.self, from: data)
                                                    
                                                    //날짜 계산하기
                                                    let format = DateFormatter()
                                                    format.dateFormat = "yyyy-MM-dd HH:mm:ss"
                                                    format.timeZone = TimeZone(identifier:  "UTC")
                                                    
                                                    let sDate = packetData.packet_time!.components(separatedBy: " ")
                                                    let strStime = "\(sDate[0]) \(sDate[1])"
                                                    
//                                                    let startTime = strStime.toDate(.localDateTimeSec) ?? Date()
                                                    let startTime = format.date(from: strStime)
                                                    
                                                    let endTime = Date()
                                                    
                                                    print("packetData.packet_time! = \(packetData.packet_time!)")

                                                    let useTime = Int(endTime.timeIntervalSince(startTime!))
                                                    
                                                    if (useTime - dcs.display_check_seconds! > 0) {
                                                        wItem.state = "over"
                                                    }
                                                    else {
                                                        wItem.state = "on"
                                                        wItem.value =  packetCh![(selected.channel!)] ?? 0.0
                                                    }
                                                }
                                            }
                                            else {
                                                wItem.state = "off"
                                            }
                                            
                                            wItem.channel = selected.channel!
                                            
                                            wList.select?.append(wItem)
                                        }
                                    }
                                }
                                
                            }
                        }
                        
                        print("wwwItem = \(wItem)")
                    }
                    
                    self.widgetItemList.append(wList)
                }
            }
            
            
            print("widgetItemList = \(self.widgetItemList)")
        }
    }
    
    func getRelational(deviceCode:String) -> Relational {
        let chDic = self.loadedM.channels
        var rtRel = Relational()
        
        self.loadedM.relational?.forEach { rel in
            let cgg = rel.category_group_group!.codingKey.stringValue
            let devices = chDic![cgg]
            
            devices?.forEach { dev in
                if dev.key == deviceCode {
                    rtRel = rel
                }
            }
        }
        
        return rtRel
    }
}
