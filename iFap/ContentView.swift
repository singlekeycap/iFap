//
//  ContentView.swift
//  iFap
//
//  Created by Dre Dall'Ara on 4/14/23.
//

import SwiftUI

struct ContentView: View {
    @State var selectedTab = 0
    @State var modelName = ""
    @State private var dragAmount: CGPoint? = CGPoint(x: 40, y: 40)
    
    var body: some View {
        GeometryReader { gp in
                ZStack {
                    switch selectedTab {
                    case 1:
                        OnlyFans(modelName: modelName)
                    case 2:
                        Fansly(modelName: modelName)
                    case 3:
                        FapelloSearch()
                    case 4:
                        PornHub(modelName: modelName)
                    default:
                        Home(homeTab: $selectedTab)
                    }
                Button(action: {
                    modelName = ""
                    selectedTab = 0
                }) {
                    Image(systemName: "house.fill")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.accentColor)
                        .clipShape(Circle())
                }
                .animation(.default, value: dragAmount)
                .position(self.dragAmount ?? CGPoint(x: gp.size.width / 2, y: gp.size.height / 2))
                .highPriorityGesture(
                    DragGesture()
                        .onChanged {self.dragAmount = $0.location}
                )
            }
        }
        .onOpenURL {inputURL in
            var modelURL = inputURL.absoluteString
            if modelURL.hasPrefix("onlyfans://") {
                modelURL = String(modelURL.dropFirst(11))
                modelName = modelURL
                selectedTab = 1
            } else if modelURL.hasPrefix("fansly://") {
                modelURL = String(modelURL.dropFirst(9))
                modelName = modelURL
                selectedTab = 2
            } else if modelURL.hasPrefix("pornhub://") {
                modelURL = String(modelURL.dropFirst(10))
                modelName = modelURL
                selectedTab = 4
            }
        }
    }
}
