//
//  DashWidgetModel.swift
//  WimFarm
//
//  Created by ulalalab on 2023/02/22.
//

import Foundation

struct DashWidgetResponse : Codable {
    var data: DashWidgetLists?
    var code: String?
}

struct DashWidgetLists : Codable {
    var lists: [DashWidget]?
    var paginator: Pagenator?
}

struct Pagenator : Codable {
    var blocks, lastNum, lastPage, limit, nextPage, nowBlock, offset, page, prevPage, startNum, startPage, totalBlock, totalPage, totalRow :  Int?
}

struct DashWidget : Codable {
    var widget_name, widget_comment, widget_configs: String?
    var widget_company_idx, widget_idx, widget_type, widget_user_idx, widget_sort: Int?
    var widgetConfig: [DashWidgetConfig]?
}

struct DashWidgetConfig: Codable {
    var id: String?
    var width, height, x, y: Int?
    var data: DashWidgetData?
}

struct DashWidgetData: Codable {
    var title, device_code, channel: String?
    var select: [Select]?
}

struct Select: Codable {
    var device_code, channel: String?
    var group, category: Int?
}

struct WidgetList: Codable, Identifiable {
    var id: String {
        self.title!
    }
    
    var title, name, icon, unit, type, channel, state: String?
    var value: Float?
    var device: Device?
    var filter: Filter?
    var select: [WidgetItem]?
}

struct WidgetItem: Codable, Identifiable {
    var id: String {
        self.df!
    }
    
    var title, name, icon, unit, channel, df, state: String?
    var value: Float?
    var device: Device?
    var filter: Filter?
}

//struct DashWidgetData : Codable {
//    var lists: [WidgetList]?
//    var paginator: [String : Int]?
//
//    var listsMap: [Int : WidgetList]?
//}
//
//struct WidgetList : Codable {
//    var widgetIdx : Int?
//    var widgetCompanyIdx : Int?
//    var widgetUserIdx : Int?
//    var widgetName : String?
//    var widgetComment : String?
//    var widgetHtml : String?
//    var widgetConfigs : String?
//    var widgetRepresentative : Int?
//    var widgetType : Int?
//    var widgetShare : Int?
//    var widgetSort : Int?
//    var widgetDeleteDate : String?
//    var widgetUpdateDate : String?
//    var widgetCreateDate : String?
//
//    var widgetItemList : [DashWidgetItem]?
//    var widgetItemListMap: [Int : DashWidgetItem]?
//
//    var channels: [Channel]? // Device Config Decode
//    var channelMap: [String : Channel]?
//}
//
//struct WidgetConfigsVo : Codable {
//    var id : String?
//    var width : Int?
//    var height : Int?
//    var x : Int?
//    var y : Int?
//
////    var anyConfigsVo: Any?
//    var data: WidgetData?
//}
//
//struct WidgetData : Codable {
//    var channel : String?
////    @SerializedName("device_code")
//    var deviceCode : String?
//    var title : String?
//    var group : Int?
//    var select: [WidgetDataMulti]?
////    var select: Map<String?, MutableList<WidgetDataMulti>?>?
//}
//
//struct WidgetDataMulti : Codable {
//    var channel : String?
////    @SerializedName("device_code")
//    var deviceCode : String?
//}
//
//struct DashWidgetItem : Codable {
//    var widgetTitle : String?
//    var channelName : String?
//    var widgetType : String?
//    var channelIcon : String?
//    var channelValue : String?
//    var channelUnit : String?
//    var onoff : Int? = 0
//
//    var channels : [DashWidgetItem]?
//
//    var alarmInputMap : [String : AlarmInput]?
//
//    var deviceCode : String?
//    var channel : String?
//    var sensorIdx : Int?
//}
