//
//  SitemapCell.swift
//  WimFarm
//
//  Created by ulalalab on 2022/03/10.
//

import SwiftUI

struct SitemapCell: View {
    @StateObject var screenRouter: ScreenRouter = ScreenRouter()

    let assignedPage: Page
    let defIconName, titleName: String

    var body: some View {
        VStack {
            HStack(spacing: 10) {
                Image(defIconName)
                    .frame(width: 48.0, height: 48.0, alignment: .center)
                Text(titleName)
                    .foregroundColor(Color.colorWFTextBlack)
                Spacer()
                Image("btnNextNor")
                    .frame(width: 23.0, height: 38.0, alignment: .center)

            }
            .background(Color.colorWFWhite)
            .onTapGesture {
                screenRouter.currentPage = assignedPage
//                MainTabView().changeCurrentPage(page: assignedPage)
            }
        }
//        .padding(EdgeInsets(top:0, leading: 0, bottom: 1, trailing: 0))
    }
}
