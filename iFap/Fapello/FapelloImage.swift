//
//  FapelloImage.swift
//  iFap
//
//  Created by Dre Dall'Ara on 6/23/23.
//

import SwiftUI
import SwiftSoup
import SDWebImageSwiftUI
import SDWebImage

func getImageArray(modelURL: URL, imageNum: Int, completion: @escaping (URL) -> Void) {
    let imageURLWrapper = URL(string: "\(modelURL.absoluteString)\(String(imageNum))")!
    var imageURL : URL = URL(string: "https://example.com/image.jpg")!
    let task = URLSession.shared.dataTask(with: imageURLWrapper) { (data, response, error) in
        if let error = error {
            print("Error accessing URL: \(error)")
        }
        if let data = data, let html = String(data: data, encoding: .utf8) {
            do {
                let doc : Document = try SwiftSoup.parse(html)
                let realImageURL : String = try doc.select("div > div > div > div > div > a > img").array()[1].attr("src")
                imageURL = URL(string: realImageURL)!
                completion(imageURL)
            } catch {
                print("Error!")
            }
        }
    }
    task.resume()
}

struct FapelloImage: View {
    @State var imageNum : Int
    @State var fapelloURL : URL
    @State var maxCount : Int
    @State var webImageURL : URL = URL(string: "https://example.com/image.jpg")!
    
    var body: some View {
        VStack{
            Spacer()
            HStack {
                WebImage(url: webImageURL)
                    .resizable()
                    .placeholder {
                        ProgressView()
                    }
                    .aspectRatio(contentMode: .fit)
                    .onAppear { getImageArray(modelURL: fapelloURL, imageNum: imageNum) {imageURL in
                            webImageURL = imageURL
                        }
                    }
            }
            .frame(height: UIScreen.main.bounds.height*3/4)
            Spacer()
            HStack {
                Button(action: {
                    if imageNum != maxCount {
                        imageNum += 1
                        getImageArray(modelURL: fapelloURL, imageNum: imageNum) {imageURL in
                            webImageURL = imageURL
                        }
                    }
                }) {
                    ZStack{
                        Color.accentColor
                        Image(systemName: "arrow.backward")
                            .foregroundColor(Color.white)
                    }
                    .frame(width: 80, height: 40)
                    .cornerRadius(10)
                }
                .padding()
                Button(action: {
                    SDWebImageManager.shared.loadImage(with: webImageURL, options: .highPriority, progress: nil) { image, _, _, _, _, _ in
                        guard let image = image else {
                            return
                        }
                        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                    }
                }) {
                    ZStack{
                        Color.accentColor
                        Image(systemName: "square.and.arrow.down")
                            .foregroundColor(Color.white)
                    }
                    .frame(width: 80, height: 40)
                    .cornerRadius(10)
                }
                .padding()
                Button(action: {
                    if imageNum != 1 {
                        imageNum -= 1
                        getImageArray(modelURL: fapelloURL, imageNum: imageNum) {imageURL in
                            webImageURL = imageURL
                        }
                    }
                }) {
                    ZStack{
                        Color.accentColor
                        Image(systemName: "arrow.forward")
                            .foregroundColor(Color.white)
                    }
                    .frame(width: 80, height: 40)
                    .cornerRadius(10)
                }
                .padding()
            }
            Spacer()
        }
        .navigationBarTitle(Text("\(String(imageNum))/\(String(maxCount))"), displayMode: .inline)
    }
}
