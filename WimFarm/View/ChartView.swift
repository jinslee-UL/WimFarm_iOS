////
////  ChartView.swift
////  WimFarm
////
////  Created by ulalalab on 2023/04/01.
////
//
//import SwiftUI
//import Charts
//
//struct ChartView: View {
//    @EnvironmentObject var loginVM: LoginVM
//    @EnvironmentObject private var dashboardVM: DashboardVM
//    @EnvironmentObject private var chartVM: ChartVM
//    
//    @GestureState private var magnifyBy = 1.0
//    @State var cScale = 1.0
//    @State var lastcScale = 1.0
//    
//
//    var magnification: some Gesture {
//        MagnificationGesture()
//            .updating($magnifyBy) { currentState, gestureState, transaction in
//                gestureState = currentState
//            }
//            .onChanged { state in
//                let delta = state / lastcScale
//                cScale *= delta
//                lastcScale = state
//            }
//            .onEnded { State in
//                lastcScale = 1.0
//            }
//    }
//    
//    var widget: WidgetList
//    var item: WidgetItem
//    
//    init(widget: WidgetList, item: WidgetItem) {
//        self.widget = widget
//        self.item = item
//    }
//    
//    let colors: [Color] = [.red, .green, .purple, .teal, .orange]
//    var randomGradient: AnyGradient {
//        if let color = colors.randomElement() {
//            return color.gradient
//        }
//        else {
//            return Color.red.gradient
//        }
//    }
//    
//    func getChart() {
//        self.chartVM.summary(lvmToken: self.loginVM.token, widgetLst: widget)
//    }
//    
//    var body: some View {
//        ZStack {
//            Color.colorWFGrayBG.ignoresSafeArea()
//            
//            VStack {
////
////                GroupBox(label: Text("\(self.chartVM.chartData.title ?? "Graph")")
////                    .font(Font.custom("Montserrat-SemiBold", size: 18))
////                    .foregroundColor(Color.colorWFTextBlack)) {
//                        
//                        // 기존 iOS 기본 제공 Chart
//                        Chart {
//                            ForEach(self.chartVM.chartData.chartItems ?? [ChartItems](), id: \.id) { data in
////                            ForEach(self.chartVM.chartData.items ?? [ChartItem](), id: \.id) { data in
//                                //                        var arrItem = self.item.split("_")
//                                let maxCh:[String:Float] = data.maxCh
//                                let _ = print("maxCHCHCHCH = \(maxCh)")
//                                let _ = print("tttttt = \(data.time!)")
//                                //                        for (key, value) in maxCh {
//                                //                        ForEach(maxCh) { mCh in
//                                ForEach(data.maxCh.sorted(by: <), id: \.key) { k, v in
//                                    ForEach(self.chartVM.maxCh, id: \.self) { ch in
//                                        if(k == ch) {
//                                            //                                    var chColor = k.componentsSeparatedByString("_")
//                                            let arrChColor = k.components(separatedBy: "_")
//                                            let chColor = Int(arrChColor[2]) ?? 1
//                                            LineMark(
//                                                x: .value("Date", data.time!),
//                                                y: .value("Value", v),
//                                                series: .value("channel", k)
//                                            )
//                                            //                                    .foregroundStyle(Color.colorWFGreenBG)
//                                            .foregroundStyle(Color.colorGraph[chColor-1])
//                                            //                                    .foregroundStyle(by: .value("Week", steps.period))
//                                            .accessibilityLabel("\(v)")
//                                            .accessibilityValue("\(v)")
//                                            let _ = print("kkk = \(k), vvv = \(v), colorNum = \(chColor)")
//                                        }
//                                    }
//                                }
//                            }
////                    ForEach(self.chartVM.chartData.data ?? [ChartValue](), id: \.id) { data in
////                        LineMark(
////                            x: .value("Date", data.date!),
////                            y: .value("Value", data.values![0])
////                        )
////                        .foregroundStyle(Color.colorWFGreenBG)
////                    }
//                        }
//                        .chartXAxis {
//                            AxisMarks(
//                                position: .bottom
////                                    .foregroundStyle(Color.colorWFTextBlack).offset(x: 10).font(Font.custom("Montserrat-Medium", size: 16))
//                            ) {
//                                
//                                AxisValueLabel()
//                                    .foregroundStyle(Color.colorWFTextBlack).offset(x: 10).font(Font.custom("Montserrat-Medium", size: 16))
//                                AxisTick()
//                                AxisGridLine()
//                            }
//                        }
//                        .chartYAxis {
//                            AxisMarks(
//                                position: .leading
////                                    .foregroundStyle(Color.colorWFTextBlack).offset(x: 10).font(Font.custom("Montserrat-Medium", size: 16))
//                            ) {
//                                
//                                AxisValueLabel()
//                                    .foregroundStyle(Color.colorWFTextBlack).offset(x: 10).font(Font.custom("Montserrat-Medium", size: 16))
//                                AxisTick()
//                                AxisGridLine()
//                            }
//                        }
////                        .scaleEffect(magnifyBy)
//                        .scaleEffect(cScale)
//                        .background(Color.colorWFWhite)
//                        .gesture(magnification)
////                .chartXAxis {
////                    AxisMarks(position: .bottom, values: .stride(from: self.chartVM.chartData.time!.lowerBound, to: self.chartVM.chartData.time!.upperBound, by: (self.chartVM.chartData.time!.upperBound - self.chartVM.chartData.time!.lowerBound) / 5).map { $0 })
////                              {
//////                    AxisMarks(position: .bottom, values: .stride(by: .self.chartVM.chartData.time?.sorted(by: <))) {
//////                        _ in
////                        AxisTick()
////                        AxisGridLine()
//////                        AxisValueLabel(format: .dateTime.hour(), centered: true)
////                    }
////                }
////                .chartYAxis {
////                    AxisMarks(position: .leading, values: .stride(by: .self.chartVM.chartData.vals?.sorted(by: <))) {
////                        _ in
////                        AxisTick()
////                        AxisGridLine()
//////                        AxisValueLabel("\(1014 + (axis.index * 1))", centered: false)
////                    }
////                }
////                        .chartYAxisLabel(position: .leading, alignment: .center) {
////                            Text("Value")
////                                .font(Font.custom("Montserrat-Medium", size: 16))
////                                .foregroundColor(Color.colorWFTextBlack)
////                        }
////                        .chartXAxisLabel(position: .bottom, alignment: .center) {
////                            Text("Date")
////                                .font(Font.custom("Montserrat-Medium", size: 16))
////                                .foregroundColor(Color.colorWFTextBlack)
////                        }
//                        //                .chartPlotStyle { plotArea in
//                        //                    plotArea
//                        //                        .background(Color(hue: 0.12, saturation: 0.10, brightness: 0.92))
//                        //                }
//                        // Place the y-axis on the leading side of the chart
//                        //                .chartYAxis {
//                        //                    AxisMarks(position: .leading)
//                        //                    AxisTick()
//                        //                    AxisGridLine()
//                        //
//                        //                }
//                        //                .chartXAxis {
//                        //                    AxisMarks(position: .bottom)
//                        //                    AxisTick()
//                        //                    AxisGridLine()
//                        ////                    AxisValueLabel(format: .dateTime.hour(), centered: true)
//                        //                }
////                        .frame(height:400)
////                    }
////                    .groupBoxStyle(BackgroundGroupBoxStyle())
////                    .background(Color.colorWFGreenBG)
//            }
//            .padding(20)
//        }
////        .onReceive(NotificationCenter.Publisher(center: .default, name: UIDevice.orientationDidChangeNotification)) { in}
////        .onAppear(perform: getChart)
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
//}
//
//struct ChartView_Previews: PreviewProvider {
//    static var previews: some View {
//        ForEach(["en", "ko"], id: \.self) { id in
//            ChartView(widget: WidgetList(), item: WidgetItem())
//                        .environment(\.locale, .init(identifier: id))
//                        .environmentObject(ChartVM())
//                }
//    }
//}
