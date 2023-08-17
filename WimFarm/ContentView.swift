//
//  ContentView.swift
//  WimFarm
//
//  Created by ulalalab on 2021/11/15.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
//        Text("Hello, world!")
//            .padding()
//        let leadingItem = Button(action: { print("Leading") }) {
//            Image(systemName: "bell")
//              .imageScale(.large)
//        }
//        let trailingItem = Button(action: { print("Trailing") }) {
//        Image(systemName: "gear")
//          .imageScale(.large)
//        }
        
        
        return NavigationView {
            VStack {
                HStack(spacing: 30) {
                    Image(systemName: "arrow.up").font(Font.title.weight(.black)).foregroundColor(Color.colorUlala)
                       Image(systemName: "arrow.left").font(Font.title.weight(.semibold))
                       Image(systemName: "arrow.down").font(Font.title.weight(.light))
                       Image(systemName: "arrow.right").font(Font.title.weight(.ultraLight))
                    
                     }
                Image("naviLogo")
        //          .navigationBarItems(leading: leadingItem, trailing: trailingItem)
        //          .navigationBarTitle(titleText)
                  .navigationBarTitleDisplayMode(.inline)
                  .toolbar() {
                      ToolbarItem(placement: .principal) {
                          ZStack {
                              HStack {
                                  Image("naviLogo")
                              }
                              HStack {
                                  Spacer()
                                  Text("WimFarm")
                              }
                          }
                      }
                  }
            }
            
        
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
