//
//  MemoryController.swift
//  MemoryBoxApp
//
//  Created by Duncan Levings on 2019-11-28.
//  Copyright © 2019 Upma  Sharma. All rights reserved.
//
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth
import Foundation
import Kingfisher

class MemoryController {
    private func getUserMemoryList(completion: @escaping ([String])->()) {
        let db = Firestore.firestore()
        var ownedMemoryList = [String]()
        
        db.collection("users").whereField("uid", isEqualTo: Auth.auth().currentUser!.uid).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting user: \(err)")
                completion(ownedMemoryList)
                return
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    ownedMemoryList = data["user_memory"] as? [String] ?? []
                }
                print(ownedMemoryList)
                print("Successfully retrieved owned user memories")
                completion(ownedMemoryList)
            }
        }
    }
    
    func getAllMemories(completion: @escaping ([Memory])->()) {
        let db = Firestore.firestore()
        var memoryList = [Memory]()
        
        self.getUserMemoryList() { ownedMemoryList in
            db.collection("memories").getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting memories: \(err)")
                    return
                } else {
                    for document in querySnapshot!.documents {
                        let data = document.data()
                        if (ownedMemoryList.contains(document.documentID)) {
                            let mName = data["memory_name"] as? String ?? ""
                            let mDesc = data["memory_description"] as? String ?? ""
                            let mDate = data["memory_date"] as? Date ?? Date()
                            let mImg = data["memory_image"] as? String ?? ""
                            let mXCord = data["memory_location_x"] as? Double ?? 0.0
                            let mYCord = data["memory_location_y"] as? Double ?? 0.0
                            
                            let newMemory = Memory(memoryName: mName, memoryDesc: mDesc, memoryDate: mDate, memoryImage: mImg, x: mXCord, y: mYCord)
                            
                            memoryList.append(newMemory)
                        }
                    }
                    print("Finished collecting memory collection data")
                    completion(memoryList)
                }
            }
        }
    }
    
    func downloadImg(imageView: UIImageView, uid: String) {
        let query = Firestore.firestore()
            .collection("imagesCollection")
            .whereField("uid", isEqualTo: uid)
        
        query.getDocuments { (snapshot, err) in
            if let err = err {
                print("\(err.localizedDescription)")
                return
            }
            
            guard let snapshot = snapshot,
                let data = snapshot.documents.first?.data(),
                let urlString = data["imageUrl"] as? String,
                let url = URL(string: urlString) else {
                print("Something went wrong with uploading image!")
                return
            }
            
            let resource = ImageResource(downloadURL: url)
            imageView.kf.setImage(with: resource, completionHandler: { (result) in
                switch result {
                case .success(_):
                    print("successfully downloaded image from database")
                case .failure(let err):
                    print("\(err.localizedDescription)")
                }
            })
        }
    }
    
    func createMemory(imageView: UIImageView, memory: Memory, completion: @escaping (Bool)->()) {
        print("Started memory creation...")
        self.uploadImg(imageView: imageView) { uid in
            if (uid != "") {
                self.sendMemoryToDB(imageUID: uid, newMemory: memory) { complete in
                    completion(complete)
                }
            }
        }
    }
    
    private func sendMemoryToDB(imageUID: String, newMemory: Memory, completion: @escaping (Bool)->()) {
        let db = Firestore.firestore()

        let memory = db.collection("memories").addDocument(data: [
            "memory_name": newMemory.memoryName,
            "memory_description": newMemory.memoryDesc,
            "memory_date": newMemory.memoryDate,
            "memory_image": imageUID,
            "memory_location_x": newMemory.xCord,
            "memory_location_y": newMemory.yCord]) { (error) in
            
            if error != nil {
                print(error?.localizedDescription as Any)
                completion(false)
                return
            }
            
            print("successfully saved memory to database")
        }

        db.collection("users").whereField("uid", isEqualTo: Auth.auth().currentUser!.uid).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting user: \(err)")
                  completion(false)
                return
            } else {
                for document in querySnapshot!.documents {
                    db.collection("users").document(document.documentID).updateData([
                        "user_memory": FieldValue.arrayUnion([memory.documentID])
                    ])
                }
                print("Successfully added memory to user memory array")
            }
        }
        completion(true)
    }
    
    private func uploadImg(imageView: UIImageView, completion: @escaping (String)->()) {
        guard let image = imageView.image, let data = image.jpegData(compressionQuality: 1.0) else {
            print("Something went wrong with uploading image!")
            completion("")
            return
        }

        var imageUID = ""
        let imageName = UUID().uuidString
        let imageRef = Storage.storage().reference()
            .child("imagesFolder")
            .child(imageName)
        
        imageRef.putData(data, metadata: nil) { (metadata, err) in
            if let err = err {
                print("\(err.localizedDescription)")
                return
            }
            
            imageRef.downloadURL(completion: { (url, err) in
                if let err = err {
                    print("\(err.localizedDescription)")
                    return
                }
                
                guard let url = url else {
                    print("Something went wrong with retrieving URL!")
                    return
                }
                
                let urlString = url.absoluteString
                let dataRef = Firestore.firestore().collection("imagesCollection").document()
                let documentUid = dataRef.documentID
                imageUID = documentUid
                
                let data = [
                    "uid": documentUid,
                    "imageUrl": urlString
                ]
                
                dataRef.setData(data, completion: { (err) in
                    if let err = err {
                        print("\(err.localizedDescription)")
                        return
                    }
                    
                    print("successfully saved image to database")
                    completion(imageUID)
                })
            })
        }
        completion(imageUID)
    }
}
