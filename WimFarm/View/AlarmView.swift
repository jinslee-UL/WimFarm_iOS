//
//  AlarmView.swift
//  WimFarm
//
//  Created by ulalalab on 2021/11/18.
//

import SwiftUI

struct AlarmView: View {
    @EnvironmentObject private var screenRouter: ScreenRouter
    @EnvironmentObject var loginVM: LoginVM
    @EnvironmentObject private var alarmVM: AlarmVM
    
    init() {
//        UINavigationBar.appearance().backgroundColor = .white
    }
    
    func getAlarm() {
        self.alarmVM.alarmCompany()
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.colorWFGrayBG.ignoresSafeArea()
                
                ScrollView(.vertical) {
                    ForEach(self.alarmVM.alarmItemList) { alarm in
//                        Spacer(minLength: 10)
                        AlarmItem(startTime: alarm.notify_start_date!, title: "\(alarm.groups_comment!) > \(alarm.device_comment!)", deviceId: alarm.device_code!, channel: alarm.notify_channel!, contents: alarm.notify_comment!, duringTime: alarm.notify_time!, level: alarm.notify_level!)
                    }
                }
                .padding(EdgeInsets(top:70, leading: 10, bottom: 54, trailing: 10))
//                .padding(10)
            }
            .navigationBarHidden(false)
//            .navigationTitle(Text("Alarm"))
//            .foregroundColor(Color.colorWFTextBlack)
            .navigationBarBackButtonHidden(true)
            .edgesIgnoringSafeArea(.top)
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarTitleDisplayMode(.inline)
            .toolbar() {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image("back")
                        .foregroundColor(Color.colorWFBlue)
                        .onTapGesture {
                            screenRouter.currentPage = screenRouter.exPage
                        }
                }
                ToolbarItem(placement: .principal) {
                    ZStack {
                        Color.colorWFWhite.ignoresSafeArea()

                        Text("alarm_today_title")
                            .foregroundColor(Color.colorWFTextBlack)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Text("alarm_daily_report")
                        .foregroundColor(Color.colorWFBlue)
                        .onTapGesture {
                            screenRouter.exPage = screenRouter.currentPage
                            screenRouter.currentPage = .alarmPast
                        }
                }
            }
            .onAppear(perform: getAlarm)
        }
    }
}

struct AlarmItem: View {
    let startTime, title, deviceId, channel, contents: String
    let duringTime, level: Int
    @State var expand: Bool = false
    
    var body: some View {
        VStack(spacing: 1) {
            if expand {
                VStack (spacing: 1) {
                    HStack {
                        let arrNSD = startTime.components(separatedBy: " ")
                        let startTimeOnly = arrNSD[1]
                        
                        Text("\(startTimeOnly)")
                            .foregroundColor(Color.colorWFTextBlack)
                            .frame(width: 86, height: 54, alignment: .center)
                            .font(.system(size:14, weight: .heavy, design: .default))
                        
                        Spacer()
                        
                        Text("\(title)")
                            .foregroundColor(Color.colorWFTextBlack)
                            .font(.system(size:14, weight: .heavy, design: .default))
                        
                        Spacer()
                        
                        if level == 1 {
                            Circle()
                                .fill(Color.colorCaution)
                                .frame(width: 15, height: 15, alignment: .center)
                        }
                        else if level == 2 {
                            Circle()
                                .fill(Color.colorWarning)
                                .frame(width: 15, height: 15, alignment: .center)
                        }
                        else if level == 3 {
                            Circle()
                                .fill(Color.colorDangers)
                                .frame(width: 15, height: 15, alignment: .center)
                        }
                        else if level == 4 {
                            Circle()
                                .fill(Color.colorLimit)
                                .frame(width: 15, height: 15, alignment: .center)
                        }
                        
                        Button(action: {
                            withAnimation {
                                expand.toggle()
                            }
                        }, label: {
                            Image("icon_up")
                                .padding(10)
                        })
                    }
                    HStack (spacing: 1) {
                        HStack {
                            Text("retention_time")
                                .foregroundColor(Color.colorWFTextBlack)
                                .frame(width: 88,height: 28, alignment: .center)
                                .font(.system(size:12, weight: .heavy, design: .default))
                        
                        }
                        .background(Color.colorWFGrayTbDark)
                        
                        HStack {
                            Text("  \(duringTime) second")
                                .foregroundColor(Color.colorWFTextBlack)
                                .frame(height:28)
                                .font(.system(size:12, weight: .heavy, design: .default))
                            
                            Spacer()
                        }
                        .background(Color.colorWFGrayTbLight)
                    }
                    HStack (spacing: 1) {
                        HStack {
                            Text("device_ID")
                                .foregroundColor(Color.colorWFTextBlack)
                                .frame(width: 88,height: 28, alignment: .center)
                                .font(.system(size:12, weight: .heavy, design: .default))
                        }
                        .background(Color.colorWFGrayTbDark)
                        
                        HStack {
                            Text("  \(deviceId)")
                                .foregroundColor(Color.colorWFTextBlack)
                                .frame(height:28)
                                .font(.system(size:12, weight: .heavy, design: .default))
                            
                            Spacer()
                        }
                        .background(Color.colorWFGrayTbLight)
                    }
                    HStack (spacing: 1) {
                        HStack {
                            Text("channel_name")
                                .foregroundColor(Color.colorWFTextBlack)
                                .frame(width: 88,height: 28, alignment: .center)
                                .font(.system(size:12, weight: .heavy, design: .default))
                        }
                        .background(Color.colorWFGrayTbDark)
                        
                        HStack {
                            Text("  \(channel)")
                                .foregroundColor(Color.colorWFTextBlack)
                                .frame(height:28)
                                .font(.system(size:12, weight: .heavy, design: .default))
                            
                            Spacer()
                        }
                        .background(Color.colorWFGrayTbLight)
                    }
                    HStack (spacing: 1) {
                        HStack {
                            Text("content")
                                .foregroundColor(Color.colorWFTextBlack)
                                .frame(width: 88,height: 28, alignment: .center)
                                .font(.system(size:12, weight: .heavy, design: .default))
                        }
                        .background(Color.colorWFGrayTbDark)
                        
                        HStack {
                            Text("  \(duringTime) second")
                                .foregroundColor(Color.colorWFTextBlack)
                                .frame(height:28)
                                .font(.system(size:12, weight: .heavy, design: .default))
                            
                            Spacer()
                        }
                        .background(Color.colorWFGrayTbLight)
                    }
                }
                .background(Color.colorWFWhite)
            }
            else {
                HStack (spacing: 0) {
                    let arrNSD = startTime.components(separatedBy: " ")
                    let startTimeOnly = arrNSD[1]
                    
                    Text("\(startTimeOnly)")
                        .foregroundColor(Color.colorWFTextBlack)
                        .frame(width: 86, height: 54, alignment: .center)
                        .font(.system(size:14, weight: .light, design: .default))
                    
                    Spacer()
                    
                    Text("\(title)")
                        .foregroundColor(Color.colorWFTextBlack)
                        .font(.system(size:14, weight: .light, design: .default))
                    
                    Spacer()
                    
                    if level == 1 {
                        Circle()
                            .fill(Color.colorCaution)
                            .frame(width: 15, height: 15, alignment: .center)
                    }
                    else if level == 2 {
                        Circle()
                            .fill(Color.colorWarning)
                            .frame(width: 15, height: 15, alignment: .center)
                    }
                    else if level == 3 {
                        Circle()
                            .fill(Color.colorDangers)
                            .frame(width: 15, height: 15, alignment: .center)
                    }
                    else if level == 4 {
                        Circle()
                            .fill(Color.colorLimit)
                            .frame(width: 15, height: 15, alignment: .center)
                    }
                    
                    Button(action: {
                        withAnimation {
                            expand.toggle()
                        }
                    }, label: {
                        Image("icon_down")
                            .padding(10)
                    })
                }
                .background(Color.colorWFWhite)
            }
        }
        .padding(0)
        .background(Color.colorWFGrayDivider)
    }
}

struct AlarmView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["en", "ko"], id: \.self) { id in
                        AlarmView()
                        .environment(\.locale, .init(identifier: id))
                        .environmentObject(AlarmVM())
                }
    }
}
