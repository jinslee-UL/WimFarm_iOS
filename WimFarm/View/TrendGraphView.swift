//
//  TrendGraphView.swift
//  WimFarm
//
//  Created by ulalalab on 2023/04/20.
//

import SwiftUI
import Charts

struct TrendGraphView: View {
    @EnvironmentObject var loginVM: LoginVM
    @EnvironmentObject private var dashboardVM: DashboardVM
    @EnvironmentObject private var trendVM: TrendVM
    @State private var selectedSegment = 0
    @State private var selectedTrend = 0
    
    var widget: WidgetList
    var item: WidgetItem
    
    init(widget: WidgetList, item: WidgetItem) {
        self.widget = widget
        self.item = item
    }
    
//    let colors: [Color] = [.red, .green, .purple, .teal, .orange]
//    var randomGradient: AnyGradient {
//        if let color = colors.randomElement() {
//            return color.gradient
//        }
//        else {
//            return Color.red.gradient
//        }
//    }
    
    func getChart() {
        self.trendVM.summary(lvmToken: self.loginVM.token, widgetLst: widget, df: self.item.df ?? "all")
    }
    
    var body: some View {
        ZStack {
            Color.colorWFGrayBG.ignoresSafeArea()
            
            VStack {
                if trendVM.cdEntries.count > 0 {
                    if widget.type == "single" {
                        MultiLineChartView(entries: trendVM.cdEntries)
                    } else if item.df != nil {
                        MultiLineChartView(entries: trendVM.cdEntries)
                    } else {
                        HStack {
                            Spacer()
                            CustomSegmentedControl(preselectedIndex: $selectedSegment, options: ["multi".localized, "single".localized])
                                .frame(width: 280)
                            let _ = print("selectedSegment = \(selectedSegment)")
                            Spacer()
                        }
//                        MultiLineChartView(entries: trendVM.cdEntries)
                        if selectedSegment == 1 {
                            
//                            MultiLineChartView(entries: trendVM.cdEntries)
                            ZStack {
                                SingleLineChartView(index: selectedTrend, entry: trendVM.cdEntries[selectedTrend])
                                
                                if self.trendVM.cdEntries[selectedTrend].cdEntry?.count == 0 {
                                    
                                    Text("not_data").frame(maxWidth: .infinity)
                                        .font(Font.custom("NotoSansCJKkr-Bold", size: 18))
                                        .foregroundColor(Color.colorWFTextBlack)
                                        .padding(EdgeInsets(top:0, leading: 0, bottom: 20, trailing: 0))
                                }
                            }
                            
                            HStack {
                                Spacer()
                                Button(action: {
                                        if selectedTrend < trendVM.cdEntries.count - 1 {
                                            selectedTrend += 1
                                        }
                                        else {
                                            selectedTrend = 0
                                        }
                                        let _ = print("selected Trend = \(selectedTrend)")
                                    }, label: {
                                        HStack {
                                            Image("iconUp")
                                            Text("trend_report_channel_up").frame(maxWidth: .infinity)
                                                .font(Font.custom("NotoSansCJKkr-Bold", size: 14))
                                                .foregroundColor(Color.colorWFWhite)
                                        }
                                })
                                    .buttonStyle(.bordered)
                                    .controlSize(.large)
                                    .frame(width: 180.0, height: 40.0)
                                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.colorWFGrayBtnNor))
                                
                                Button(action: {
                        //                loginVM.login(withdEmail: email, password: password)
                                        if selectedTrend > 0 {
                                            selectedTrend -= 1
                                        }
                                        else {
                                            selectedTrend = trendVM.cdEntries.count-1
                                        }
                                        let _ = print("selected Trend = \(selectedTrend)")
                                    }, label: {
                                        HStack {
                                            Image("iconDown")
                                            Text("trend_report_channel_down").frame(maxWidth: .infinity)
                                                .font(Font.custom("NotoSansCJKkr-Bold", size: 14))
                                                .foregroundColor(Color.colorWFWhite)
                                        }
                                })
                                    .buttonStyle(.bordered)
                                    .controlSize(.large)
                                    .frame(width: 180.0, height: 40.0)
                                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.colorWFGrayBtnNor))
                                
                                Spacer()
                            }
                        }
                        else {
                            MultiLineChartView(entries: trendVM.cdEntries)
                        }
                    }
                }
            }
            .padding(20)
        }
        .onAppear {
            getChart()
//            AppDelegate.orientationLock = UIInterfaceOrientationMask.landscapeRight
//            UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
//            UINavigationController.attemptRotationToDeviceOrientation()
            
            DispatchQueue.main.async {
                if #available(iOS 16.0, *) {
                    let windowScene = UIApplication.shared.keyWindow?.windowScene
                    AppDelegate.orientationLock = UIInterfaceOrientationMask.landscapeRight
                    windowScene?.requestGeometryUpdate(.iOS(interfaceOrientations: .portrait)) { error in print(error) }
                    UIApplication.shared.keyWindow?.rootViewController?.setNeedsUpdateOfSupportedInterfaceOrientations()
                } else {
                    // Fallback on earlier versions
                    AppDelegate.orientationLock = UIInterfaceOrientationMask.landscapeRight
                    UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
                    UINavigationController.attemptRotationToDeviceOrientation()
                }
            }
        }
        .onDisappear {
            DispatchQueue.main.async {
//                AppDelegate.orientationLock = UIInterfaceOrientationMask.portrait
//                UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
//                UINavigationController.attemptRotationToDeviceOrientation()
                
                
                if #available(iOS 16.0, *) {
                   let windowScene = UIApplication.shared.keyWindow?.windowScene
                   AppDelegate.orientationLock = UIInterfaceOrientationMask.portrait
                   windowScene?.requestGeometryUpdate(.iOS(interfaceOrientations: .portrait)) { error in print(error) }
                   UIApplication.shared.keyWindow?.rootViewController?.setNeedsUpdateOfSupportedInterfaceOrientations()
                } else {
                   // Fallback on earlier versions
                   AppDelegate.orientationLock = UIInterfaceOrientationMask.portrait
                   UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
                   UINavigationController.attemptRotationToDeviceOrientation()
                }
            }
        }
        
    }
}

private extension TrendGraphView {
    var multiTab: some View {
        HStack {
            Spacer()
            
            Spacer()
        }
        .padding(20)
    }
}

struct TrendGraphView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["en", "ko"], id: \.self) { id in
            TrendGraphView(widget: WidgetList(), item: WidgetItem())
                        .environment(\.locale, .init(identifier: id))
                        .environmentObject(TrendVM())
                }
    }
}

struct MultiLineChartView : UIViewRepresentable {
    
    var entries : [ChartDataEntries]
    
    func makeUIView(context: Context) -> LineChartView {
        let chart = LineChartView()
        return createChart(chart: chart)
    }
    
    func updateUIView(_ uiView: LineChartView, context: Context) {
//        uiView.data = addData()
        uiView.data = updateData(entries: entries)
    }
                         
    func createChart(chart: LineChartView) -> LineChartView{
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        
        chart.chartDescription.enabled = true
        chart.xAxis.drawGridLinesEnabled = true
        chart.xAxis.drawLabelsEnabled = true
        chart.xAxis.drawAxisLineEnabled = true
        chart.xAxis.labelPosition = .bottom
        chart.rightAxis.enabled = false
        chart.leftAxis.enabled = true
        chart.drawBordersEnabled = false
        chart.legend.form = .square
        chart.xAxis.labelCount = 6
        chart.xAxis.forceLabelsEnabled = true
        chart.xAxis.granularityEnabled = true
        chart.xAxis.granularity = 1
        if (entries.count > 0) {
            chart.xAxis.valueFormatter = CustomChartFormatter(days: entries[0].days ?? [String]())
        }
//        chart.xAxis.valueFormatter = CustomChartFormatter(days: entries[0].time ?? [EntryTimes]())
//        chart.xAxis.valueFormatter = dateFormatter.string(from: entries[0].time[0]!.time) as! any AxisValueFormatter
        
        
        let entries:[ChartDataEntries] = entries
        
        var dataSet:[LineChartDataSet] = [LineChartDataSet]()
        
        entries.forEach { entry in
            dataSet.append(LineChartDataSet(entries: entry.cdEntry ?? [ChartDataEntry](), label: "\(entry.df ?? "No data")"))
        }
        
        chart.data = LineChartData(dataSets: dataSet)
//        chart.data = addData()
        return chart
    }
    
//    func addData() -> LineChartData{
//        let data = LineChartData(dataSets: [
//
//            entries.forEach { entry in
//                generateLineChartDataSet(dataSetEntries: entry.cdEntry ?? [ChartDataEntry](), color: UIColor(Color(#colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1))), fillColor: UIColor(Color(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1))))
//            }
//        ])
//        return data
//    }
    
    func updateData(entries: [ChartDataEntries]) -> LineChartData{
        var data = LineChartData(dataSets: [ChartDataSetProtocol]())
        
//        ForEach(entries ?? [ChartDataEntries](), id: \.df) { entry in
        var index = 0
        for entry in entries {
            data.append(generateLineChartDataSet(dataSetEntries: entry.cdEntry!, label: entry.df!, color: UIColor(Color.colorGraph[index]), fillColor: UIColor(Color.colorGraph[index])))
            index += 1
//            data.append(generateLineChartDataSet(dataSetEntries: entry.cdEntry!, label: entry.df!, color: UIColor(Color(#colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1))), fillColor: UIColor(Color(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)))))
        }
        
        return data
    }

    func generateLineChartDataSet(dataSetEntries: [ChartDataEntry], label: String, color: UIColor, fillColor: UIColor) -> LineChartDataSet{
        var dataSet = LineChartDataSet(entries: dataSetEntries, label: label)
        dataSet.colors = [color]
        dataSet.mode = .cubicBezier
        dataSet.circleRadius = 4
        dataSet.circleHoleColor = color
//        dataSet.fill = ColorFill(color: fillColor)
        dataSet.drawFilledEnabled = false
        dataSet.setCircleColor(UIColor.clear)
        dataSet.lineWidth = 2
        dataSet.valueTextColor = color
        dataSet.valueFont = UIFont(name: "Avenir", size: 12)!
        
        if dataSetEntries.isEmpty {
            let empty:ChartDataEntry = ChartDataEntry(x: 0, y: 0)
            dataSet = LineChartDataSet(entries: [empty], label: label)
            dataSet.setCircleColor(UIColor.clear)
            dataSet.circleRadius = 0
            dataSet.lineWidth = 0
            dataSet.valueFont = UIFont(name: "Avenir", size: 0)!
        }
        
        return dataSet
    }
    
}

struct SingleLineChartView : UIViewRepresentable {
    
    var index : Int
    var entry : ChartDataEntries
    
    func makeUIView(context: Context) -> LineChartView {
        let chart = LineChartView()
        return createChart(chart: chart)
    }
    
    func updateUIView(_ uiView: LineChartView, context: Context) {
//        uiView.data = addData()
        uiView.data = updateData(entry: entry)
    }
                         
    func createChart(chart: LineChartView) -> LineChartView{
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        
        chart.chartDescription.enabled = true
        chart.xAxis.drawGridLinesEnabled = true
        chart.xAxis.drawLabelsEnabled = true
        chart.xAxis.drawAxisLineEnabled = true
        chart.xAxis.labelPosition = .bottom
        chart.rightAxis.enabled = false
        chart.leftAxis.enabled = true
        chart.drawBordersEnabled = false
        chart.legend.form = .square
        chart.xAxis.labelCount = 6
        chart.xAxis.forceLabelsEnabled = true
        chart.xAxis.granularityEnabled = true
        chart.xAxis.granularity = 1
        chart.xAxis.valueFormatter = CustomChartFormatter(days: entry.days ?? [String]())
        
        
        let entry:ChartDataEntries = entry
        
        var dataSet:[LineChartDataSet] = [LineChartDataSet]()
        
//        entries.forEach { entry in
            dataSet.append(LineChartDataSet(entries: entry.cdEntry ?? [ChartDataEntry](), label: "\(entry.df ?? "No data")"))
//        }
        
        chart.data = LineChartData(dataSets: dataSet)
        
        return chart
    }
    
    func updateData(entry: ChartDataEntries) -> LineChartData{
        var data = LineChartData(dataSets: [ChartDataSetProtocol]())
        
        data.append(generateLineChartDataSet(dataSetEntries: entry.cdEntry!, label: entry.df!, color: UIColor(Color.colorGraph[index]), fillColor: UIColor(Color.colorGraph[index])))
        
        return data
    }

    func generateLineChartDataSet(dataSetEntries: [ChartDataEntry], label: String, color: UIColor, fillColor: UIColor) -> LineChartDataSet{

        var dataSet = LineChartDataSet(entries: dataSetEntries, label: label)
                
        dataSet.colors = [color]
        dataSet.mode = .cubicBezier
        dataSet.circleRadius = 4
        dataSet.circleHoleColor = color
//        dataSet.fill = ColorFill(color: fillColor)
        dataSet.drawFilledEnabled = false
        dataSet.setCircleColor(UIColor.clear)
        dataSet.lineWidth = 2
        dataSet.valueTextColor = color
        dataSet.valueFont = UIFont(name: "Avenir", size: 12)!
        
        if dataSetEntries.isEmpty {
            let empty:ChartDataEntry = ChartDataEntry(x: 0, y: 0)
            dataSet = LineChartDataSet(entries: [empty], label: label)
            dataSet.setCircleColor(UIColor.clear)
            dataSet.circleRadius = 0
            dataSet.lineWidth = 0
            dataSet.valueFont = UIFont(name: "Avenir", size: 0)!
        }

        return dataSet
    }
    
}

class CustomChartFormatter: NSObject, AxisValueFormatter {
    var days: [String]
    
    init(days: [String]) {
        self.days = days
    }
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
//        return days[Int(value)]
        
        let val = Int(value)
            
        if val >= 0 && val < days.count {
            return days[Int(val)]
        }
            
        return ""
    }
}
