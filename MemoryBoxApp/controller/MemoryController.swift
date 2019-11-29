//
//  MemoryController.swift
//  MemoryBoxApp
//
//  Created by Duncan Levings on 2019-11-28.
//  Copyright © 2019 Upma  Sharma. All rights reserved.
//
import FirebaseFirestore
import Foundation
class MemoryController {
    func getAllMemories(completion: @escaping ([Memory])->()) {
        var memoryList = [Memory]()
        let db = Firestore.firestore()
        db.collection("memories").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting memories: \(err)")
                return
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let mName = data["memory_name"] as? String ?? ""
                    let mDesc = data["memory_description"] as? String ?? ""
                    let mDate = data["memory_date"] as? Date ?? Date()
                    let mImg = data["memory_image"] as? String ?? ""
                    let mXCord = data["memory_location_x"] as? Double ?? 0.0
                    let mYCord = data["memory_location_y"] as? Double ?? 0.0
                    
                    let newMemory = Memory(memoryName: mName, memoryDesc: mDesc, memoryDate: mDate, memoryImage: mImg, x: mXCord, y: mYCord)
                    
                    memoryList.append(newMemory)
                }
                print("Finished collecting memory collection data")
                completion(memoryList)
            }
        }
    }
}
