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
    var posts : String
    var likes : String
    var fapelloURL : URL
}

func getSearch(modelName: String, completion: @escaping (Array<String>) -> Void) {
    if let url = URL(string: "https://fapello.com//search/\(modelName)") {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error accessing URL: \(error)")
            }
            if let data = data, let html = String(data: data, encoding: .utf8) {
                do{
                    var resultLinks : Array<String> = []
                    let doc : Document = try SwiftSoup.parse(html)
                    let resultLinksElements: Array<Element> = try doc.select("div > div > div > div > div > div > div > div > a").array()
                    for i in stride(from: 0, to: resultLinksElements.count, by: 1) {
                        let link : String = try resultLinksElements[i].attr("href")
                        resultLinks.append(link)
                    }
                    completion(resultLinks)
                } catch {
                   print("Error!")
                }
            }
        }
        task.resume()
    }
}

func getInfo(modelURL: URL, completion: @escaping (Model) -> Void) {
    var model : Model = Model(avatar: "", name: "", posts: "", likes: "", fapelloURL: modelURL)
    let task = URLSession.shared.dataTask(with: modelURL) { (data, response, error) in
        if let error = error {
            print("Error accessing URL: \(error)")
        }
        if let data = data, let html = String(data: data, encoding: .utf8) {
            do {
                let doc : Document = try SwiftSoup.parse(html)
                let avatarURL : String = try doc.getElementsByClass("bg-gray-200 border-4 border-white rounded-full w-full h-full dark:border-gray-900").attr("src")
                let postsCount : String = try doc.getElementsByClass("flex lg:flex-row flex-col").text()
                let likesCount : String = try doc.getElementsByClass("lg:pl-4 flex lg:flex-row flex-col").text()
                let name : String = try doc.getElementsByClass("font-semibold lg:text-2xl text-lg mb-2 mt-4").text()
                model = Model(avatar: avatarURL, name: name, posts: postsCount, likes: likesCount, fapelloURL: modelURL)
                completion(model)
            } catch {
                print("Error!")
            }
        }
    }
    task.resume()
}

struct FapelloSearch: View {
    @State var searchText = ""
    @State var showCancelButton: Bool = false
    @State var modelArray: Array<Model> = []
    @State var selectedModel: Model = Model(avatar:"", name:"", posts:"", likes:"", fapelloURL:URL(string:"https://fapello.com")!)
    
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
                            getSearch(modelName: searchText) { links in
                                for link in links {
                                    getInfo(modelURL: URL(string: link)!) { model in
                                        modelArray.append(model)
                                    }
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
                                    WebImage(url: URL(string:model.avatar))
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
                                    WebImage(url: URL(string:model.avatar))
                                        .resizable()
                                        .placeholder(content: {Color.gray})
                                        .indicator(.activity)
                                        .scaledToFill()
                                        .frame(width: 60, height:60)
                                        .cornerRadius(30)
                                    VStack {
                                        Text(model.name)
                                            .foregroundColor(Color.white)
                                        Text("\(model.likes) | \(model.posts)")
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
