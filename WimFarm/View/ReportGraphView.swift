//
//  ReportGraphView.swift
//  WimFarm
//
//  Created by ulalalab on 2023/07/11.
//

import SwiftUI
import Charts

struct ReportGraphView: View {
    @EnvironmentObject var loginVM: LoginVM
    @EnvironmentObject private var reportGraphVM: ReportGraphVM
    @State private var selectedSegment = 0
    @State private var selectedTrend = 0
    
    var selectedSensors : [DeviceConfig]
    var startDate : Date
    var endDate : Date

    init(selectedSensors: [DeviceConfig], startDate: Date, endDate: Date) {
        self.selectedSensors = selectedSensors
        self.startDate = startDate
        self.endDate = endDate
    }
    
    
    func getChart() {
        self.reportGraphVM.summary(lvmToken: self.loginVM.token, selectedSensors: self.selectedSensors, startDate: self.startDate, endDate: self.endDate)
    }
    
    var body: some View {
        ZStack {
            Color.colorWFGrayBG.ignoresSafeArea()
            
            VStack {
                if reportGraphVM.cdEntries.count > 0 {
                    if self.selectedSensors.count == 1 {
                        MultiLineChartView(entries: reportGraphVM.cdEntries)
                    } else {
                        HStack {
                            Spacer()
                            CustomSegmentedControl(preselectedIndex: $selectedSegment, options: ["multi".localized, "single".localized])
                                .frame(width: 280)
                            let _ = print("selectedSegment = \(selectedSegment)")
                            Spacer()
                        }
//                        MultiLineChartView(entries: reportGraphVM.cdEntries)
                        if selectedSegment == 1 {
                            
//                            MultiLineChartView(entries: reportGraphVM.cdEntries)
                            ZStack {
                                SingleLineChartView(index: selectedTrend, entry: reportGraphVM.cdEntries[selectedTrend])
                                
                                if reportGraphVM.cdEntries[selectedTrend].cdEntry?.count == 0 {
                                    
                                    Text("not_data").frame(maxWidth: .infinity)
                                        .font(Font.custom("NotoSansCJKkr-Bold", size: 18))
                                        .foregroundColor(Color.colorWFTextBlack)
                                        .padding(EdgeInsets(top:0, leading: 0, bottom: 20, trailing: 0))
                                }
                            }
                            
                            HStack {
                                Spacer()
                                Button(action: {
                                        if selectedTrend < reportGraphVM.cdEntries.count - 1 {
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
                                            selectedTrend = reportGraphVM.cdEntries.count-1
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
                            MultiLineChartView(entries: reportGraphVM.cdEntries)
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
                    AppDelegate.orientationLock = UIInterfaceOrientationMask.landscape
                    windowScene?.requestGeometryUpdate(.iOS(interfaceOrientations: .portrait)) { error in print(error) }
                    UIApplication.shared.keyWindow?.rootViewController?.setNeedsUpdateOfSupportedInterfaceOrientations()
                } else {
                    // Fallback on earlier versions
                    AppDelegate.orientationLock = UIInterfaceOrientationMask.landscape
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

private extension ReportGraphView {
    var multiTab: some View {
        HStack {
            Spacer()
            
            Spacer()
        }
        .padding(20)
    }
}

struct ReportGraphView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["en", "ko"], id: \.self) { id in
            ReportGraphView(selectedSensors: [DeviceConfig](), startDate: Date(), endDate: Date())
                        .environment(\.locale, .init(identifier: id))
                        .environmentObject(ReportGraphVM())
                }
    }
}
