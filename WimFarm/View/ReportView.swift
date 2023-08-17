//
//  ReportView.swift
//  WimFarm
//
//  Created by ulalalab on 2022/03/11.
//

import SwiftUI

struct ReportView: View {
    @EnvironmentObject private var screenRouter: ScreenRouter
    @EnvironmentObject var loginVM: LoginVM
    @EnvironmentObject private var reportVM: ReportVM
    @State private var selectedSensor = ""
    @State private var showPopup = false
    @State private var showStartPicker = false
    @State private var showEndPicker = false
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var triggerNLink = false
    
    init() {
//        UINavigationBar.appearance().backgroundColor = .white
    }
    
    func getDeviceChannel() {
//        self.alarmVM.alarmDaily()
        self.reportVM.loaded(lvmToken: loginVM.token)
        self.triggerNLink = false
        self.selectedSensor = ""
    }
    
//    func nlinkReport() {
//        NavigationLink("", destination: ReportGraphView(selectedSensors: self.reportVM.selectedDeviceList, startDate: startDate, endDate: endDate))
//    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.colorWFGrayBG.ignoresSafeArea()
                
//                ScrollView(.vertical) {
                    VStack {
                        Text("select_channel_trend_analysis_info")
                            .frame(alignment: .leading)
                            .bold()
                            .foregroundColor(Color.colorWFTextBlack)
                            .padding(EdgeInsets(top:10, leading: 0, bottom: 0, trailing: 0))
                        
                        ScrollView(.horizontal) {
                            HStack {
                                
                                ForEach(self.reportVM.filterList) { filter in
                                    ReportChannelItem(chName: filter.sensor_name!, selected: self.selectedSensor)
                                        .onTapGesture {
                                            self.selectedSensor = filter.sensor_name!
                                            self.reportVM.selectedChannel(filterIdx: filter.sensor_idx!)
                                        }
                                }
                            }
                            .padding(EdgeInsets(top:0, leading: 10, bottom: 0, trailing: 10))
                        }
                        
                        
                        VStack {
                            List {
                                ForEach(self.reportVM.reportDeviceList.indices, id: \.self) { index in
//                                    ReportDeviceItem(selectedFilter: self.selectedSensor, deviceName: self.reportVM.reportDeviceList[index].cateName!, checked: self.reportVM.reportDeviceList[index].checked!)
                                    ReportDeviceItem(selectedFilter: self.selectedSensor, deviceName: "\(self.reportVM.reportDeviceList[index].cateName!) _ \(self.reportVM.reportDeviceList[index].name ?? "")", checked: self.reportVM.reportDeviceList[index].checked!)
                                        .onTapGesture {
                                            self.reportVM.selectedDevice(dConfig: self.reportVM.reportDeviceList[index])
                                        }
//                                    ReportDeviceItem(deviceName: self.reportVM.selected
                                        .listRowInsets(EdgeInsets())
                                        .alignmentGuide(.listRowSeparatorLeading) { viewDimensions in
                                            return 0
                                        }
                                }
                            }
                            .listStyle(.plain)
                            .padding(10)
                        }
                        
                        if (self.selectedSensor.length > 0){
                            VStack {
                                Text("trend_report_explanation")
                                    .foregroundColor(Color.colorWFRed)
                                    .font(Font.custom("NotoSansCJKkr", size: 14))
                                
                                if(self.reportVM.selectedDeviceList.count > 0) {
                                    Button(action: {
                                        //                                    settingVM.unregisterToken()
                                        self.showPopup.toggle()
                                    }, label: {
                                        Text("report").frame(maxWidth: .infinity)
                                            .font(.system(size: 18.0))
                                            .foregroundColor(Color.colorWFWhite)
                                    }).frame(maxWidth: .infinity)
                                        .buttonStyle(.bordered)
                                        .controlSize(.large)
                                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.colorWFGreen))
                                }
                                else {
                                    Button(action: {
                                        //                                    settingVM.unregisterToken()
                                    }, label: {
                                        Text("report").frame(maxWidth: .infinity)
                                            .font(.system(size: 18.0))
                                            .foregroundColor(Color.colorWFWhite)
                                    }).frame(maxWidth: .infinity)
                                        .buttonStyle(.bordered)
                                        .controlSize(.large)
                                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.colorWFGrayBtnNor))
                                }
                            }
                        }
                        
                        NavigationLink("", destination: ReportGraphView(selectedSensors: self.reportVM.selectedDeviceList, startDate: startDate, endDate: endDate), isActive: $triggerNLink)
//                        if(triggerNLink == true) {
//                            NavigationLink("", destination: ReportGraphView(selectedSensors: self.reportVM.selectedDeviceList, startDate: startDate, endDate: endDate))
////                            let _ = self.triggerNLink = false
//
//                        }
                    }
//                }
                .padding(EdgeInsets(top:70, leading: 10, bottom: 54, trailing: 10))
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

                        Text("data_analysis")
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
            .onAppear(perform: getDeviceChannel)
        }
        .popupNavigationViewHalf(horizontalPadding: 40, show: $showPopup) {
//            VStack {
                VStack {
                    Text("analysis_date").frame(maxWidth: .infinity)
                        .font(Font.custom("NotoSansCJKkr-Bold", size: 20.0))
                        .foregroundColor(Color.colorWFTextBlack)
                        .padding(20)
                    
                    HStack {
                        Text("start_date")
                            .font(Font.custom("NotoSansCJKkr", size: 16.0))
                            .foregroundColor(Color.colorWFTextBlack)
                        
                        
                        Button (action: {
                            withAnimation {
                                showStartPicker.toggle()
                            }
                        },  label: {
                            var sDate = ""
                            Text("\(sDate.yyyyDate(date: startDate))")
                                .font(Font.custom("NotoSansCJKkr", size: 16.0))
                                .foregroundColor(Color.colorWFTextBlack)
                                .padding()
                            
                            Spacer()
                            
                            Image("btnCalendarSel")
                                .padding(10)
                        }
                        )
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray)
                        )
                    }
                    
                    HStack {
                        Text("end_date")
                            .font(Font.custom("NotoSansCJKkr", size: 16.0))
                            .foregroundColor(Color.colorWFTextBlack)
                        
                        
                        Button (action: {
                            withAnimation {
                                showEndPicker.toggle()
                            }
                        },  label: {
                            var eDate = ""
                            Text("\(eDate.yyyyDate(date: endDate))")
                                .font(Font.custom("NotoSansCJKkr", size: 16.0))
                                .foregroundColor(Color.colorWFTextBlack)
                                .padding()
                            
                            Spacer()
                            
                            Image("btnCalendarSel")
                                .padding(10)
                        }
                        )
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray)
                        )
                        
                        
//                            .datePickerStyle(GraphicalDatePickerStyle())
                    }
                    
                    Text("trend_report_search_popup_desc").frame(maxWidth: .infinity)
                        .font(Font.custom("NotoSansCJKkr", size: 16.0))
                        .foregroundColor(Color.colorWFRed)
                        .padding(10)
                    
                    
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            //                                    settingVM.unregisterToken()
                            self.showPopup.toggle()
                        }, label: {
                            Text("close")
                                .font(.system(size: 18.0))
                                .foregroundColor(Color.colorWFWhite)
                        }).frame(maxWidth: .infinity)
                            .buttonStyle(.bordered)
                            .controlSize(.large)
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.colorWFGrayBtnNor))
                        
                        
                        Button(action: {
                            //                                    settingVM.unregisterToken()
                            self.showPopup.toggle()
//                            self.triggerNLink.toggle()
                            self.triggerNLink = true
//                            self.nlinkReport()
                        }, label: {
                            Text("trend_report_search_popup_report")
                                .font(.system(size: 18.0))
                                .foregroundColor(Color.colorWFWhite)
                        }).frame(maxWidth: .infinity)
                            .buttonStyle(.bordered)
                            .controlSize(.large)
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.colorWFGreen))
                    }
                    .padding(10)
                }
                    
                .padding(20)
                .background(Color.colorWFWhite)
            }
            .popupNavigationView(horizontalPadding: 40, show: $showStartPicker) {
                VStack {
                    DatePicker("", selection: $startDate, in: ...Date(), displayedComponents: .date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .clipped()
                }
                .onChange(of: startDate) { newValue in
                    withAnimation {
                        showStartPicker.toggle()
                    }
                }
            }
            .popupNavigationView(horizontalPadding: 40, show: $showEndPicker) {
                VStack {
                    DatePicker("", selection: $endDate, in: startDate...Date(), displayedComponents: .date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .clipped()
                }
                .onChange(of: endDate) { newValue in
                    withAnimation {
                        showEndPicker.toggle()
                    }
                }
            }
//                .background(Color.colorBlack20)
//        }
    }
}

struct ReportView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["en", "ko"], id: \.self) { id in
            ReportView()
                    .environment(\.locale, .init(identifier: id))
                    .environmentObject(ReportVM())
            }
    }
}


struct ReportChannelItem: View {
    
    let chName, selected: String
    
    var body: some View {
        ZStack {
            VStack {
                if(self.chName == self.selected) {
                    Text(self.chName)
                        .foregroundColor(Color.colorWFWhite)
                        .font(Font.custom("NotoSansCJKkr-Bold", size: 14))
                        .padding(10)
                        .background(Color.colorWFGreen)
                }
                else {
                    Text(self.chName)
                        .foregroundColor(Color.colorWFGreen)
                        .font(Font.custom("NotoSansCJKkr-Bold", size: 14))
                        .padding(10)
                        .background(
                            RoundedRectangle(cornerRadius: 4, style: .continuous)
                                .stroke(Color.colorWFGreen, lineWidth: 2)
                                .background(Color.colorWFWhite)
                        )
                }
            }
//            .frame(height: 100)
        }
    }
}


struct ReportDeviceItem: View {
    
    let selectedFilter, deviceName: String
    let checked: Bool
//    @State var checked: Bool = false
    
    var body: some View {
        ZStack {
            if(selectedFilter.isEmpty) {
                VStack (spacing:0) {
                    Text(self.deviceName)
                        .foregroundColor(Color.colorWFTextBlack)
                        .font(Font.custom("NotoSansCJKkr-Bold", size: 14))
                        .padding(10)
                        .background(Color.colorWFWhite)
                }
                .frame(alignment: .leading)
                //            .padding(EdgeInsets(top:0, leading: 10, bottom: 0, trailing: 10))
                //            .frame(height: 100)
            }
            else {
                VStack (spacing:0) {
                    if(checked) {
                        HStack {
                            Text(self.deviceName)
                                .foregroundColor(Color.colorWFTextBlack)
                                .font(Font.custom("NotoSansCJKkr-Bold", size: 14))
                                .padding(10)
                                .background(Color.colorWFGrayF0F1F6)
                            
                            Spacer()
                            
                            Image("iconCheckOn")
                                .padding(10)
                        }
                        .background(Color.colorWFGrayF0F1F6)
                    }
                    else {
                        HStack {
                            Text(self.deviceName)
                                .foregroundColor(Color.colorWFTextBlack)
                                .font(Font.custom("NotoSansCJKkr-Bold", size: 14))
                                .padding(10)
                                .background(Color.colorWFWhite)
                            
                            Spacer()
                            
                            Image("iconCheckOff")
                                .padding(10)
                        }
                        .background(Color.colorWFWhite)
                    }
                }
                .frame(alignment: .leading)
            }
        }
    }
    
    
}
