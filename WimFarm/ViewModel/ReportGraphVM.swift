//
//  ReportGraphVM.swift
//  WimFarm
//
//  Created by ulalalab on 2023/07/11.
//

import SwiftUI
import ObjectMapper
import SwiftyJSON
import Charts

class ReportGraphVM : NSObject, ObservableObject {
    
//    @Published private var reportGraphView = ReportGraphView(widget: WidgetList(), item:WidgetItem())
    @Published private var reportGraphView = ReportGraphView(selectedSensors: [DeviceConfig](), startDate: Date(), endDate: Date())
    @Published var token: String = ""
    @Published var device_detect: String = "iOS"
    @Published var device_token: String = ""
    @Published var trendM = TrendModel()
    @Published var devices: [String] = [String]()
    @Published var channels: [String:[String]] = [String:[String]]()
    @Published var maxCh: [String] = [String]()
    @Published var muList:[MultiList] = [MultiList]()
    @Published var mValue:[MultiValue] = [MultiValue]()
    @Published var cdEntries:[ChartDataEntries] = [ChartDataEntries]()
    @State private var showingAlert = false
    
    static let shared = ReportGraphVM()
    
    
    override init() {
        super.init()
        self.token = UserDefaults.standard.string(forKey: Common.UserDefaultKey.TOKEN) ?? ""
        print("init chart Token : \(self.token)")
    }
    
    
//    func summary(lvmToken:String, widgetLst: WidgetList, df: String) {
    func summary(lvmToken:String, selectedSensors: [DeviceConfig], startDate: Date, endDate: Date) {
 
//        var devices: [String] = [String]()
//        var channels: [String:[String]] = [String:[String]]()
        self.devices = [String]()
        self.channels = [String:[String]]()
        self.trendM.list = [Trend]()
//        self.trendM.multiList = [String:[Trend]]()
//        self.trendM.multiValues = [String:[Entry]]()
        self.trendM.multiList = [MultiList]()
        self.trendM.multiValues = [MultiValue]()
        
        selectedSensors.forEach { dv in
            var dCode = (dv.deviceName)!
            self.devices.append(dCode)
            
            var chs:[String] = channels[dCode] ?? [String] ()
            chs.append(dv.channel!)
            channels.updateValue(chs, forKey: dCode)
            self.maxCh.append("max_" + dv.channel!)
        }

        let uniqDevice = self.devices.removeDuplicates()
        
        self.devices = uniqDevice
        
//        var sDate: [String:String] = ["start_date":"2023-03-15 06:00:00"]
//        var eDate: [String:String] = ["end_date":"2023-03-17 06:00:00"]
        // Date() = 2023-04-05 16:51:13 +0000
        let nowDate: Date = Date()
        let yestDate: Date = nowDate.addingTimeInterval(TimeInterval(-60*60*24))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        print("\(dateFormatter.string(from: startDate))")
        print("\(dateFormatter.string(from: endDate))")
        
        var strStartDate = dateFormatter.string(from: startDate).components(separatedBy: " ")
        var strEndDate = dateFormatter.string(from: endDate).components(separatedBy: " ")
        
//        var seDate: [String:String] = ["start_date":"2023-03-15 06:00:00", "end_date":"2023-03-16 06:00:00"]
//        let seDate: [String:String] = ["start_date":"\(dateFormatter.string(from: yestDate))", "end_date":"\(dateFormatter.string(from: nowDate))"]
        let seDate: [String:String] = ["start_date":strStartDate[0]+" 00:00:00", "end_date":"\(dateFormatter.string(from: endDate))"]
        
        var search: [[String:String]] = [[String:String]]()
        search.append(seDate)
        
        //[{start_date: "2023-03-15 06:00:00", end_date: "2023-03-17 05:59:59"}]
        
        let urlString = "\(HttpUrls.URL.FARM_URL)/\(HttpUrls.NAME.SUMMARY)"
        let parameters: [String: Any] = [
            "group" : 0,
            "isFarm" : 1,
            "devices" : uniqDevice,
            "channels" : channels,
            "search" : search
        ]
        print("selftoken = \(self.token)")
        self.token = lvmToken
        print("lvmToken = \(lvmToken)")
        
        print("paramssmarap = \(parameters as AnyObject)")
        
        self.reportGraphView.startLoading()
        
        NetworkManagerJSONEncodingUTF8<TrendRes>.fetch(from: urlString, method: .post, parameter: parameters, token: self.token) { result in
            switch result {
            case .success(let response):
                if response.code == nil {
                    self.trendM = response.data!
                    print("SummaryModel : \(self.trendM)")
                    print("self.maxCh : \(self.maxCh)")
                    
                    self.muList = [MultiList]()
                    self.mValue = [MultiValue]()
                    self.cdEntries = [ChartDataEntries]()
                    
                    self.trendM.search?.forEach { search in
                        
                        selectedSensors.forEach { sensor in
                            
//                            print("sensor'df is = \(sensor.df!)")
//                            // 멀티 위젯의 개별 그래프일때 걸러냄
//                            if (df != "all" && df != sensor.df) {
//                                return
//                            }
                            
                            var arrDays:[String] = [String]()
                            var arrList:[Trend] = [Trend]()
                            var arrValue:[Entry] = [Entry]()
                            var index:Double = 0.0
                            var arrTime:[EntryTimes] = [EntryTimes]()
                            var arrCDEndtry:[ChartDataEntry] = [ChartDataEntry]()
                            
                            for (key, value) in search {
                                
                                if(key == sensor.deviceName) {
                                    value!.forEach { item in
                                        let time:Date = item.time!.toDate(.isoDateTimeSec) ?? Date()
                                        let val:Double = Double(item.maxCh["max_\(sensor.channel!)"] ?? Float(Double()))
                                        print("max sensor.channel = max_\(sensor.channel!)")
                                        print("max sensor.channel val = \(val)")
                                    
                                        
//                                        let trend = Trend(time: time, value: val)
//                                        let entry = Entry(x: index, value: val)
////                                        var trend:Trend = ["time": "\(time)", "value":"\(item.maxCh["max_\(sensor.channel ?? "")"])"]
//                                        var entry:Entry = ["x": index, "value":val]
//
//                                        // 나중에 필터 적용
//                                        var filter = sensor.filter?.sensor_idx
//
//                                        arrList.append(trend)
//                                        arrValue.append(entry)
                                        let day = dateFormatter.string(from: time)
                                        let eTime = EntryTimes(time: time, value: val)
                                        let cdEntry = ChartDataEntry(x: index, y: val)
                                        
                                        arrDays.append(day)
                                        arrTime.append(eTime)
                                        arrCDEndtry.append(cdEntry)
//
                                        index += 1
                                    }
                                }
                            }
//                            print("print sensor.df = \(sensor.df!)")
//                            let legendName = "\(sensor.name ?? "")_\(sensor.icon ?? "")"
                            let legendName = "\(sensor.cateName ?? "")"
                            
//                            let multilist = MultiList(df: sensor.df!, trend: arrList)
//                            let multiValue = MultiValue(df: sensor.df!, entry: arrValue)
                            
//                            self.muList.append(multilist)
//                            self.mValue.append(multiValue)
                            
                            let chartDataEntries = ChartDataEntries(df: legendName, days: arrDays, time: arrTime, cdEntry: arrCDEndtry)
//                            let chartDataEntries = ChartDataEntries(df: sensor.df!, days: arrDays, time: arrTime, cdEntry: arrCDEndtry)
                            
                            self.cdEntries.append(chartDataEntries)
                        }
                        
                    }
                    
                    self.reportGraphView.stopLoading()
                }
                else {
                    //에러메시지 출력
                    self.reportGraphView.stopLoading()
                }
            case .failure(let error):
                print(error)
                print(error.localizedDescription)
                self.reportGraphView.stopLoading()
            }
        }
    }
    
}
