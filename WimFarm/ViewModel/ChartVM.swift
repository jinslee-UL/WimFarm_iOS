////
////  ChartVM.swift
////  WimFarm
////
////  Created by ulalalab on 2023/03/16.
////
//
//import SwiftUI
//import ObjectMapper
//import SwiftyJSON
//
//class ChartVM : NSObject, ObservableObject {
//    
//    @Published private var sChartView = SingleChartView(widget: WidgetList(), item:WidgetItem())
//    @Published var token: String = ""
//    @Published var device_detect: String = "iOS"
//    @Published var device_token: String = ""
//    @Published var loadedM = LoadedModel()
//    @Published var chartM = ChartModel()
//    @Published var chartData = ChartData()
//    @Published var maxCh: [String] = [String]()
//    @State private var showingAlert = false
//    
//    static let shared = ChartVM()
//    
//    
//    override init() {
//        super.init()
//        self.token = UserDefaults.standard.string(forKey: Common.UserDefaultKey.TOKEN) ?? ""
//        print("init chart Token : \(self.token)")
//    }
//    
//    
//    func summary(lvmToken:String, widgetLst: WidgetList) {
//        
//        self.chartData = ChartData()
//        self.chartData.title = widgetLst.title
//        self.chartData.keys = [String]()
//        self.chartData.vals = [Float]()
//        self.chartData.time = [Date]()
//        self.chartData.data = [ChartValue]()
//        self.chartData.items = [ChartItem]()
//        self.chartData.dataSet = [ChartDataSet]()
//        self.chartData.chartItems = [ChartItems]()
//        self.maxCh = [String]()
//        
//        var devices: [String] = [String]()
//        var channels: [String:[String]] = [String:[String]]()
//        
//        widgetLst.select?.forEach { dv in
//            print("dvdvdiv = \(dv)")
//            self.chartData.keys?.append("\(dv.name ?? "")_\(dv.filter?.sensor_name ?? "")")
//            
//            var dCode = (dv.device?.device_code)!
//            devices.append(dCode)
////            channels.append((dv.device?.device_code,dv.channel))
//            
//            var chs:[String] = channels[dCode] ?? [String]()
//            chs.append(dv.channel!)
//            channels.updateValue(chs, forKey: dCode)
//            self.maxCh.append("max_" + dv.channel!)
//        }
//        
////        devices.uniqued()
//        let uniqDevice = devices.removeDuplicates()
//        
////        var sDate: [String:String] = ["start_date":"2023-03-15 06:00:00"]
////        var eDate: [String:String] = ["end_date":"2023-03-17 06:00:00"]
//        // Date() = 2023-04-05 16:51:13 +0000
//        let nowDate: Date = Date()
//        let yestDate: Date = nowDate.addingTimeInterval(TimeInterval(-60*60*24))
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        
//        
//        
////        var seDate: [String:String] = ["start_date":"2023-03-15 06:00:00", "end_date":"2023-03-16 06:00:00"]
//        let seDate: [String:String] = ["start_date":"\(dateFormatter.string(from: yestDate))", "end_date":"\(dateFormatter.string(from: nowDate))"]
//        
//        var search: [[String:String]] = [[String:String]]()
//        search.append(seDate)
//        
//        //[{start_date: "2023-03-15 06:00:00", end_date: "2023-03-17 05:59:59"}]
//        
//        let urlString = "\(HttpUrls.URL.FARM_URL)/\(HttpUrls.NAME.SUMMARY)"
//        let parameters: [String: Any] = [
//            "group" : 0,
//            "isFarm" : 1,
//            "devices" : uniqDevice,
//            "channels" : channels,
//            "search" : search
//        ]
//        print("selftoken = \(self.token)")
//        self.token = lvmToken
//        print("lvmToken = \(lvmToken)")
//        
//        print("paramssmarap = \(parameters as AnyObject)")
//        
//        sChartView.startLoading()
//        
//        NetworkManagerJSONEncodingUTF8<ChartResponse>.fetch(from: urlString, method: .post, parameter: parameters, token: self.token) { result in
//            switch result {
//            case .success(let response):
//                if response.code == nil {
//                    self.chartM = response.data!
//                    print("SummaryModel : \(self.chartM)")
//                    
//                    
//                    self.chartM.search?.forEach { sch in
//                        let ssch : [String:[ChartItem]] = sch as? [String:[ChartItem]] ?? [String:[ChartItem]]()
//                        var isFirst = true
//                        
//                        for (key, value) in ssch {
//                            value.forEach { item in
//                                let item:ChartItem = item
//                                self.chartData.items?.append(item)
//                                self.chartData.time?.append(item.time!.toDate(.localGraphDateTime) ?? Date())
//                                
//                                // 차트에 보여질 아이템 생성
//                                var cItem:ChartItems = ChartItems()
//                                cItem.time = item.time!.toDate(.isoDateTimeSec) ?? Date()
//                                cItem.maxCh = item.maxCh
//                                self.chartData.chartItems?.append(cItem)
//                            }
//                        }
//                        
//                        for (key, value) in ssch {
//                            print("key: \(key) and value: \(value)")
//                            value.forEach { item in
//                                if isFirst {
//                                    for (iKey, iValue) in item.maxCh.sorted(by: <) {
//                                        let chartV:ChartValue = ChartValue(date: item.time, values: [iValue])
//                                        let chartSet:ChartDataSet = ChartDataSet(date: item.time!, value: iValue, ch: iKey)
//                                        self.chartData.vals?.append(iValue)
//                                        self.chartData.data?.append(chartV)
//                                        self.chartData.dataSet?.append(chartSet)
//                                    }
//                                }
//                                else {
//                                    for (iKey, iValue) in item.maxCh.sorted(by: <) {
//                                        let chartV:ChartValue = ChartValue(date: item.time, values: [iValue])
//                                        let chartSet:ChartDataSet = ChartDataSet(date: item.time!, value: iValue, ch: iKey)
//                                        self.chartData.vals?.append(iValue)
//                                        self.chartData.data?.append(chartV)
//                                        self.chartData.dataSet?.append(chartSet)
//                                    }
//                                }
//                                isFirst = false
//                            }
////                            print("이거맞아? = \(self.chartData.data!["2023-03-15T06:00:00Z"])")
//                        }
////                        let schItem : [ChartItem] = ssch.values as? [ChartItem] ?? [ChartItem]()
////                        schItem.forEach { cItem in
////                            print("cCccccccCItem = \(cItem)")
////                            let ccItem : ChartItem = (cItem as? ChartItem)!
////
////                            print("ttttemCCItem = \(ccItem)")
////
////
////                            var cTime = ccItem.time
////
////                            var cVal = Any as! [Float]?
////                            ccItem.maxCh.forEach { ch in
////                                cVal?.append[ch.value]
////                                print("cValcValcValcVal = \(cVal)")
////                            }
////
////                            var ciValue : ChartValue = ChartValue(date:cTime, values:cVal)
////                            var ciValue : ChartValue = ChartValue(date:"\(cItem.time)", values:[cItem.maxCh.values])
//                            
////                            var charItem: ChartItem
////                            charItem.time
////                        }
//                    }
//                        
//                    
////                    let encode = JSONEncoder()
////                    let data = try? encode.encode(self.loadedM)
////
////                    print("endoedData : \(data)")
////
////                    let loadedUser = self.loadedM.user
////                    let eLoadedUser = try? encode.encode(self.loadedM.user)
////
////                    UserDefaults.standard.set(eLoadedUser, forKey: Common.UserDefaultKey.LOADED_USER)
////                    UserDefaults.standard.set(data , forKey: Common.UserDefaultKey.LOADED)
////
////
////                    print("loadedUser = \(self.loadedM.user)")
////                    print("loadedUser = \(loadedUser)")
////                    print("encoded loadedUser = \(eLoadedUser)")
////
//////                    let dLoadedUser = try? decode.decode(User.self, from: eLoadedUser!)
////                    if let dLoadedUser = UserDefaults.standard.object(forKey: Common.UserDefaultKey.LOADED_USER) as? Data {
////                        let decode = JSONDecoder()
////                        if let savedObject = try? decode.decode(User.self, from: dLoadedUser) {
////                            print("decoded loadedUser = \(savedObject)")
////                        }
////                    }
//                    
////                    self.sChartView.initChartValue(chartData: self.chartData)
//                    self.sChartView.stopLoading()
//                    
////                    self.sChartView.drawChart(chartData: self.chartData)
//                    
////                    self.sChartView.cvalcval = [
////                        self.chartData.data!.forEach { data in
////                                .init(date: data.date, value: data.values![0])
////                        }
////                    ]
////                    print("cvalcvaldata = \(self.sChartView.cvalcval)")
//                }
//                else {
//                    //에러메시지 출력
//                    self.sChartView.stopLoading()
//                }
//            case .failure(let error):
//                print(error)
//                print(error.localizedDescription)
//                self.sChartView.stopLoading()
//            }
//        }
//    }
//    
//}
