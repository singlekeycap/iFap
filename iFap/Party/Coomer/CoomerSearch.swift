//
//  CoomerSearch.swift
//  iFap
//
//  Created by Dre Dall'Ara on 6/25/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct CoomerSearch: View {
    @State var searchText = ""
    @State var showCancelButton: Bool = false
    @State var creatorArray: Array<Creator> = []
    @State var searchedArray: Array<Creator> = []
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        
                        TextField("Search", text: $searchText, onEditingChanged: { isEditing in
                            self.showCancelButton = true
                        }, onCommit: {
                            searchedArray = getCreatorSearch(creatorName: searchText, creatorArray: creatorArray)
                        })
                        .autocapitalization(.none)
                        .autocorrectionDisabled(true)
                        
                        Button(action: {
                            self.searchText = ""
                        }) {
                            Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
                        }
                    }
                }
                .padding()
                ScrollView {
                    ForEach(searchedArray, id: \.id) { creator in
                        NavigationLink(destination: CoomerCreator(selectedCreator: creator)
                            .navigationBarTitle("Posts", displayMode: .inline)) {
                            ZStack {
                                ZStack {
                                    WebImage(url: URL(string:"https://img.coomer.party/banners/\(creator.service)/\(creator.id)"))
                                        .resizable()
                                        .placeholder(content: {Color.gray})
                                        .scaledToFill()
                                        .blur(radius:7, opaque:true)
                                    Color.black.opacity(0.5)
                                }
                                .frame(width: UIScreen.main.bounds.width*9/10, height:100)
                                .cornerRadius(10)
                                .padding([.vertical], 3)
                                
                                HStack {
                                    WebImage(url: URL(string:"https://img.coomer.party/icons/\(creator.service)/\(creator.id)"))
                                        .resizable()
                                        .placeholder(content: {Color.gray})
                                        .indicator(.activity)
                                        .scaledToFill()
                                        .frame(width: 60, height:60)
                                        .cornerRadius(30)
                                    VStack {
                                        Text(creator.name)
                                            .foregroundColor(Color.white)
                                        Text("\(String(creator.favoriteCount)) favorites | \(creator.service)")
                                            .foregroundColor(Color.white)
                                    }
                                    .frame(width:UIScreen.main.bounds.width / 2)
                                    .padding()
                                }
                            }
                        }
                    }
                }
                .padding([.top, .horizontal])
            }
            .navigationBarTitle(Text("Coomer.party"), displayMode: .inline)
        }
        .onAppear {
            iterateThroughCreators(service: "coomer", completion: { loadedArray in
                creatorArray = loadedArray
            })
        }
    }
}
