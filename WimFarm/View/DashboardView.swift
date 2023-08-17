//
//  DashboardView.swift
//  WimFarm
//
//  Created by ulalalab on 2021/11/18.
//

import SwiftUI

struct DashboardView: View {
    @EnvironmentObject private var screenRouter: ScreenRouter
    @EnvironmentObject var loginVM: LoginVM
    @EnvironmentObject private var dashboardVM: DashboardVM
//    @ObservedObject var dashboardVM = DashboardVM()
    
    init() {
//        var token = self.dashboardVM.token
//
//        print("init Token : \(token)")
        
//        UINavigationBar.appearance().backgroundColor = .white
    }
    
    func getLoaded() {
        
//        self.dashboardVM.loaded()
        self.dashboardVM.loaded(lvmToken: loginVM.token)
    }
    
    var columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 10, alignment: .center), count: 2)
    var column: [GridItem] = Array(repeating: .init(.flexible(), spacing: 10, alignment: .center), count: 1)
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.colorWFGrayBG.ignoresSafeArea()
                
                GeometryReader { geo in
                    ScrollView(.vertical) {
                        
//                        MakeWidgetList(widgetList: self.dashboardVM.widgetItemList)
//                        ForEach(dashboardVM.mobileDashWidget.widgetConfig) { widget in
//                        self.dashboardVM.widgetItemList.forEach { widget in
                        ForEach(self.dashboardVM.widgetItemList) { widget in
                            
                            Spacer(minLength: 10)
                            
                            if widget.type!.codingKey.stringValue == "single" {
                                LazyVGrid(columns: column) {
                                    Section(header:
                                                
//                                                NavigationLink(destination: TrendGraphView(widget: widget, item: WidgetItem(), df:widget.select[0].df ?? "&&")) {
                                            NavigationLink(destination: TrendGraphView(widget: widget, item: WidgetItem())) {
//                                                NavigationLink(destination: ChartView(widget: widget, item: WidgetItem())) {
                                        HStack {
                                            
                                            Image("iconDashboardWidgetTit")
                                                .resizable()
                                                .frame(width:10, height:16, alignment: Alignment.center)
                                            
                                            Text("\(widget.title!)")
                                                .font(Font.custom("NotoSansCJKkr-Regular", size: 18))
                                                .foregroundColor(.colorWFTextBlack)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                .background(Color.colorWFWhite)
                                            
                                            //                                            Image("btnNextNor")
                                            //                                                .resizable()
                                            //                                                .frame(width:10, height:16, alignment: Alignment.center)
                                        }
                                        //                                        .alignment(.leading)
                                        .padding(10)
                                        .background(Color.colorWFWhite)
                                    }
                                    ){
//                                        let device = dashboardVM.loadedM.devices.
                                        
//                                        widgetItem(strTitle: "\(widget.name)", strIcon: "\(widget.icon)", strValue: "\(widget.value)", strUnit: "\(widget.unit)")
//                                        NavigationLink(destination: SingleChartView(widget: widget)) {
                                        NavigationLink(destination: TrendGraphView(widget: widget, item: WidgetItem())) {
                                            VStack {
                                                Text("\(widget.name ?? "")")
                                                    .font(Font.custom("NotoSansCJKkr-Regular", size: 14))
                                                    .foregroundColor(Color.colorWFTextBlack)
                                                //                .padding(EdgeInsets(top:10, leading: 20, bottom: 10, trailing: 0))
                                                HStack {
                                                    if widget.state == "on" {
                                                        let imgName = "icon_" + (widget.icon ?? "no_sensor") + "_" + "on"
                                                        
                                                        Image("\(imgName)")
                                                            .resizable()
                                                            .frame(width:40, height:40, alignment: Alignment.center)
                                                        Text("\(widget.value ?? 0, specifier: "%.2f")")
                                                            .font(Font.custom("NotoSansCJKkr-Bold", size: 26))
                                                            .foregroundColor(Color.colorWFTextBlack)
                                                        Text("\(widget.unit ?? "")")
                                                            .font(Font.custom("NotoSansCJKkr-Regular", size: 16))
                                                            .foregroundColor(Color.colorWFTextBlack)
                                                    }
                                                    else {
                                                        let imgName = "icon_" + (widget.icon ?? "no_sensor") + "_" + "off"
                                                        
                                                        Image("\(imgName)")
                                                            .resizable()
                                                            .frame(width:40, height:40, alignment: Alignment.center)
                                                        Text("")
                                                            .font(Font.custom("NotoSansCJKkr-Bold", size: 26))
                                                            .foregroundColor(Color.colorWFTextBlack)
                                                        Text("\(widget.unit ?? "")")
                                                            .font(Font.custom("NotoSansCJKkr-Regular", size: 16))
                                                            .foregroundColor(Color.colorWFTextBlack)
                                                        
                                                    }
                                                }
                                            }
                                            .frame(minWidth: 0, maxWidth: .infinity)
                                            .padding(EdgeInsets(top:15, leading: 10, bottom: 15, trailing: 10))
                                            .background(Color.colorWFWhite)
                                        }
                                    }
                                }
                                .cornerRadius(5)
                                .shadow(color: .gray, radius: 2, x: 1, y: 1)
//                                .padding(EdgeInsets(top:5, leading: 0, bottom: 5, trailing: 0))
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .background(Color.colorWFGrayF0F1F6)
                            }
                            else if widget.type!.codingKey.stringValue == "multi" {
                                LazyVGrid(columns: columns) {
                                    Section(header:
//                                                Text("\(widget.title!)")
////                                                    .font(.title)
//                                                    .font(Font.custom("NotoSansCJKkr-Regular", size: 18))
//                                                    .foregroundColor(.colorWFTextBlack)
//                                                    .frame(maxWidth: .infinity, minHeight: 50)
//                                                    .background(Color.colorWFWhite)
                                            
                                            NavigationLink(destination: TrendGraphView(widget: widget, item: WidgetItem())) {
//                                            NavigationLink(destination: ChartView(widget: widget, item: WidgetItem())) {
                                        HStack {
                                            
                                            Image("iconDashboardWidgetTit")
                                                .resizable()
                                                .frame(width:10, height:16, alignment: Alignment.center)
                                            
                                            Text("\(widget.title!)")
                                                .font(Font.custom("NotoSansCJKkr-Regular", size: 18))
                                                .foregroundColor(.colorWFTextBlack)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                            
                                            //                                            Image("btnNextNor")
                                            //                                                .resizable()
                                            //                                                .frame(width:10, height:16, alignment: Alignment.center)
                                        }
                                        //                                        .alignment(.leading)
                                        .padding(10)
                                        .background(Color.colorWFWhite)
                                    }

                                    ){
//                                        widget.select?.forEach { item in
//
//                                            widgetItem(strTitle: "\(item.name)", strIcon: "\(item.icon)", strValue: "\(item.value)", strUnit: "\(item.unit)")
//                                        }
                                        ForEach(widget.select ?? [WidgetItem]()) { item in
                                            
//                                            NavigationLink(destination: SingleChartView(widget: widget)) {
//                                            NavigationLink(destination: SingleChartView(widget: widget, item: item)) {
                                            NavigationLink(destination: TrendGraphView(widget: widget, item: item)) {
                                                VStack {
                                                    let _ = print("dfdfdf = \(item.df ?? "nil")")
                                                    Text("\(item.name ?? "")")
                                                        .font(Font.custom("NotoSansCJKkr-Regular", size: 14))
                                                        .foregroundColor(Color.colorWFTextBlack)
                                                    //                .padding(EdgeInsets(top:10, leading: 20, bottom: 10, trailing: 0))
                                                    HStack {
                                                        if(item.state == "on") {
                                                            let imgName = "icon_" + (item.icon ?? "no_sensor") + "_" + "on"
                                                            //                                                    if item.icon!.count == 0 {
                                                            //                                                        imgName = "icon_no_sensor_on"
                                                            //                                                    }
                                                            Image("\(imgName)")
                                                                .resizable()
                                                                .frame(width:40, height:40, alignment: Alignment.center)
                                                            Text("\(item.value ?? 0, specifier: "%.2f")")
                                                                .font(Font.custom("NotoSansCJKkr-Bold", size: 26))
                                                                .foregroundColor(Color.colorWFTextBlack)
                                                            Text("\(item.unit ?? "")")
                                                                .font(Font.custom("NotoSansCJKkr-Regular", size: 16))
                                                                .foregroundColor(Color.colorWFTextBlack)
                                                        }
                                                        else {
                                                            let imgName = "icon_" + (item.icon ?? "no_sensor") + "_" + "off"
                                                            //                                                    if item.icon!.count == 0 {
                                                            //                                                        imgName = "icon_no_sensor_on"
                                                            //                                                    }
                                                            Image("\(imgName)")
                                                                .resizable()
                                                                .frame(width:40, height:40, alignment: Alignment.center)
                                                            Text("")
                                                                .font(Font.custom("NotoSansCJKkr-Bold", size: 26))
                                                                .foregroundColor(Color.colorWFTextBlack)
                                                            Text("\(item.unit ?? "")")
                                                                .font(Font.custom("NotoSansCJKkr-Regular", size: 16))
                                                                .foregroundColor(Color.colorWFTextBlack)
                                                        }
                                                    }
                                                }
                                                .frame(minWidth: 0, maxWidth: .infinity)
                                                //                                            .frame(width: 140.0,  height: 100.0, alignment:.center)
                                                .padding(EdgeInsets(top:15, leading: 10, bottom: 15, trailing: 10))
                                                .background(Color.colorWFWhite)
                                            }
                                        }
                                    }
                                }
                                .cornerRadius(5)
                                .shadow(color: .gray, radius: 2, x: 1, y: 1)
//                                .padding(EdgeInsets(top:15, leading: 0, bottom: 15, trailing: 0))
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .background(Color.colorWFGrayF0F1F6)
                            }
                            Spacer(minLength: 10)
                        }
                        
//                        VStack {
//                            ForEach(self.dashboardVM.widgetItemList) { wItem in
//                                    if wItem.type!.codingKey.stringValue == "single" {
//                                        GroupBox(label: Label(wItem.title!, image: "iconDashboardWidgetTit").background(Color.colorWFWhite)) {
//                                            VStack {
//                                                Text("\(wItem.name ?? "")")
//                                                    .font(Font.custom("NotoSansCJKkr-Regular", size: 14))
//                                                    .foregroundColor(Color.colorWFTextBlack)
//                                                //                .padding(EdgeInsets(top:10, leading: 20, bottom: 10, trailing: 0))
//                                                HStack {
//                                                    let imgName = "icon_" + (wItem.icon ?? "no_sensor") + "_" + "on"
//                                                    Image("\(imgName)")
//                                                        .resizable()
//                                                        .frame(width:40, height:40, alignment: Alignment.center)
//                                                        .background(Color.colorWFOrange)
//                                                    Text("\(wItem.value ?? 0)")
//                                                        .font(Font.custom("NotoSansCJKkr-Bold", size: 26))
//                                                        .foregroundColor(Color.colorWFTextBlack)
//                                                        .background(Color.colorWFGrayECECEC)
//                                                    Text("\(wItem.unit ?? "")")
//                                                        .font(Font.custom("NotoSansCJKkr-Regular", size: 16))
//                                                        .foregroundColor(Color.colorWFTextBlack)
//                                                        .background(Color.colorWFBlue)
//                                                }
//                                            }
//                                            .background(Color.colorWFGrayBG)
//                                            .padding(0)
//                                        }
//                                        .frame(minHeight: geo.size.height)
//                                        .groupBoxStyle(WidgetGroupBoxStyle())
//                                        .padding(0)
//                                        .cornerRadius(10)
//                                    }
//                                    else {
//                                        GroupBox(label: Label(wItem.title!, image: "iconDashboardWidgetTit").background(Color.colorWFWhite)) {
//                                            VStack {
//                                                var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
//
//                                                LazyVGrid(columns: columns) {
//
//                                                    ForEach(wItem.select ?? [WidgetItem]()) { item in
//                                                        Text("\(item.name ?? "")")
//                                                            .font(Font.custom("NotoSansCJKkr-Regular", size: 14))
//                                                            .foregroundColor(Color.colorWFTextBlack)
//                                                        //                .padding(EdgeInsets(top:10, leading: 20, bottom: 10, trailing: 0))
//                                                        HStack {
//                                                            let imgName = "icon_" + (item.icon ?? "no_sensor") + "_" + "on"
//                                                            Image("\(imgName)")
//                                                                .resizable()
//                                                                .frame(width:40, height:40, alignment: Alignment.center)
//                                                                .background(Color.colorWFOrange)
//                                                            Text("\(item.value ?? 0)")
//                                                                .font(Font.custom("NotoSansCJKkr-Bold", size: 26))
//                                                                .foregroundColor(Color.colorWFTextBlack)
//                                                                .background(Color.colorWFGrayECECEC)
//                                                            Text("\(item.unit ?? "")")
//                                                                .font(Font.custom("NotoSansCJKkr-Regular", size: 16))
//                                                                .foregroundColor(Color.colorWFTextBlack)
//                                                                .background(Color.colorWFBlue)
//                                                        }
//                                                    }
//                                                    .cornerRadius(10)
//                                                }
//                                            }
//                                            .background(Color.colorWFGrayBG)
//                                            .padding(0)
//                                        }
//                                        .frame(minHeight: geo.size.height)
//                                        .groupBoxStyle(WidgetGroupBoxStyle())
//                                        .padding(0)
//                                        .cornerRadius(10)
//                                    }
//                            }
//                        }
//                        .padding(EdgeInsets(top:10, leading: 0, bottom: 20, trailing: 0))
                        
//                        LazyVGrid(columns: columns) {
//                            Section(header:
//                                                    Text("첫 번째 섹션")
//                                                    .font(.title)
//                                                    .foregroundColor(.colorWFTextBlack)
//                                                    .frame(maxWidth: .infinity)
//                                                    .background(Color.colorWFWhite)
//
//                            ){
//                                ForEach((0...14), id: \.self) { _ in
//                                    widgetItem(strTitle: "가나다라마바사아자차카타파하", strIcon: "temperature", strValue: "100", strUnit: "도")
//                                }
//                            }
//                            .cornerRadius(10)
//                        }
//                        .background(Color.colorWFGrayECECEC)
//                        .aspectRatio(contentMode: .fit)
                        
                        
//                        VStack {
//                            widgetItem(strTitle: "가나다라마바사아자차카타파하", strIcon: "temperature", strValue: "100", strUnit: "도")
//                                .border(Color.colorWFGrayDivider, width: 3)
//                            widgetItem(strTitle: "가나다라마바사아자차카타파하", strIcon: "battery", strValue: "100", strUnit: "도")
//                            widgetItem(strTitle: "가나다라마바사아자차카타파하", strIcon: "co2", strValue: "100", strUnit: "도")
//                                .border(Color.colorWFGrayDivider, width: 2)
//                            widgetItem(strTitle: "가나다라마바사아자차카타파하", strIcon: "dewpoint", strValue: "100", strUnit: "도")
//                            widgetItem(strTitle: "가나다라마바사아자차카타파하", strIcon: "humidity", strValue: "100", strUnit: "도")
//                                .border(Color.colorWFGrayDivider, width: 1)
//
//                            GroupBox(label: Label("테스트 그룹명", image: "iconDashboardWidgetTit").background(Color.colorWFWhite)) {
//                                VStack {
//                                    HStack {
//                                        widgetItem(strTitle: "가나다라마바사아자차카타파하", strIcon: "temperature", strValue: "100", strUnit: "도")
//                                            .border(Color.colorWFBlue, width: 2)
//                                        widgetItem(strTitle: "가나다라마바사아자차카타파하", strIcon: "battery", strValue: "100", strUnit: "도")
//                                            .border(Color.colorWFOrange, width: 4)
//                                    }
//                                    .padding(0)
//                                    HStack {
//                                        widgetItem(strTitle: "가나다라마바사아자차카타파하", strIcon: "temperature", strValue: "100", strUnit: "도")
//                                            .border(Color.colorWFRed, width: 2)
//                                        widgetItem(strTitle: "가나다라마바사아자차카타파하", strIcon: "battery", strValue: "100", strUnit: "도")
//                                            .border(Color.colorWFGrayDivider, width: 2)
//                                    }
//                                    .padding(0)
//                                    .border(Color.colorWFGrayDivider, width: 1)
//                                    widgetItem(strTitle: "가나다라마바사아자차카타파하", strIcon: "co2", strValue: "100", strUnit: "도")
//                                    widgetItem(strTitle: "가나다라마바사아자차카타파하", strIcon: "dewpoint", strValue: "100", strUnit: "도")
//                                    widgetItem(strTitle: "가나다라마바사아자차카타파하", strIcon: "humidity", strValue: "100", strUnit: "도")
//                                }
//                                .background(Color.colorWFGrayBG)
//                                .padding(0)
//                            }
//                            .frame(minHeight: geo.size.height)
//                            .groupBoxStyle(WidgetGroupBoxStyle())
//                            .padding(0)
//                            .cornerRadius(10)
//                        }
//                        .padding(EdgeInsets(top:10, leading: 0, bottom: 20, trailing: 0))
                    }
                    .padding(EdgeInsets(top:70, leading: 10, bottom: 50, trailing: 10))
                }
            }
            .onAppear(perform: getLoaded)
            .navigationBarHidden(false)
//            .navigationTitle(Text("Wimfarm"))
//            .foregroundColor(Color.colorUlala)
            .navigationBarBackButtonHidden(true)
            .edgesIgnoringSafeArea(.top)
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarTitleDisplayMode(.inline)
            .toolbar() {
                ToolbarItem(placement: .principal) {
//                    Image("naviLogo")
//                    .resizable()
//                    .frame(width: 94.0, height: 16.0, alignment: .center)
                    Image("naviLogoWell")
                        .frame(width: 94.0, height: 17.5, alignment: .center)
                }
                //날씨
                ToolbarItem(placement: .navigationBarTrailing) {
                    Text("weather")
                        .foregroundColor(Color.colorWFTextBlack)
                        .onTapGesture {
                            screenRouter.exPage = screenRouter.currentPage
                            screenRouter.currentPage = .weather
//                            let cLat = self.dashboardVM.loadedM.companys!.company_lat ?? "30.3723260"
//                            let cLon = self.dashboardVM.loadedM.companys!.company_lon ?? "-95.137526"
                        }
                }
            }
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["en", "ko"], id: \.self) { id in
                        DashboardView()
                        .environment(\.locale, .init(identifier: id))
                        .environmentObject(DashboardVM())
                }
    }
}

struct widgetItem: View {
    
    let strTitle, strIcon, strValue, strUnit: String
    
    var body: some View {
        VStack {
            Text(strTitle)
                .font(Font.custom("NotoSansCJKkr-Regular", size: 14))
                .foregroundColor(Color.colorWFTextBlack)
//                .padding(EdgeInsets(top:10, leading: 20, bottom: 10, trailing: 0))
            HStack {
                let imgName = "icon_" + strIcon + "_" + "on"
                Image("\(imgName)")
                    .resizable()
                    .frame(width:40, height:40, alignment: Alignment.center)
                    .background(Color.colorWFOrange)
                Text(strValue)
                    .font(Font.custom("NotoSansCJKkr-Bold", size: 26))
                    .foregroundColor(Color.colorWFTextBlack)
                    .background(Color.colorWFGrayECECEC)
                Text(strUnit)
                    .font(Font.custom("NotoSansCJKkr-Regular", size: 16))
                    .foregroundColor(Color.colorWFTextBlack)
                    .background(Color.colorWFBlue)
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding(EdgeInsets(top:10, leading: 20, bottom: 20, trailing: 10))
        .background(Color.colorWFWhite)
    }
}

struct WidgetGroupBoxStyle: GroupBoxStyle {
    var background: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color.colorWFGrayF0F1F6)
            .border(Color.colorWFGrayEdgeOfBox, width: 2)
    }

    func makeBody(configuration: Configuration) -> some View {
        GeometryReader { geo in
            configuration.content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(EdgeInsets(top:40, leading: 10, bottom: 10, trailing: 10))
                .background(background)
                .overlay(
                    configuration.label
                        .padding(.leading, 10)
                        .foregroundColor(Color.colorWFTextBlack)
                        .background(Color.colorWhite)
                        .frame(width: geo.size.width, height: 40),
                    alignment: .topLeading
                )
        }
    }
}

private func drawWidget(wItem: WidgetList) -> some View {
//    var body: some View {
    
    GeometryReader { geo in
        VStack {
            if wItem.type!.codingKey.stringValue == "single" {
                GroupBox(label: Label(wItem.title!, image: "iconDashboardWidgetTit").background(Color.colorWFWhite)) {
                    VStack {
                        Text("\(wItem.name ?? "")")
                            .font(Font.custom("NotoSansCJKkr-Regular", size: 14))
                            .foregroundColor(Color.colorWFTextBlack)
                        //                .padding(EdgeInsets(top:10, leading: 20, bottom: 10, trailing: 0))
                        HStack {
                            let imgName = "icon_" + (wItem.icon ?? "no_sensor") + "_" + "on"
                            Image("\(imgName)")
                                .resizable()
                                .frame(width:40, height:40, alignment: Alignment.center)
                                .background(Color.colorWFOrange)
                            Text("\(wItem.value ?? 0)")
                                .font(Font.custom("NotoSansCJKkr-Bold", size: 26))
                                .foregroundColor(Color.colorWFTextBlack)
                                .background(Color.colorWFGrayECECEC)
                            Text("\(wItem.unit ?? "")")
                                .font(Font.custom("NotoSansCJKkr-Regular", size: 16))
                                .foregroundColor(Color.colorWFTextBlack)
                                .background(Color.colorWFBlue)
                        }
                    }
                    .background(Color.colorWFGrayBG)
                    .padding(0)
                }
                .frame(minHeight: geo.size.height)
                .groupBoxStyle(WidgetGroupBoxStyle())
                .padding(0)
                .cornerRadius(10)
            }
            else {
                GroupBox(label: Label(wItem.title!, image: "iconDashboardWidgetTit").background(Color.colorWFWhite)) {
                    VStack {
                        var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
                        
                        LazyVGrid(columns: columns) {
                            
                            ForEach(wItem.select ?? [WidgetItem]()) { item in
                                Text("\(item.name ?? "")")
                                    .font(Font.custom("NotoSansCJKkr-Regular", size: 14))
                                    .foregroundColor(Color.colorWFTextBlack)
                                //                .padding(EdgeInsets(top:10, leading: 20, bottom: 10, trailing: 0))
                                HStack {
                                    let imgName = "icon_" + (item.icon ?? "no_sensor") + "_" + "on"
                                    Image("\(imgName)")
                                        .resizable()
                                        .frame(width:40, height:40, alignment: Alignment.center)
                                        .background(Color.colorWFOrange)
                                    Text("\(item.value ?? 0)")
                                        .font(Font.custom("NotoSansCJKkr-Bold", size: 26))
                                        .foregroundColor(Color.colorWFTextBlack)
                                        .background(Color.colorWFGrayECECEC)
                                    Text("\(item.unit ?? "")")
                                        .font(Font.custom("NotoSansCJKkr-Regular", size: 16))
                                        .foregroundColor(Color.colorWFTextBlack)
                                        .background(Color.colorWFBlue)
                                }
                            }
                            .cornerRadius(10)
                        }
                    }
                    .background(Color.colorWFGrayBG)
                    .padding(0)
                }
                .frame(minHeight: geo.size.height)
                .groupBoxStyle(WidgetGroupBoxStyle())
                .padding(0)
                .cornerRadius(10)
            }
        }
        .padding(EdgeInsets(top:10, leading: 0, bottom: 20, trailing: 0))
    }
//    }
}

//struct DrawWidgetItem {
//    let widgetItem: WidgetList
//
//    var body: some View {
//        VStack {
//            var column: [GridItem] = Array(repeating: .init(.flexible()), count: 1)
//
//            if widgetItem.type == "single" {
//                LazyVGrid(columns: column) {
//                    Section(header:
//                                Text(widgetItem.title!)
//                        .font(.title)
//                        .foregroundColor(.colorWFTextBlack)
//                        .frame(maxWidth: .infinity)
//                        .background(Color.colorWFWhite)
//
//                    ){
//                        //                                        let device = dashboardVM.loadedM.devices.
//                        widgetItem(strTitle: widgetItem.name ?? "", strIcon: widgetItem.icon ?? "", strValue: widgetItem.value ?? 0, strUnit: widgetItem.unit ?? "")
//                    }
//                    .cornerRadius(10)
//                }
//            }
//            else {
//                var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 1)
//
//                LazyVGrid(columns: columns) {
//                    Section(header:
//                                Text(widgetItem.title!)
//                        .font(.title)
//                        .foregroundColor(.colorWFTextBlack)
//                        .frame(maxWidth: .infinity)
//                        .background(Color.colorWFWhite)
//
//                    ){
//                        widgetItem.select?.forEach { item in
//
//                            widgetItem(strTitle: item.name ?? "", strIcon: item.icon ?? "", strValue: item.value ?? 0, strUnit: item.unit ?? "")
//                        }
//                    }
//                    .cornerRadius(10)
//                }
//            }
//        }
//    }
//}


//struct MakeWidgetList {
//    let widgetList: [WidgetList]
//
//    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
//    var column: [GridItem] = Array(repeating: .init(.flexible()), count: 1)
//
//    var body: some View {
//        VStack {
//
////            ForEach(dashboardVM.mobileDashWidget.widgetConfig) { widget in
//            widgetList.forEach { widget in
//                if widget.type == "single" {
//                    LazyVGrid(columns: column) {
//                        Section(header:
//                                    Text(widget.title)
//                            .font(.title)
//                            .foregroundColor(.colorWFTextBlack)
//                            .frame(maxWidth: .infinity)
//                            .background(Color.colorWFWhite)
//
//                        ){
//                            //                                        let device = dashboardVM.loadedM.devices.
//                            widgetItem(strTitle: widget.name, strIcon: widget.icon, strValue: widget.value, strUnit: widget.unit)
//                        }
//                        .cornerRadius(10)
//                    }
//                }
//                else if widget.type == "multi" {
//                    LazyVGrid(columns: columns) {
//                        Section(header:
//                                    Text(widget.title)
//                            .font(.title)
//                            .foregroundColor(.colorWFTextBlack)
//                            .frame(maxWidth: .infinity)
//                            .background(Color.colorWFWhite)
//
//                        ){
//                            widget.select?.forEach { item in
//
//                                widgetItem(strTitle: item.name, strIcon: item.icon, strValue: item.value, strUnit: item.unit)
//                            }
//                        }
//                        .cornerRadius(10)
//                    }
//                }
//            }
//        }
//    }
//}

//private extension DashboardView {
//    var widget: some View {
//    }
//}
