//
//  Fapello.swift
//  iFap
//
//  Created by Dre Dall'Ara on 4/15/23.
//

import SwiftUI
import SwiftSoup
import SDWebImageSwiftUI

struct Model {
    var avatar : String
    var name : String
    var posts : Int
    var likes : Int
    var username : String
}

func getSearch(modelName: String, completion: @escaping (Array<Model>) -> Void) {
    if let url = URL(string: "https://api.keycap.one/fapello/search/\(modelName)") {
        let modelsArray = SION(jsonURL: url).array
        var escapingArray : Array<Model> = []
        for model in modelsArray! {
            let fapelloModel = Model(avatar: model["avatar_url"].string!, name: model["name"].string!, posts: model["posts_count"].int!, likes: model["likes_count"].int!, username: model["username"].string!)
            escapingArray.append(fapelloModel)
        }
        completion(escapingArray)
    }
}

struct FapelloSearch: View {
    @State var searchText = ""
    @State var showCancelButton: Bool = false
    @State var modelArray: Array<Model> = []
    @State var selectedModel: Model = Model(avatar:"", name:"", posts:0, likes:0, username:"")
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        
                        TextField("Search", text: $searchText, onEditingChanged: { isEditing in
                            self.showCancelButton = true
                        }, onCommit: {
                            modelArray = []
                            getSearch(modelName: searchText) { models in
                                for model in models {
                                    modelArray.append(model)
                                }
                            }
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
                    ForEach(modelArray, id: \.name) { model in
                        NavigationLink(destination: FapelloModel(selectedModel: model)
                            .navigationBarTitle("Posts", displayMode: .inline)) {
                            ZStack {
                                ZStack {
                                    WebImage(url: URL(string: model.avatar))
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
                                    WebImage(url: URL(string: model.avatar))
                                        .resizable()
                                        .placeholder(content: {Color.gray})
                                        .indicator(.activity)
                                        .scaledToFill()
                                        .frame(width: 60, height:60)
                                        .cornerRadius(30)
                                    VStack {
                                        Text(model.name)
                                            .foregroundColor(Color.white)
                                        Text("\(model.likes) likes | \(model.posts) posts")
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
            .navigationBarTitle(Text("Fapello"), displayMode: .inline)
        }
    }
}
