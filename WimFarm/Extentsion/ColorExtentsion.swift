//
//  ColorExtentsion.swift
//  WimFarm
//
//  Created by ulalalab on 2021/11/17.
//

import SwiftUI

extension Color {
    static let colorTransparent = Color(hex: "#00000000")

    static let colorWFWhite = Color(hex: "#FFFFFF")
    static let colorWFGrayECECEC = Color(hex: "#ECECEC")
    static let colorWFGrayBG = Color(hex: "#E9EBF2")
    static let colorWFGrayF0F1F6 = Color(hex: "#F0F1F6")
    static let colorWFGrayTbLight = Color(hex: "#F5F6F9")
    static let colorWFGrayTbDark = Color(hex: "#E0E2EB")
    static let colorWFGraySelOfBox = Color(hex: "#F9F1F6")
    static let colorWFGrayEdgeOfBox = Color(hex: "#B3BDC8")
    static let colorWFGrayDivider = Color(hex: "#ECE6EC")
    static let colorWFGrayBtnNor = Color(hex: "#7C7E8B")
    static let colorWFGrayBtnSel = Color(hex: "#626474")
    static let colorWFRed = Color(hex: "#FC6161")
    static let colorWFOrange = Color(hex: "#FF3900")
    static let colorWFGreen = Color(hex: "#00C9A6")
    static let colorWFGreenSel = Color(hex: "#099C82")
    static let colorWFGreenBG = Color(hex: "#0EC1A2")
    static let colorWFBlue = Color(hex: "#2E90EB")
    static let colorWFTextBlack = Color(hex: "#313D57")
    static let colorWFTextHint = Color(hex: "#B3B5C0")
    static let colorWFTextBlack2 = Color(hex: "#494A59")
    static let colorWFTextEmpty = Color(hex: "#8993A7")
    static let colorWFBGBlackOpacity70 = Color(hex: "#B3000000")

    static let colorWhite = Color(hex: "#ffffff")
    static let colorTextWhite = Color(hex: "#ffffff")
    static let colorBlack = Color(hex: "#000000")

    static let colorBlack20 = Color(hex: "#33000000")
    static let colorBlack60 = Color(hex: "#99000000")
    static let colorBlack70 = Color(hex: "#B3000000")
    static let colorBlack80 = Color(hex: "#CC000000")

    static let colorUlala = Color(hex: "#ff3900")

    static let colorItemBackground = Color(hex: "#1f283a")
    static let colorTextNonSelect = Color(hex: "#717886")

    static let colorRoot = Color(hex: "#182138")
    static let colorRootBackgound = Color(hex: "#060d1e")
    static let colorServerSelect = Color(hex: "#535966")
    static let colorTextBlack = Color(hex: "#060d1e")

    static let colorBorderBoxOutSide = Color(hex: "#353c4b")

    static let colorItemBoxFill = Color(hex: "#161f32")
    static let colorItemBoxText = Color(hex: "#989da8")
    static let colorTextSelect = Color(hex: "#007db8")

    static let colorDangers = Color(hex: "#b70000")
    static let colorWarning = Color(hex: "#ff6e04")
    static let colorCaution = Color(hex: "#ffdc19")
    static let colorLimit = Color(hex: "#d130ff")

    static let colorBottomMenu = Color(hex: "#222C43")

    static let colorNonLine = Color(hex: "#323a50")

    static let colorChartVertical = Color(hex: "#353c4b")

    static let colorOnlyViewColor = Color(hex: "#005C00")

    static let colorDeviceOn = Color(hex: "#00e80b")

    static let colorBoardBackground = Color(hex: "#161f32")
    static let colorDivider = Color(hex: "#353c4b")

    static let colorGraph = [
        Color(hex: "#D50000"),
        Color(hex: "#304FFE"),
        Color(hex: "#6200EA"),
        Color(hex: "#1DE9B6"),
        Color(hex: "#AEEA00"),
        Color(hex: "#F9A825"),
        Color(hex: "#DD2C00"),
        Color(hex: "#795548"),
        Color(hex: "#C51162"),
        Color(hex: "#4A148C"),
        Color(hex: "#2962FF"),
        Color(hex: "#00E5FF"),
        Color(hex: "#AA00FF"),
        Color(hex: "#009688"),
        Color(hex: "#76FF03"),
        Color(hex: "#FF4081"),
        Color(hex: "#00E676"),
        Color(hex: "#2196F3"),
        Color(hex: "#7C4DFF"),
        Color(hex: "#2E7D32"),
        Color(hex: "#FFEA00"),
        Color(hex: "#3F51B5"),
        Color(hex: "#FF5252"),
        Color(hex: "#00B0FF"),
        Color(hex: "#9E9D24")
    ]
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >> 8) & 0xFF) / 255.0
        let b = Double((rgb >> 0) & 0xFF) / 255.0
        
        self.init(red: r, green: g, blue: b)
    }
    
    init(r: Double, g: Double, b: Double, a: Double) {
        self.init(red: r / 255, green: g / 255, blue: b / 255, opacity: a)
    }
}
