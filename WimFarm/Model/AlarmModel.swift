//
//  AlarmModel.swift
//  WimFarm
//
//  Created by ulalalab on 2023/01/31.
//

import Foundation

struct AlarmResponse: Codable  {
    var data: AlarmModel?
    var code: String?
}

struct AlarmModel : Codable {
    var lists: [Alarm]?
    var paginator: [String: Int]?
}

struct Alarm : Codable, Identifiable {
    var id: Int {
        self.notify_idx!
    }
    var company_idx, device_company_idx, device_factory_idx, device_group, device_idx, device_onoff, groups_group, groups_parent_group, notify_confirm, notify_idx, notify_index, notify_level, notify_onoff, notify_time : Int?
    var device_code, device_comment, device_config, device_serial, groups_comment, groups_extend, notify_channel, notify_comment, notify_start_date, notify_update_date, notify_end_date : String?
    
}

struct AlarmPastResponse: Codable  {
    var data: AlarmPastModel?
    var code: String?
}

struct AlarmPastModel: Codable  {
    var msg: String?
    var page: ADPage?
}

struct ADPage: Codable {
    var content: [ADContent]?
    var pageable: ADPageable?
    var totalElements, toalPage, number, size, numberOfElements : Int?
    var last, first, empty : Bool?
}

struct ADContent: Codable, Identifiable {
    var id: Int {
        self.idx!
    }
    var idx, wcIdx, wfIdx, ccnt, wcnt, dcnt, lcnt : Int?
    var wfName, dt, regTime : String?
    var subList: [Sublist]?
}

struct ADPageable: Codable {
    var sort: ADSort?
    var offset, pageSize, pageNumber : Int?
    var paged, unpaged : Bool?
}

struct ADSort: Codable {
    var sorted, unsorted, empty : Bool?
}

struct Sublist: Codable, Identifiable {
    var id:Int {
        self.idx!
    }
    var idx, wnIdx, ccnt, wcnt, dcnt, lcnt: Int?
    var wdCode, wdName, wnChannel, chName: String?
}

//struct Alarm : Codable {
//
//    var notifyIdx : Int?
//
//    var name : String?
//
//    var deviceIdx : Int? // 디바이스 아이디
//    var deviceCode : String?
//    var groupsComment : String?
//    var deviceComment : String?
//    var deviceGroup : Int? // 카테고리 아이디
//
//    var groupsParentGroup : Int? // 설비의 부모 카테고리 아이디
//
//    var notifyStartDate : String?
//    var notifyEndDate : String?
//    var notifyTime : String?
//
//    var notifyChannel : String?
//
//    var notifyOnoff : Int?
//    var notifyLevel : Int?
//
//    var notifyComment : String?
//    var deviceConfig : String?
//
//    var value : Double?
//    //var min : Double?
//    //var max : Double?
//    var level : String?
//
//    var filter : Int?
//
//    var time : String?
//
//    var alarmData: NotifyComment?
//
//    var channels: [Channel]? // Device Config Decode
//    var channelMap: [String: Channel]?
//
//    var isExpanded: Bool?
//}

struct AlarmInput : Codable {
    var key : String?
    var min : String?
    var max : String?
}

struct NotifyComment : Codable {
    var level : String?

//    @SerializedName("val")
    var value: Float?

    var min: Float?

    var max: Float?

    var cnt : Int = 0
}

struct DailyAlarmRes : Codable {
    var page: DailyAlarmData?
    var msg: String?
    var err: String?
}

struct DailyAlarmData : Codable {
    var content : [DailyAlarm]?
    var pageable: DayilyAlarmPageable?
    var totalPage: Int? = 0
    var totalElement: Int? = 0
    var first: Bool? = true
    var last: Bool? = false
    var sort: DayilyAlarmSorted?
    var numberOfElements: Int? = 0
    var size: Int? = 20
    var number: Int? = 0
    var empty: Bool? = false
}

struct DayilyAlarmPageable : Codable {
    var sort: DayilyAlarmSorted?
    var pageNumber: Int? = 0
    var pageSize: Int = 20
    var offset: Int? = 0
    var unpaged: Bool? = false
    var paged: Bool? = true
}

struct DayilyAlarmSorted : Codable {
    var sorted: Bool? = true
    var unsorted: Bool? = false
    var empty: Bool? = false
}

struct DailyAlarm : Codable {
    var idx: Int?
//    @SerializedName("wcIdx")
    var wcIdx: Int?
//    @SerializedName("wfIdx")
    var wfIdx: Int?
//    @SerializedName("wfName")
    var wfName: String?
    var dt: String?
//    @SerializedName("regTime")
    var regTime: String?
//    @SerializedName("subList")
    var subList: [DailyAlarmSubList]?
    var ccnt: Int? = 0
    var wcnt: Int? = 0
    var dcnt: Int? = 0
    var lcnt: Int? = 0

    var isExpanded: Bool? = false
}

struct DailyAlarmSubList : Codable {
    var idx: Int?
//    @SerializedName("wnIdx")
    var wnIdx: Int?
//    @SerializedName("wdCode")
    var wdCode: String?
//    @SerializedName("wdName")
    var wdName: String?
//    @SerializedName("wnChannel")
    var wnChannel: String?
//    @SerializedName("chName")
    var chName: String?
    var ccnt: Int? = 0
    var wcnt: Int? = 0
    var dcnt: Int? = 0
    var lcnt: Int? = 0

    var dt: String?
}
