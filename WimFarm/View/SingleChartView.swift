////
////  SingleChartView.swift
////  WimFarm
////
////  Created by ulalalab on 2023/03/16.
////
//
//import SwiftUI
////import SwiftUICharts
//import Charts
//
//struct SingleChartView: View {
//    @EnvironmentObject var loginVM: LoginVM
//    @EnvironmentObject private var dashboardVM: DashboardVM
//    @EnvironmentObject private var chartVM: ChartVM
//    @State private var selectedElement: ChartItems = ChartItems()
//    
//    var widget: WidgetList
//    var item: WidgetItem
//    
//    init(widget: WidgetList, item: WidgetItem) {
//        self.widget = widget
//        self.item = item
//    }
//    
//    func getChart() {
//        self.chartVM.summary(lvmToken: self.loginVM.token, widgetLst: widget)
//    }
//    
//    
//    var body: some View {
//        ZStack {
//            Color.colorWFGrayBG.ignoresSafeArea()
//            
//            VStack {
//                
//                Chart {
////                    ForEach(self.chartVM.chartData.items ?? [ChartItem](), id: \.id) { data in
////                        if self.item.channel != nil {
////                            let iCh = "max_\(self.item.channel!)"
////                            let maxCh:[String:Float] = data.maxCh
////                            let _ = print("maxCHCHCHCH = \(maxCh)")
////                            let _ = print("tttttt = \(data.time!)")
////                            //                        for (key, value) in maxCh {
////                            //                        ForEach(maxCh) { mCh in
////                            ForEach(data.maxCh.sorted(by: >), id: \.key) { k, v in
////                                if k == iCh {
////                                    LineMark(
////                                        x: .value("Date", data.time!),
//////                                        x: .value("Date", data.time!),
////                                        y: .value("Value", v)
////                                    )
////                                    .foregroundStyle(Color.colorWFGreenBG)
////                                    let _ = print("kkk = \(k), vvv = \(v)")
////                                }
////                            }
////                        }
////                        else {
////                            let maxCh:[String:Float] = data.maxCh
////                            let _ = print("maxCHCHCHCH = \(maxCh)")
////                            let _ = print("tttttt = \(data.time!)")
////                            //                        for (key, value) in maxCh {
////                            //                        ForEach(maxCh) { mCh in
////                            ForEach(data.maxCh.sorted(by: >), id: \.key) { k, v in
////                                LineMark(
////                                    x: .value("Date", data.time!),
////                                    y: .value("Value", v)
////                                )
////                                .foregroundStyle(Color.colorWFGreenBG)
////                                let _ = print("kkk = \(k), vvv = \(v)")
////                            }
////                        }
////                    }
//                    ForEach(self.chartVM.chartData.chartItems ?? [ChartItems](), id: \.id) { data in
//                        if self.item.channel != nil {
//                            let iCh = "max_\(self.item.channel!)"
//                            let maxCh:[String:Float] = data.maxCh
//                            let _ = print("maxCHCHCHCH = \(maxCh)")
//                            let _ = print("tttttt = \(data.time!)")
//                            //                        for (key, value) in maxCh {
//                            //                        ForEach(maxCh) { mCh in
//                            ForEach(data.maxCh.sorted(by: >), id: \.key) { k, v in
//                                if k == iCh {
//                                    LineMark(
//                                        x: .value("Date", data.time!),
////                                        x: .value("Date", data.time!),
//                                        y: .value("Value", v)
//                                    )
//                                    .foregroundStyle(Color.colorWFGreenBG)
//                                    let _ = print("kkk = \(k), vvv = \(v)")
//                                }
//                            }
//                        }
//                        else {
//                            let maxCh:[String:Float] = data.maxCh
//                            let _ = print("maxCHCHCHCH = \(maxCh)")
//                            let _ = print("tttttt = \(data.time!)")
//                            //                        for (key, value) in maxCh {
//                            //                        ForEach(maxCh) { mCh in
//                            ForEach(data.maxCh.sorted(by: >), id: \.key) { k, v in
//                                LineMark(
//                                    x: .value("Date", data.time!),
//                                    y: .value("Value", v)
//                                )
//                                .foregroundStyle(Color.colorWFGreenBG)
//                                let _ = print("kkk = \(k), vvv = \(v)")
//                            }
//                        }
//                    }
//                }
////                .chartXScale(domain: self.chartVM.chartData.time ?? Date())
////                .chartXAxis {
////                    AxisMarks(
////                        position: .bottom, values: .automatic
//////                                    .foregroundStyle(Color.colorWFTextBlack).offset(x: 10).font(Font.custom("Montserrat-Medium", size: 16))
////                    ) { _ in
//                .chartXAxis {
//                    AxisMarks(position: .bottom, values: .automatic) { _ in
//                        AxisValueLabel()
//                            .foregroundStyle(Color.colorWFTextBlack).offset(x: 10).font(Font.custom("Montserrat-Medium", size: 16))
//                        AxisTick()
//                        AxisGridLine()
//                    }
//                }
//                .chartYAxis {
//                    AxisMarks(
//                        position: .leading
////                                    .foregroundStyle(Color.colorWFTextBlack).offset(x: 10).font(Font.custom("Montserrat-Medium", size: 16))
//                    ) {
//                        
//                        AxisValueLabel()
//                            .foregroundStyle(Color.colorWFTextBlack).offset(x: 10).font(Font.custom("Montserrat-Medium", size: 16))
//                        AxisTick()
//                        AxisGridLine()
//                    }
//                }
////                .chartOverlay { proxy in
////                    GeometryReader { geo in
////                        Rectangle().fill(.clear).contentShape(Rectangle())
////                            .gesture(
////                                SpatialTapGesture()
////                                    .onEnded { value in
////                                        let element = findElement(location: value.location, proxy: proxy, geometry: geo)
////                                        if selectedElement?.time == element?.time {
////                                            // If tapping the same element, clear the selection.
////                                            selectedElement = nil
////                                        } else {
////                                            selectedElement = element
////                                        }
////                                    }
////                                    .exclusively(
////                                        before: DragGesture()
////                                            .onChanged { value in
////                                                selectedElement = findElement(location: value.location, proxy: proxy, geometry: geo)
////                                            }
////                                    )
////                            )
////                    }
////                }
////                .chartBackground { proxy in
////                    ZStack(alignment: .topLeading) {
////                        GeometryReader { geo in
////                            if true,
////                               let selectedElement {
////                                let dateInterval = Calendar.current.dateInterval(of: .day, for: selectedElement.minute)!
////                                let startPositionX1 = proxy.position(forX: dateInterval.start) ?? 0
////
////                                let lineX = startPositionX1 + geo[proxy.plotAreaFrame].origin.x
////                                let lineHeight = geo[proxy.plotAreaFrame].maxY
////                                let boxWidth: CGFloat = 100
////                                let boxOffset = max(0, min(geo.size.width - boxWidth, lineX - boxWidth / 2))
////
////                                Rectangle()
////                                    .fill(.red)
////                                    .frame(width: 2, height: lineHeight)
////                                    .position(x: lineX, y: lineHeight / 2)
////
////                                VStack(alignment: .center) {
////                                    Text("\(selectedElement.day, format: .dateTime.year().month().day())")
////                                        .font(.callout)
////                                        .foregroundStyle(.secondary)
////                                    Text("\(selectedElement.sales, format: .number)")
////                                        .font(.title2.bold())
////                                        .foregroundColor(.primary)
////                                }
////                                .accessibilityElement(children: .combine)
////                                .accessibilityHidden(false)
////                                .frame(width: boxWidth, alignment: .leading)
////                                .background {
////                                    ZStack {
////                                        RoundedRectangle(cornerRadius: 8)
////                                            .fill(.background)
////                                        RoundedRectangle(cornerRadius: 8)
////                                            .fill(.quaternary.opacity(0.7))
////                                    }
////                                    .padding(.horizontal, -8)
////                                    .padding(.vertical, -4)
////                                }
////                                .offset(x: boxOffset)
////                            }
////                        }
////                    }
////                }
//                .background(Color.colorWFWhite)
//            }
//            .padding(20)
//        }//        .onAppear(perform: getChart)
//        .onAppear {
//            getChart()
//            AppDelegate.orientationLock = UIInterfaceOrientationMask.landscapeRight
//            UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
//            UINavigationController.attemptRotationToDeviceOrientation()
//        }
//        .onDisappear {
//            DispatchQueue.main.async {
//                AppDelegate.orientationLock = UIInterfaceOrientationMask.portrait
//                UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
//                UINavigationController.attemptRotationToDeviceOrientation()
//            }
//        }
//        
//    }
//    
////    private func findElement(location: CGPoint, proxy: ChartProxy, geometry: GeometryProxy) -> ChartItems? {
////        let relativeXPosition = location.x - geometry[proxy.plotAreaFrame].origin.x
////        let data = self.chartVM.chartData.chartItems
////        if let date = proxy.value(atX: relativeXPosition) as Date? {
////            // Find the closest date element.
////            var minDistance: TimeInterval = .infinity
////            var index: Int? = nil
//////            for salesDataIndex in data.indices {
////            for selectDataIndex in data!.indices {
////                let nthSalesDataDistance = data![selectDataIndex].time!.distance(to: date)
////                if abs(nthSalesDataDistance) < minDistance {
////                    minDistance = abs(nthSalesDataDistance)
////                    index = selectDataIndex
////                }
////            }
////            if let index {
////                return data![index]
////            }
////        }
////        return nil
////    }
//}
//
//struct SingleChartView_Previews: PreviewProvider {
//    static var previews: some View {
//        ForEach(["en", "ko"], id: \.self) { id in
//            SingleChartView(widget: WidgetList(), item: WidgetItem())
//                        .environment(\.locale, .init(identifier: id))
//                        .environmentObject(ChartVM())
//                }
//    }
//}
