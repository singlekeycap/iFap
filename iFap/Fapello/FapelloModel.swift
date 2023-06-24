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

func getModelImage(modelURL: URL) -> ModelImage {
    var resultData: Data?
    let semaphore = DispatchSemaphore(value: 0)
    var modelImage : ModelImage
    
    let task = URLSession.shared.dataTask(with: modelURL) { (data, response, error) in
        defer {
            semaphore.signal()
        }
        
        if let error = error {
            print("Error: \(error.localizedDescription)")
            return
        }
        
        resultData = data
        
    }
    task.resume()
    semaphore.wait()
    
    modelImage = ModelImage(imageCount: 0, contentURL: "https://fapello.com", username: "")
    
    if let data = resultData, let html = String(data: data, encoding: .utf8) {
        do{
            var imageCount = 0
            var contentURL = "https://fapello.com"
            var username = ""
            let doc : Document = try SwiftSoup.parse(html)
            let imageCountElement: Array<Element> = try doc.getElementsByClass("w-full h-full absolute object-cover inset-0").array()
            let imageCountLink: String = try imageCountElement[0].attr("src")
            let imageCountLinkArray: Array<String> = imageCountLink.components(separatedBy: "_")
            imageCount = Int(imageCountLinkArray[1])!
            let contentURLArray: Array<String> = imageCountLink.components(separatedBy: String(Int(ceil(Double(imageCount) / Double(1000))) * 1000))
            contentURL = contentURLArray[0]
            let usernameArray: Array<String> = imageCountLinkArray[0].components(separatedBy: "/")
            username = usernameArray[usernameArray.count - 1]
            modelImage = ModelImage(imageCount: imageCount, contentURL: contentURL, username: username)
        } catch {
            print("Error!")
        }
    }
    
    return modelImage
}

func createImageURLArray(model : Model) -> [String] {
    var imageURLs: [String] = []
    let modelImage = getModelImage(modelURL: model.fapelloURL)
    let imageCount = modelImage.imageCount
    for i in 0...(imageCount-1) {
        var roundedCountInt = Int(ceil(Double(imageCount - i) / Double(1000))) * 1000
        if (imageCount - i) % 1000 == 0 {
            roundedCountInt += 1000
        }
        let roundedCount = String(roundedCountInt)
        let formattedNumber = String(format: "%04d", imageCount - i)
        let urlString = "\(modelImage.contentURL)\(roundedCount)/\(modelImage.username)_\(formattedNumber)_150px"
        imageURLs.append(urlString)
    }
    return imageURLs
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
                        let imageCount = getModelImage(modelURL: selectedModel.fapelloURL).imageCount
                        ForEach (createImageURLArray(model: selectedModel), id: \.self) { imageURL in
                            let navImageNum = imageURL.components(separatedBy: "_")[imageURL.components(separatedBy: "_").count - 2]
                            NavigationLink(destination: FapelloImage(imageNum: Int(navImageNum)!, fapelloURL: selectedModel.fapelloURL, maxCount: imageCount)
                                .navigationBarTitle("\(navImageNum)/\(String(imageCount))", displayMode: .inline)) {
                                ZStack{
                                    WebImage(url: URL(string: "\(imageURL).jpeg"))
                                        .resizable()
                                        .purgeable(true)
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 7*UIScreen.main.bounds.width/24, height: 7*UIScreen.main.bounds.width/24)
                                        .clipped()
                                    WebImage(url: URL(string: "\(imageURL).png"))
                                        .resizable()
                                        .purgeable(true)
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 7*UIScreen.main.bounds.width/24, height: 7*UIScreen.main.bounds.width/24)
                                        .clipped()
                                    WebImage(url: URL(string: "\(imageURL).jpg"))
                                        .resizable()
                                        .purgeable(true)
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
