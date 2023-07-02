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
    @State var messageArray = ["With ❤️ by SingleKeycap", "With 💦 by SingleKeycap", "Better than Cl1max 😉", "https://youtu.be/dQw4w9WgXcQ", "Made in the USA 🦅🇺🇸", "Made in Mexico 🌮🇲🇽"]
    
    var body: some View {
        let randomIndex = Int(arc4random_uniform(UInt32(messageArray.count)))
        ZStack {
            Home(homeTab: $selectedTab, popupVisible: $isPopUpViewVisible, captionMessage: messageArray[randomIndex])
            if isPopUpViewVisible {
                let popUpThreshold: CGFloat = 100
                if selectedTab == 1 {
                    OnlyFans(modelName: modelName)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .offset(y: popUpOffset)
                        .gesture(
                            DragGesture()
                            .onChanged { gesture in
                                if gesture.translation.height > 0 {
                                    popUpOffset = gesture.translation.height
                                }
                            }
                            .onEnded { gesture in
                                if gesture.translation.height > popUpThreshold {
                                    isPopUpViewVisible = false
                                    modelName = ""
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
                                if gesture.translation.height > 0 {
                                    popUpOffset = gesture.translation.height
                                }
                            }
                            .onEnded { gesture in
                                if gesture.translation.height > popUpThreshold {
                                    isPopUpViewVisible = false
                                    modelName = ""
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
                                if gesture.translation.height > 0 {
                                    popUpOffset = gesture.translation.height
                                }
                            }
                            .onEnded { gesture in
                                if gesture.translation.height > popUpThreshold {
                                    isPopUpViewVisible = false
                                    modelName = ""
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
                                if gesture.translation.height > 0 {
                                    popUpOffset = gesture.translation.height
                                }
                            }
                            .onEnded { gesture in
                                if gesture.translation.height > popUpThreshold {
                                    isPopUpViewVisible = false
                                    modelName = ""
                                }
                                popUpOffset = 0
                            }
                        )
                }
                else if selectedTab == 5{
                    CoomerSearch()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .offset(y: popUpOffset)
                        .gesture(
                            DragGesture()
                            .onChanged { gesture in
                                if gesture.translation.height > 0 {
                                    popUpOffset = gesture.translation.height
                                }
                            }
                            .onEnded { gesture in
                                if gesture.translation.height > popUpThreshold {
                                    isPopUpViewVisible = false
                                    modelName = ""
                                }
                                popUpOffset = 0
                            }
                        )
                }
                else if selectedTab == 6{
                    KemonoSearch()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .offset(y: popUpOffset)
                        .gesture(
                            DragGesture()
                            .onChanged { gesture in
                                if gesture.translation.height > 0 {
                                    popUpOffset = gesture.translation.height
                                }
                            }
                            .onEnded { gesture in
                                if gesture.translation.height > popUpThreshold {
                                    isPopUpViewVisible = false
                                    modelName = ""
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
                isPopUpViewVisible = true
            } else if modelURL.hasPrefix("fansly://") {
                modelURL = String(modelURL.dropFirst(9))
                modelName = modelURL
                selectedTab = 2
                isPopUpViewVisible = true
            } else if modelURL.hasPrefix("pornhub://") {
                modelURL = String(modelURL.dropFirst(10))
                modelName = modelURL
                selectedTab = 4
                isPopUpViewVisible = true
            }
        }
        .onAppear {
            let coomerCreators = URL(string: "https://coomer.party/api/creators")!
            let coomerTask = URLSession.shared.dataTask(with: coomerCreators) { (data, response, error) in
                if let error = error {
                    print("Error: \(error)")
                }
                if let coomerData = data {
                    guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
                        print("Unable to access documents directory")
                        return
                    }
                    let fileURL = documentsDirectory.appendingPathComponent("creators.json")
                    do {
                        try coomerData.write(to: fileURL)
                    } catch {
                        print("Error saving JSON document: \(error)")
                    }
                }
            }
            coomerTask.resume()
            let kemonoFurries = URL(string: "https://kemono.party/api/creators")!
            let kemonoTask = URLSession.shared.dataTask(with: kemonoFurries) { (data, response, error) in
                if let error = error {
                    print("Error: \(error)")
                }
                if let kemonoData = data {
                    guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
                        print("Unable to access documents directory")
                        return
                    }
                    let fileURL = documentsDirectory.appendingPathComponent("furries.json")
                    do {
                        try kemonoData.write(to: fileURL)
                    } catch {
                        print("Error saving JSON document: \(error)")
                    }
                }
            }
            kemonoTask.resume()
        }
    }
}
