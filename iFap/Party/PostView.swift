//
//  PostView.swift
//  iFap
//
//  Created by Dre Dall'Ara on 7/2/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct PostView: View {
    @State var selectedPost : Post
    @State var furry : Bool
    @State var showDownloadAlert = false
    @State var downloadURL = URL(string: "https://coomer.party/")!
    @State var isPresented = true
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if let content = selectedPost.content {
                    Text(content)
                }
                if let postPath = selectedPost.file.path {
                    if (postPath.contains("mkv") || postPath.contains("mov") || postPath.contains("mp4") || postPath.contains("m4v")) {
                        VideoPlayerWrapper(videoURL: URL(string: "https://\(furry ? "kemono" : "coomer").party\(postPath)")!)
                            .aspectRatio(contentMode: .fit)
                    } else {
                        WebImage(url: URL(string: "https://\(furry ? "kemono" : "coomer").party\(postPath)"))
                            .resizable()
                            .indicator(.activity)
                            .aspectRatio(contentMode: .fit)
                            .onLongPressGesture {
                                downloadURL = URL(string: "https://\(furry ? "kemono" : "coomer").party\(postPath)")!
                                showDownloadAlert = true
                            }
                    }
                }
                if selectedPost.attachments.count > 0 {
                    ForEach(selectedPost.attachments, id:\.path) { postAttachment in
                        if let postPath = postAttachment.path {
                            if (postPath.contains("mkv") || postPath.contains("mov") || postPath.contains("mp4") || postPath.contains("m4v")) {
                                VideoPlayerWrapper(videoURL: URL(string: "https://coomer.party\(postPath)")!)
                                    .aspectRatio(contentMode: .fit)
                            } else {
                                WebImage(url: URL(string: "https://\(furry ? "kemono" : "coomer").party\(postPath)"))
                                    .resizable()
                                    .indicator(.activity)
                                    .aspectRatio(contentMode: .fit)
                                    .onLongPressGesture {
                                        downloadURL = URL(string: "https://\(furry ? "kemono" : "coomer").party\(postPath)")!
                                        showDownloadAlert = true
                                    }
                            }
                        }
                    }
                }
            }
        }
        .padding([.top, .horizontal])
        .alert(isPresented: $showDownloadAlert) {
            Alert(title: Text("Download Image?"), primaryButton: .default(Text("Yes"), action: {
                SDWebImageManager.shared.loadImage(with: downloadURL, options: .highPriority, progress: nil) { image, _, _, _, _, _ in
                    guard let image = image else {
                        return
                    }
                    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                }
            }), secondaryButton: .default(Text("No")))
        }
    }
}
