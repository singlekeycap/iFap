//
//  FapelloModel.swift
//  iFap
//
//  Created by Dre Dall'Ara on 6/20/23.
//

import SwiftUI
import SDWebImageSwiftUI
import SwiftSoup
import Foundation

struct ModelImage {
    var imageCount : Int
    var contentURL : String
    var username : String
}

// https://fapello.com/content/b/e/belle-delphine-11/7000/belle-delphine-11_6215_300px.jpg

func getModelImage(urlArray : [String], username : String) -> ModelImage {
    var split = urlArray[(urlArray.count - 1)].split(separator: "_")
    let maxImageCount = Int(split[split.count - 2])!
    split = urlArray[(urlArray.count - 1)].split(separator: "/")
    let contentURL = split.dropLast().dropLast().joined(separator: "/")
    let modelImage = ModelImage(imageCount: maxImageCount, contentURL: contentURL, username: username)
    return modelImage
}

func createImageURLArray(username : String) -> [String] {
    var escapingArray : Array<String> = []
    let url = URL(string: "https://api.keycap.one/fapello/model/\(username)")!
    let jsonImageArray = SION(jsonURL: url).array
    for image in jsonImageArray! {
        let imageURL = image.string!
        escapingArray.append(imageURL)
    }
    return escapingArray
}

struct FapelloModel: View {
    @State var selectedModel: Model
    
    var body: some View {
        VStack {
            ScrollView {
                let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
                VStack {
                    ZStack{
                        Color.clear
                    }
                    .frame(height:10)
                    LazyVGrid(columns: columns) {
                        let URLArray = createImageURLArray(username: selectedModel.username)
                        let imageCount = getModelImage(urlArray: URLArray, username: selectedModel.username).imageCount
                        ForEach (URLArray, id: \.self) { imageURL in
                            let navImageNum = imageURL.components(separatedBy: "_")[imageURL.components(separatedBy: "_").count - 2]
                            NavigationLink(destination: FapelloImage(imageNum: Int(navImageNum)!, username: selectedModel.username, maxCount: imageCount)
                                .navigationBarTitle("\(navImageNum)/\(String(imageCount))", displayMode: .inline)) {
                                ZStack{
                                    WebImage(url: URL(string: "\(imageURL)"))
                                        .resizable()
                                        .purgeable(true)
                                        .placeholder {
                                            ZStack{
                                                Color.gray
                                                Text("No preview\navailable")
                                                    .font(.caption.weight(.bold))
                                                    .foregroundColor(Color.black)
                                            }
                                        }
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 7*UIScreen.main.bounds.width/24, height: 7*UIScreen.main.bounds.width/24)
                                        .clipped()
                                }
                                .background(Color.clear)
                                .cornerRadius(4)
                            }
                        }
                    }
                }
            }
            .padding([.horizontal])
        }
    }
}
