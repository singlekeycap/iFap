//
//  CreatorView.swift
//  iFap
//
//  Created by Dre Dall'Ara on 7/2/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct CreatorView: View {
    @State var selectedCreator : Creator
    @State var posts : Array<Post> = []
    @State var furry : Bool
    
    var body: some View {
        ScrollView {
            ForEach(posts, id: \.title) { post in
                NavigationLink(destination: PostView(selectedPost: post, furry: furry)
                    .navigationBarTitle(post.published!, displayMode: .inline)) {
                    ZStack {
                        ZStack {
                            if post.file.path != nil && (post.file.path!.contains(".jpg") || post.file.path!.contains(".png") || post.file.path!.contains(".jpeg")) {
                                WebImage(url: URL(string:"https://\(furry ? "kemono" : "coomer").party\(post.file.path!)"))
                                    .resizable()
                                    .scaledToFill()
                                    .blur(radius:2, opaque:true)
                            } else {
                                Color.gray
                                Text("NO IMAGE AVAILABLE")
                                    .padding()
                                    .font(.largeTitle.weight(.bold))
                                    .foregroundColor(Color.black)
                            }
                        }
                        .frame(width: UIScreen.main.bounds.width*9/10, height:200)
                        .cornerRadius(10)
                        .padding([.vertical], 3)
                        VStack {
                            Text(post.title!.replacingOccurrences(of: "\n", with: ""))
                                .font(.title2.weight(.bold))
                                .foregroundColor(Color.white)
                                .shadow(color: Color.black.opacity(0.9), radius: 4, x: 0, y: 0)
                                .shadow(color: Color.black.opacity(0.9), radius: 4, x: 0, y: 0)
                            Spacer()
                            Text(post.published!)
                                .font(.caption)
                                .foregroundColor(Color.white)
                                .shadow(color: Color.black.opacity(0.9), radius: 4, x: 0, y: 0)
                                .shadow(color: Color.black.opacity(0.9), radius: 4, x: 0, y: 0)
                        }
                        .padding()
                    }
                }
            }
        }
        .padding([.top, .horizontal])
        .onAppear {
            getPosts(creator: selectedCreator, furry: furry, completion: { postArray in
                posts = postArray
            })
        }
    }
}

