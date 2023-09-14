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
    @State var messageArray = ["With ❤️ by SingleKeycap", "With 💦 by SingleKeycap", "Better than Cl1max 😉", "Click here 🥴", "Made in the USA 🦅🇺🇸", "Made in Mexico 🌮🇲🇽"]
    @State var coomerDisabled = true
    @State var kemonoDisabled = true
    
    var body: some View {
        let randomIndex = Int(arc4random_uniform(UInt32(messageArray.count)))
        ZStack {
            Home(homeTab: $selectedTab, popupVisible: $isPopUpViewVisible, captionMessage: messageArray[randomIndex], coomerDisabled: $coomerDisabled, kemonoDisabled: $kemonoDisabled)
            if isPopUpViewVisible {
                VStack {
                    let popUpThreshold: CGFloat = 100
                    ZStack {
                        Rectangle()
                            .frame(width: .infinity, height: 35)
                            .foregroundColor(.black)
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.gray)
                            .frame(width: 40, height: 5)
                    }
                    .padding(.vertical, -10)
                    .gesture(
                        DragGesture(minimumDistance: 1.0, coordinateSpace: .global)
                            .onChanged { gesture in
                                popUpOffset = gesture.translation.height
                            }
                            .onEnded { gesture in
                                if gesture.translation.height > popUpThreshold {
                                    isPopUpViewVisible = false
                                    modelName = ""
                                }
                                popUpOffset = 0
                            }
                    )
                    if selectedTab == 1 {
                        WebView(url: "https://onlyfans.com/\(modelName)")
                    } else if selectedTab == 2 {
                        WebView(url: "https://fansly.com/\(modelName)")
                    } else if selectedTab == 3 {
                        WebView(url: "https://www.pornhub.com/\(modelName)")
                    } else if selectedTab == 4 {
                        FapelloSearch()
                    } else if selectedTab == 5 {
                        CoomerSearch()
                    } else if selectedTab == 6 {
                        KemonoSearch()
                    }
                }
                .offset(y: popUpOffset)
                .animation(popUpOffset > 0 ? .linear : nil)
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
                modelName = "view_video.php?viewkey=" + modelURL
                selectedTab = 4
                isPopUpViewVisible = true
            }
        }
        .onAppear {
            if UserDefaults.standard.object(forKey: "showWebViews") == nil {
                UserDefaults.standard.set(true, forKey: "showWebViews")
            }
            if UserDefaults.standard.object(forKey: "showNavBar") == nil {
                UserDefaults.standard.set(true, forKey: "showNavBar")
            }
            if UserDefaults.standard.object(forKey: "showPartyContent") == nil {
                UserDefaults.standard.set(true, forKey: "showPartyContent")
            }
            if  UserDefaults.standard.object(forKey: "fapelloChangeType") == nil {
                UserDefaults.standard.set("Buttons", forKey: "fapelloChangeType")
            }
            let coomerCreators = URL(string: "https://coomer.party/api/creators")!
            let coomerTask = URLSession.shared.dataTask(with: coomerCreators) { (data, response, error) in
                if let coomerData = data {
                    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                    let fileURL = documentsDirectory.appendingPathComponent("creators.json")
                    do {
                        try coomerData.write(to: fileURL)
                        coomerDisabled = false
                    } catch {
                        print("Error saving JSON document: \(error)")
                    }
                }
            }
            coomerTask.resume()
            let kemonoFurries = URL(string: "https://kemono.party/api/creators")!
            let kemonoTask = URLSession.shared.dataTask(with: kemonoFurries) { (data, response, error) in
                if let kemonoData = data {
                    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                    let fileURL = documentsDirectory.appendingPathComponent("furries.json")
                    do {
                        try kemonoData.write(to: fileURL)
                        kemonoDisabled = false
                    } catch {
                        print("Error saving JSON document: \(error)")
                    }
                }
            }
            kemonoTask.resume()
        }
    }
}
