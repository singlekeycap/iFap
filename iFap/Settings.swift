//
//  Home.swift
//  iFap
//
//  Created by Dre Dall'Ara on 4/15/23.
//

import SwiftUI

struct Settings: View {
    @AppStorage("showWebViews") var showWebViews: Bool = true
    @AppStorage("showNavBar") var showNavBar: Bool = true
    @AppStorage("showPartyContent") var showPartyContent: Bool = true
    @AppStorage("fapelloChangeType") var fapelloChangeType: String = "Buttons"
    let fapelloTypes = ["Buttons", "Swipes", "Snapchat Style"]
    
    var body: some View {
        List {
            Section(header: Text("Web Services")) {
                Toggle("Show OF, Fansly, PH", isOn: $showWebViews)
                Toggle("Show navigation bar", isOn: $showNavBar)
            }
            Section(header: Text("Fapello")) {
                Text("Fapello Gesture")
                Picker(selection: $fapelloChangeType, label: Text("")) {
                    ForEach(fapelloTypes, id: \.self) { option in
                        Text(option)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            Section(header: Text("Coomer/Kemono")) {
                Toggle("Show post content", isOn: $showPartyContent)
            }
            Section(header: Text("About")) {
                Button(action: {
                    UIApplication.shared.open(URL(string: "https://twitter.com/singlekeycap")!)
                }) {
                    HStack{
                        Image("Twitter")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 30)
                        Text("SingleKeycap")
                            .foregroundColor(Color.white)
                    }
                }
                Button(action: {
                    UIApplication.shared.open(URL(string: "https://github.com/singlekeycap/iFap")!)
                }) {
                    HStack{
                        Image("GitHub")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 30)
                        Text("Source")
                            .foregroundColor(Color.white)
                    }
                }
            }
        }
    }
}
