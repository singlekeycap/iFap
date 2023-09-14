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

struct FapelloPost {
    var postURL : URL
    var postType : String
}

func getImageURL(username: String, imageNum: Int, completion: @escaping (FapelloPost) -> Void) {
    let url = URL(string: "https://api.keycap.one/fapello/model/\(username)/post/\(String(imageNum))")!
    let postJSON = SION(jsonURL: url)
    let escapingPost = FapelloPost(postURL: URL(string: postJSON["post_url"].string!)!, postType: postJSON["media_type"].string!)
    completion(escapingPost)
}

struct FapelloImage: View {
    @State var imageNum : Int
    @State var username : String
    @State var maxCount : Int
    @State var post : FapelloPost = FapelloPost(postURL: URL(string: "https://fapello.com")!, postType: "photo")
    @State var videoURL : URL = URL(string: "https://fapello.com")!
    
    var body: some View {
        let _ = UserDefaults.standard.string(forKey: "fapelloChangeType")
        VStack{
            Spacer()
            HStack {
                if post.postType == "photo" {
                    WebImage(url: post.postURL)
                        .resizable()
                        .placeholder {
                            ProgressView()
                        }
                        .aspectRatio(contentMode: .fit)
                } else if post.postType == "video" {
                    VideoPlayerView(videoURL: post.postURL)
                        .aspectRatio(contentMode: .fit)
                } else {
                    ZStack {
                        Color.gray
                        Text("Post was\ndeleted!")
                            .font(.largeTitle.bold())
                            .foregroundColor(Color.black)
                    }
                    .frame(height: UIScreen.main.bounds.height/2)
                }
            }
            .onAppear { getImageURL(username: username, imageNum: imageNum) {newPost in
                    post = newPost
                }
            }
            .frame(height: UIScreen.main.bounds.height*3/4)
            Spacer()
            HStack {
                Button(action: {
                    if imageNum != maxCount {
                        imageNum += 1
                        getImageURL(username: username, imageNum: imageNum) {newPost in
                            post = newPost
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
                if post.postType == "photo" {
                    Button(action: {
                        SDWebImageManager.shared.loadImage(with: post.postURL, options: .highPriority, progress: nil) { image, _, _, _, _, _ in
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
                }
                Button(action: {
                    if imageNum != 1 {
                        imageNum -= 1
                        getImageURL(username: username, imageNum: imageNum) {newPost in
                            post = newPost
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
        .navigationBarTitle(Text("\(String(maxCount - imageNum + 1))/\(String(maxCount))"), displayMode: .inline)
    }
}
