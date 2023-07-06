//
//  Home.swift
//  iFap
//
//  Created by Dre Dall'Ara on 7/3/23.
//

import SwiftUI

struct Home: View {
    @Binding var homeTab: Int
    @Binding var popupVisible: Bool
    @State var captionMessage: String
    @Binding var coomerDisabled: Bool
    @Binding var kemonoDisabled: Bool
    @State var showWebViews = true
    
    var body: some View {
        NavigationView {
            VStack (alignment: .leading) {
                HStack {
                    Text("iFap")
                        .font(.system(size: 60).weight(.bold))
                        .padding(.horizontal, 30)
                        .padding(.bottom, 2)
                    Spacer()
                }
                .frame(width: UIScreen.main.bounds.width)
                Link(destination: URL(string: "https://youtu.be/dQw4w9WgXcQ")!) { // If you see this line, shhh...
                    Text(captionMessage)
                        .font(.callout.weight(.bold))
                        .foregroundColor(Color.gray)
                        .padding(.horizontal, 30)
                }
                Spacer()
                VStack {
                    if showWebViews {
                        HStack {
                            Button(action: {
                                homeTab = 1
                                popupVisible = true
                            }) {
                                ZStack {
                                    Image("OF")
                                        .resizable()
                                        .scaledToFill()
                                        .blur(radius:3, opaque:true)
                                    Text("OnlyFans")
                                        .font(.title3)
                                        .foregroundColor(Color.white)
                                        .shadow(color: Color.black.opacity(0.9), radius: 4, x: 0, y: 0)
                                        .shadow(color: Color.black.opacity(0.9), radius: 4, x: 0, y: 0)
                                }
                                .frame(width: 7*UIScreen.main.bounds.width/24, height: 7*UIScreen.main.bounds.width/24)
                                .cornerRadius(10)
                            }
                            Button(action: {
                                homeTab = 2
                                popupVisible = true
                            }) {
                                ZStack {
                                    Image("Fansly")
                                        .resizable()
                                        .scaledToFill()
                                        .blur(radius:3, opaque:true)
                                    Text("Fansly")
                                        .font(.title3)
                                        .foregroundColor(Color.white)
                                        .shadow(color: Color.black.opacity(0.9), radius: 4, x: 0, y: 0)
                                        .shadow(color: Color.black.opacity(0.9), radius: 4, x: 0, y: 0)
                                }
                                .frame(width: 7*UIScreen.main.bounds.width/24, height: 7*UIScreen.main.bounds.width/24)
                                .cornerRadius(10)
                            }
                            Button(action: {
                                homeTab = 3
                                popupVisible = true
                            }) {
                                ZStack {
                                    Image("Pornhub")
                                        .resizable()
                                        .scaledToFill()
                                        .blur(radius:3, opaque:true)
                                    Text("Pornhub")
                                        .font(.title3)
                                        .foregroundColor(Color.white)
                                        .shadow(color: Color.black.opacity(0.9), radius: 4, x: 0, y: 0)
                                        .shadow(color: Color.black.opacity(0.9), radius: 4, x: 0, y: 0)
                                }
                                .frame(width: 7*UIScreen.main.bounds.width/24, height: 7*UIScreen.main.bounds.width/24)
                                .cornerRadius(10)
                            }
                        }
                        .frame(width: UIScreen.main.bounds.width)
                    }
                    HStack {
                        Button(action: {
                            homeTab = 4
                            popupVisible = true
                        }) {
                            ZStack {
                                Image("Fapello")
                                    .resizable()
                                    .scaledToFill()
                                    .blur(radius:3, opaque:true)
                                Text("Fapello")
                                    .font(.title3)
                                    .foregroundColor(Color.white)
                                    .shadow(color: Color.black.opacity(0.9), radius: 4, x: 0, y: 0)
                                    .shadow(color: Color.black.opacity(0.9), radius: 4, x: 0, y: 0)
                            }
                            .frame(width: 7*UIScreen.main.bounds.width/24, height: 7*UIScreen.main.bounds.width/24)
                            .cornerRadius(10)
                        }
                        Button(action: {
                            homeTab = 5
                            popupVisible = true
                        }) {
                            ZStack {
                                Image("Coomer")
                                    .resizable()
                                    .scaledToFill()
                                    .blur(radius:3, opaque:true)
                                Text("Coomer")
                                    .font(.title3)
                                    .foregroundColor(Color.white)
                                    .shadow(color: Color.black.opacity(0.9), radius: 4, x: 0, y: 0)
                                    .shadow(color: Color.black.opacity(0.9), radius: 4, x: 0, y: 0)
                            }
                            .frame(width: 7*UIScreen.main.bounds.width/24, height: 7*UIScreen.main.bounds.width/24)
                            .cornerRadius(10)
                        }
                        Button(action: {
                            homeTab = 6
                            popupVisible = true
                        }) {
                            ZStack {
                                Image("Kemono")
                                    .resizable()
                                    .scaledToFill()
                                    .blur(radius:3, opaque:true)
                                Text("Kemono")
                                    .font(.title3)
                                    .foregroundColor(Color.white)
                                    .shadow(color: Color.black.opacity(0.9), radius: 4, x: 0, y: 0)
                                    .shadow(color: Color.black.opacity(0.9), radius: 4, x: 0, y: 0)
                            }
                            .frame(width: 7*UIScreen.main.bounds.width/24, height: 7*UIScreen.main.bounds.width/24)
                            .cornerRadius(10)
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width)
                }
                Spacer()
                HStack {
                    Spacer()
                    NavigationLink(destination: Settings()
                        .navigationBarTitle("Settings", displayMode: .inline)) {
                            ZStack {
                                Text("Settings")
                                    .frame(width: 120, height: 60)
                                    .foregroundColor(Color.white)
                                    .background(Color.accentColor)
                                    .cornerRadius(10)
                            }
                        }
                    Spacer()
                }
                Spacer()
            }
        }
        .preferredColorScheme(.dark)
        .onReceive(NotificationCenter.default.publisher(for: UserDefaults.didChangeNotification)) { _ in
            showWebViews = UserDefaults.standard.bool(forKey: "showWebViews")
        }
    }
}
