//
//  AlarmPastView.swift
//  WimFarm
//
//  Created by ulalalab on 2022/03/10.
//

import SwiftUI

struct AlarmPastView: View {
    @EnvironmentObject private var screenRouter: ScreenRouter
    @EnvironmentObject var loginVM: LoginVM
    @EnvironmentObject private var alarmVM: AlarmVM
    @State private var deviceConfig = [DeviceConfig]()
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var triggerNLink = false
    
    init() {
//        UINavigationBar.appearance().backgroundColor = .white
    }
    
    func getAlarmPast() {
        self.alarmVM.getAlarmDaily()
        triggerNLink = false
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.colorWFGrayBG.ignoresSafeArea()
                
                ScrollView(.vertical) {
                    if self.alarmVM.alarmPastList.content?.count ?? 0 > 0 {
                        ForEach(self.alarmVM.alarmPastContentList) { alarm in
                            //                        Spacer(minLength: 10)
                            //                        AlarmItem(startTime: alarm.notify_start_date!, title: "\(alarm.groups_comment!) > \(alarm.device_comment!)", deviceId: alarm.device_code!, channel: alarm.notify_channel!, contents: alarm.notify_comment!, duringTime: alarm.notify_time!, level: alarm.notify_level!)
//                            if alarm.subList.count > 0 {
//                                AlarmPastItem(date: alarm.regTime, title: alarm.wfName, deviceId: <#T##String#>, channel: <#T##String#>, contents: <#T##String#>, cCnt: <#T##Int#>, wCnt: <#T##Int#>, dCnt: <#T##Int#>, lCnt: <#T##Int#>)
//                            }
//                            else {
//                                
//                            }
                            AlarmPastItem(alarmVM: self.alarmVM, date: alarm.dt ?? "-", title: alarm.wfName ?? "-", cCnt: alarm.ccnt ?? 0, wCnt: alarm.wcnt ?? 0 , dCnt: alarm.dcnt ?? 0, lCnt: alarm.lcnt ?? 0, subList: alarm.subList ?? [Sublist](), triggerNLink: $triggerNLink)
                            let _ = print("alarm = \(alarm)")
                            
                        }
                    }
                    else {
                        
                        Text("not_data").frame(maxWidth: .infinity)
                            .font(Font.custom("NotoSansCJKkr-Bold", size: 18))
                            .foregroundColor(Color.colorWFTextBlack)
                            .padding(EdgeInsets(top:0, leading: 0, bottom: 20, trailing: 0))
                        
                    }
                }
                .padding(EdgeInsets(top:70, leading: 10, bottom: 54, trailing: 10))
                
                
                NavigationLink("", destination: ReportGraphView(selectedSensors: self.alarmVM.deviceConfig, startDate: self.alarmVM.startDate, endDate: self.alarmVM.endDate), isActive: $triggerNLink)
            }
            .navigationBarHidden(false)
            .navigationBarBackButtonHidden(true)
            .edgesIgnoringSafeArea(.top)
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarTitleDisplayMode(.inline)
            .toolbar() {
                ToolbarItem(placement: .principal) {
                    ZStack {
                        Color.colorWFWhite.ignoresSafeArea()

                        Text("alarm_daily_report")
                            .foregroundColor(Color.colorWFTextBlack)
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Image("btnClose")
                        .onTapGesture {
                            screenRouter.currentPage = screenRouter.exPage
                        }
                }
            }
            .onAppear(perform: getAlarmPast)
        }
    }
    
    
//    func linkToGraph(dConfig: [DeviceConfig], aDate: String) {
//        let format = DateFormatter()
//        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        format.timeZone = TimeZone(identifier:  "UTC")
//        
//        let startDate = "\(aDate) 00:00:00"
//        let endDate = "\(aDate) 23:59:59"
//        
//        self.deviceConfig = dConfig
//        self.startDate = format.date(from: startDate) ?? Date()
//        self.endDate = format.date(from: endDate) ?? Date()
//        
//        let _ = print("고마해라")
//    }
}

struct AlarmPastItem: View {
    
    let alarmVM: AlarmVM
    let date, title: String
    let cCnt, wCnt, dCnt, lCnt: Int
    let subList: [Sublist]
    @State var expand: Bool = false
    @Binding var triggerNLink: Bool
    
    var body: some View {
        VStack(spacing: 1) {
            if expand {
                VStack (spacing: 1) {
                    VStack {
                        HStack {
                            
                            Text("\(date)")
                                .foregroundColor(Color.colorWFTextBlack)
                                .font(.system(size:14, weight: .heavy, design: .default))
                                .padding(10)
                            
                        
                            HStack {
                                Circle()
                                    .fill(Color.colorCaution)
                                    .frame(width: 15, height: 15, alignment: .center)
                                
                                Text("\(cCnt)")
                                    .foregroundColor(Color.colorWFTextBlack)
                                    .font(.system(size:14, weight: .heavy, design: .default))
                                
                                Circle()
                                    .fill(Color.colorWarning)
                                    .frame(width: 15, height: 15, alignment: .center)
                                
                                Text("\(wCnt)")
                                    .foregroundColor(Color.colorWFTextBlack)
                                    .font(.system(size:14, weight: .heavy, design: .default))
                                
                                Circle()
                                    .fill(Color.colorDangers)
                                    .frame(width: 15, height: 15, alignment: .center)
                                
                                Text("\(dCnt)")
                                    .foregroundColor(Color.colorWFTextBlack)
                                    .font(.system(size:14, weight: .heavy, design: .default))
                                
                                Circle()
                                    .fill(Color.colorLimit)
                                    .frame(width: 15, height: 15, alignment: .center)
                                
                                Text("\(lCnt)")
                                    .foregroundColor(Color.colorWFTextBlack)
                                    .font(.system(size:14, weight: .heavy, design: .default))
                            }
                            .fixedSize()
                            
                            Spacer()
                            
                            Button(action: {
                                withAnimation {
                                    expand.toggle()
                                }
                            }, label: {
                                Image("icon_up")
                                    .padding(10)
                            })
                        }
                        
                        if subList.count > 0 {
                            ForEach(subList) { sub in
                                HStack {
                                    let strSubTitle = "  \(sub.wdName ?? " ") > \(sub.chName ?? " ")"
                                    Text("\(strSubTitle)")
//                                    Text("  \(sub.wdCode!)")
                                        .foregroundColor(Color.colorWFTextBlack)
                                        .font(.system(size:14, weight: .light, design: .default))
                                        .padding(5)
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        withAnimation {
                                            self.alarmVM.getDeviceConfig(subList: sub, aDate: self.date)
                                            triggerNLink.toggle()
                                        }
                                    }, label: {
                                        Image("iconGraph")
                                            .padding(10)
                                    })
                                }
                                .background(Color.colorWFGrayTbDark)
                                
                                HStack {
                                    Circle()
                                        .fill(Color.colorCaution)
                                        .frame(width: 15, height: 15, alignment: .center)
                                    
                                    Text("\(cCnt)")
                                        .foregroundColor(Color.colorWFTextBlack)
                                        .font(.system(size:14, weight: .light, design: .default))
                                    
                                    Circle()
                                        .fill(Color.colorWarning)
                                        .frame(width: 15, height: 15, alignment: .center)
                                    
                                    Text("\(wCnt)")
                                        .foregroundColor(Color.colorWFTextBlack)
                                        .font(.system(size:14, weight: .light, design: .default))
                                    
                                    Circle()
                                        .fill(Color.colorDangers)
                                        .frame(width: 15, height: 15, alignment: .center)
                                    
                                    Text("\(dCnt)")
                                        .foregroundColor(Color.colorWFTextBlack)
                                        .font(.system(size:14, weight: .light, design: .default))
                                    
                                    Circle()
                                        .fill(Color.colorLimit)
                                        .frame(width: 15, height: 15, alignment: .center)
                                    
                                    Text("\(lCnt)")
                                        .foregroundColor(Color.colorWFTextBlack)
                                        .font(.system(size:14, weight: .light, design: .default))
                                }
                                .fixedSize()
                                .background(Color.colorWFGrayTbLight)
                            }
                        }
                    }
                }
                .background(Color.colorWFWhite)
            }
            else {
                HStack (spacing: 0) {
                    Text("\(date)")
                        .foregroundColor(Color.colorWFTextBlack)
                        .font(.system(size:14, weight: .light, design: .default))
                        .padding(10)
                    
                    HStack {
                        Circle()
                            .fill(Color.colorCaution)
                            .frame(width: 15, height: 15, alignment: .center)
                        
                        Text("\(cCnt)")
                            .foregroundColor(Color.colorWFTextBlack)
                            .font(.system(size:14, weight: .light, design: .default))
                        
                        Circle()
                            .fill(Color.colorWarning)
                            .frame(width: 15, height: 15, alignment: .center)
                        
                        Text("\(wCnt)")
                            .foregroundColor(Color.colorWFTextBlack)
                            .font(.system(size:14, weight: .light, design: .default))
                        
                        Circle()
                            .fill(Color.colorDangers)
                            .frame(width: 15, height: 15, alignment: .center)
                        
                        Text("\(dCnt)")
                            .foregroundColor(Color.colorWFTextBlack)
                            .font(.system(size:14, weight: .light, design: .default))
                        
                        Circle()
                            .fill(Color.colorLimit)
                            .frame(width: 15, height: 15, alignment: .center)
                        
                        Text("\(lCnt)")
                            .foregroundColor(Color.colorWFTextBlack)
                            .font(.system(size:14, weight: .light, design: .default))
                    }
                    .fixedSize()
                    
                    Spacer()
                    
                    let tCnt:Int = cCnt + wCnt + dCnt + lCnt
                    
                    if tCnt > 0 {
                        Button(action: {
                            withAnimation {
                                expand.toggle()
                            }
                        }, label: {
                            Image("icon_down")
                                .padding(10)
                        })
                    }
                }
                .background(Color.colorWFWhite)
            }
        }
        .padding(0)
        .background(Color.colorWFGrayDivider)
    }
}

struct AlarmPastView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["en", "ko"], id: \.self) { id in
            AlarmPastView()
                    .environment(\.locale, .init(identifier: id))
                    .environmentObject(AlarmVM())
            }
    }
}
