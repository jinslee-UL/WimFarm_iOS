//
//  ViewExt.swift
//  WimFarm
//
//  Created by ulalalab on 2022/02/14.
//

import UIKit
import Foundation
import SwiftUI
import ZVProgressHUD

class ViewExt {
    
}

extension View {
    func startLoading() {
        ZVProgressHUD.setDisplayStyle(.light)
        ZVProgressHUD.setMaskType(.black)
        ZVProgressHUD.setAnimationType(.flat)
        ZVProgressHUD.show()
    }
    
    func stopLoading() {
        ZVProgressHUD.dismiss()
    }
 
    func showErrorMessage(showAlert: Binding<Bool>, message: String) -> some View {
            self.modifier(ErrorAlertModifier(isPresented: showAlert, message: message))
    }
    
    func popupNavigationView<Content: View>(horizontalPadding: CGFloat = 40, show: Binding<Bool>, @ViewBuilder content: @escaping ()->Content) -> some View {
            return self
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .overlay {
                    if show .wrappedValue {
                        // MARK: Reading container frame
                        GeometryReader { proxy in
                            
                            Color.primary
                                .opacity(0.15)
                                .ignoresSafeArea()
                            
                            let size = proxy.size
                            
                            NavigationView {
                                content()
                            }
                            .frame(width: size.width - horizontalPadding, height: size.height / 1.6, alignment: .center)
                            .cornerRadius(15)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                        }
                    }
                }
        }
    
    func popupNavigationViewHalf<Content: View>(horizontalPadding: CGFloat = 40, show: Binding<Bool>, @ViewBuilder content: @escaping ()->Content) -> some View {
            return self
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .overlay {
                    if show .wrappedValue {
                        // MARK: Reading container frame
                        GeometryReader { proxy in
                            
                            Color.primary
                                .opacity(0.15)
                                .ignoresSafeArea()
                            
                            let size = proxy.size
                            
                            NavigationView {
                                content()
                            }
                            .frame(width: size.width - horizontalPadding, height: size.height / 2.0, alignment: .center)
                            .cornerRadius(15)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                        }
                    }
                }
        }
}

struct ErrorAlertModifier: ViewModifier {
    var isPresented: Binding<Bool>
    let message: String

    func body(content: Content) -> some View {
        content.alert(isPresented: isPresented) {
            Alert(title: Text("error"),
                  message: Text(message),
                  dismissButton: .cancel(Text("OK")))
        }
    }
}

struct TextFieldWPH: View {
    
    var placeholder: Text
    @Binding var text: String
    var editingChanged: (Bool)->() = { _ in }
    var commit: ()->() = { }
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty { placeholder.foregroundColor(Color.colorWFTextHint) }
            TextField("", text: $text, onEditingChanged: editingChanged, onCommit: commit)
        }
    }
    
}

struct SecureFieldWPH: View {
    
    var placeholder: Text
//    @Binding var text: String
    var editingChanged: (Bool)->() = { _ in }
    var commit: ()->() = { }
    @Binding var password : String
    
    var body: some View {
        ZStack(alignment: .leading) {
            if password.isEmpty { placeholder.foregroundColor(Color.colorWFTextHint) }
            SecureField("", text: $password)
        }
    }
    
}

struct BottomTabbar: View{
//    @ObservedObject var screenRouter: ScreenRouter
    @StateObject var screenRouter: ScreenRouter
    
    var body: some View {
        HStack(alignment: .center){
            TabbarOneIcons(screenRouter: screenRouter, assignedPage: .alarm, defIconName: "btnAlram", tabName: "Alarm")
            TabbarOneIcons(screenRouter: screenRouter, assignedPage: .dashboard, defIconName: "btnDashboard", tabName: "Dashboard")
            TabbarOneIcons(screenRouter: screenRouter, assignedPage: .sitemap, defIconName: "btnMypage", tabName: "Sitemap")
        }
        .padding()
        .background(Color.colorWFWhite)
        .frame(width: UIScreen.main.bounds.width, height: 50, alignment: .center)
        .offset(x: 0, y: UIScreen.main.bounds.height/2-25)
    }
}

struct TabbarOneIcons: View{
    @StateObject var screenRouter: ScreenRouter
    
    let assignedPage: Page
    let defIconName, tabName: String
    
    var body: some View{
        
        HStack{
            Spacer()
            VStack{
                if screenRouter.currentPage == assignedPage {
                    Image(defIconName+"On")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                else {
                    Image(defIconName+"Nor")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }
            
            .onTapGesture {
//                withAnimation{
                let _ = print ("assignedPage \(assignedPage)")
                    screenRouter.currentPage = assignedPage
                    
//                }
                
            }
            Spacer()
        }
        
    }
}

struct GroupBoxStyleWhite: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.content
            .frame(maxWidth: .infinity)
            .padding(10)
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.colorWFWhite))
    }
}

struct CustomSegmentedControl: View {
    @Binding var preselectedIndex: Int
    var options: [String]
    let color = Color.colorWFGreen
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(options.indices, id:\.self) { index in
                let isSelected = preselectedIndex == index
                ZStack {
                    Rectangle()
                        .fill(color)
                    
                    Rectangle()
                        .fill(Color.colorWFWhite)
                        .cornerRadius(10)
                        .padding(2)
                        .opacity(isSelected ? 1 : 0.01)
                        .onTapGesture {
                            withAnimation(.interactiveSpring(response: 0.2,
                                                             dampingFraction: 2,
                                                             blendDuration: 0.5)) {
                                preselectedIndex = index
                            }
                        }
                }
                .overlay(
                    Text(options[index])
                        .fontWeight(isSelected ? .bold : .regular)
                        .foregroundColor(isSelected ? .colorWFGreen : .white)
                )
            }
        }
        .frame(height: 40)
        .cornerRadius(10)
    }
}

