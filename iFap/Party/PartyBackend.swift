//
//  PartyBackend.swift
//  iFap
//
//  Created by Dre Dall'Ara on 6/27/23.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI
import AVKit

struct Creator {
    var favoriteCount : Int
    var id : String
    var indexed : Double
    var name : String
    var service : String
    var updated : Double
}

struct PostFile {
    var name : String?
    var path : String?
}

struct Post {
    var attachments : Array<PostFile>
    var content : String?
    var file : PostFile
    var published : String?
    var title : String?
}

struct VideoPlayerWrapper: UIViewControllerRepresentable {
    var videoURL: URL
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = AVPlayer(url: videoURL)
        controller.exitsFullScreenWhenPlaybackEnds = true
        controller.allowsPictureInPicturePlayback = true
        controller.canStartPictureInPictureAutomaticallyFromInline = true
        controller.player?.allowsExternalPlayback = true
        return controller
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        // No updates needed
    }
}

func iterateThroughCreators(service: String, completion: @escaping ([Creator]) -> Void) {
    Task {
        var creatorArray : Array<Creator> = []
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        var fileURL = documentsDirectory.appendingPathComponent("creators.json")
        if service == "kemono" {
            fileURL = documentsDirectory.appendingPathComponent("furries.json")
        }
        let creatorsJSONArray = SION(jsonURL: fileURL).array
        for creatorJSON in creatorsJSONArray! {
            let contentCreator = Creator(favoriteCount: creatorJSON["favorited"].int!, id: creatorJSON["id"].string!, indexed: creatorJSON["indexed"].double!, name: creatorJSON["name"].string!, service: creatorJSON["service"].string!, updated: creatorJSON["updated"].double!)
            creatorArray.append(contentCreator)
        }
        completion(creatorArray)
    }
}

func getCreatorSearch(creatorName : String, creatorArray : [Creator]) -> [Creator] {
    var searchedArray : Array<Creator> = []
    for contentCreator in creatorArray {
        if contentCreator.name.lowercased().contains(creatorName.lowercased()) {
            searchedArray.append(contentCreator)
        }
    }
    return searchedArray
}

func getPosts(creator : Creator, furry : Bool, completion: @escaping ([Post]) -> Void) {
    var postArray : Array<Post> = []
    let creatorJSONURL = URL(string: "https://\(furry ? "kemono" : "coomer").party/api/\(creator.service)/user/\(creator.id)")!
    let task = URLSession.shared.dataTask(with: creatorJSONURL) { (data, response, error) in
        if let error = error {
            print("Error: \(error)")
        }
        if let data = data {
            let JSONArray = SION(jsonData: data).array
            for postJSON in JSONArray! {
                var attachments : Array<PostFile> = []
                for attachmentJSON in postJSON["attachments"].array! {
                    attachments.append(PostFile(name: attachmentJSON["name"].string!, path: attachmentJSON["path"].string!))
                }
                let file = PostFile(name: postJSON["file"]["name"].string, path: postJSON["file"]["path"].string)
                let post = Post(attachments: attachments, content: postJSON["content"].string, file: file, published: postJSON["published"].string, title: postJSON["title"].string)
                postArray.append(post)
            }
            completion(postArray)
        }
    }
    task.resume()
}


