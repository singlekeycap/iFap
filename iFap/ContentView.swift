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
    @State var isPopUpViewVisible = false
    @State var popUpOffset: CGFloat = 0
    
    var body: some View {
        ZStack {
            Home(homeTab: $selectedTab, popupVisible: $isPopUpViewVisible)
            if isPopUpViewVisible {
                let popUpThreshold: CGFloat = 100
                if selectedTab == 1 {
                    OnlyFans(modelName: modelName)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .offset(y: popUpOffset)
                        .gesture(
                            DragGesture()
                            .onChanged { gesture in
                                popUpOffset = gesture.translation.height
                            }
                            .onEnded { gesture in
                                if gesture.translation.height > popUpThreshold {
                                    isPopUpViewVisible = false
                                }
                                popUpOffset = 0
                            }
                        )
                } else if selectedTab == 2 {
                    Fansly(modelName: modelName)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .offset(y: popUpOffset)
                        .gesture(
                            DragGesture()
                            .onChanged { gesture in
                                popUpOffset = gesture.translation.height
                            }
                            .onEnded { gesture in
                                if gesture.translation.height > popUpThreshold {
                                    isPopUpViewVisible = false
                                }
                                popUpOffset = 0
                            }
                        )
                } else if selectedTab == 3 {
                    FapelloSearch()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .offset(y: popUpOffset)
                        .gesture(
                            DragGesture()
                            .onChanged { gesture in
                                popUpOffset = gesture.translation.height
                            }
                            .onEnded { gesture in
                                if gesture.translation.height > popUpThreshold {
                                    isPopUpViewVisible = false
                                }
                                popUpOffset = 0
                            }
                        )
                } else if selectedTab == 4{
                    PornHub(modelName: modelName)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .offset(y: popUpOffset)
                        .gesture(
                            DragGesture()
                            .onChanged { gesture in
                                popUpOffset = gesture.translation.height
                            }
                            .onEnded { gesture in
                                if gesture.translation.height > popUpThreshold {
                                    isPopUpViewVisible = false
                                }
                                popUpOffset = 0
                            }
                        )
                }
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
