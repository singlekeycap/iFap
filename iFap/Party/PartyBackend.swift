//
//  PartyBackend.swift
//  iFap
//
//  Created by Dre Dall'Ara on 6/27/23.
//

import Foundation

struct Creator {
    var favoriteCount : Int
    var id : String
    var indexed : Double
    var name : String
    var service : String
    var updated : Double
}

func iterateThroughCreators(service: String, completion: @escaping ([Creator]) -> Void) {
    Task {
        var creatorArray : Array<Creator> = []
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        var fileURL = documentsDirectory.appendingPathComponent("creators.json")
        if service == "kemono"{
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
