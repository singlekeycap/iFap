//
//  Home.swift
//  iFap
//
//  Created by Dre Dall'Ara on 4/15/23.
//

import SwiftUI

struct Home: View {
    @Binding var homeTab: Int
    var body: some View {
        ZStack {
            VStack {
                Text("Welcome to iFap!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Text("With ❤️ by SingleKeycap")
                    .font(.footnote)
                    .padding(.bottom)
                Button(action: {homeTab = 1}) {
                    Text("OnlyFans")
                        .frame(width: 100, height: 40)
                        .foregroundColor(Color.white)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                }
                .padding([.top,.bottom], 5)
                Button(action: {homeTab = 2}) {
                    Text("Fansly")
                        .frame(width: 100, height: 40)
                        .foregroundColor(Color.white)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                }
                .padding([.top,.bottom], 5)
                Button(action: {homeTab = 3}) {
                    Text("Fapello")
                        .frame(width: 100, height: 40)
                        .foregroundColor(Color.white)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                }
                .padding([.top,.bottom], 5)
                Button(action: {homeTab = 4}) {
                    Text("PornHub")
                        .frame(width: 100, height: 40)
                        .foregroundColor(Color.white)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                }
                .padding([.top,.bottom], 5)
            }
            VStack {
                Spacer()
                HStack() {
                    Spacer()
                    Image("GitHub")
                        .resizable(resizingMode: .stretch)
                        .frame(width: 40, height: 40)
                        .overlay(RoundedRectangle(cornerRadius:8)
                            .stroke(Color.accentColor, lineWidth: 3))
                    Spacer()
                        .frame(width: 15)
                    Text("Open sourced on GitHub!")
                    Spacer()
                }
                .onTapGesture {
                    UIApplication.shared.open(URL(string: "https://github.com/singlekeycap/iFap")!)
                }
                .padding(.bottom, 20)
            }
        }
    }
}