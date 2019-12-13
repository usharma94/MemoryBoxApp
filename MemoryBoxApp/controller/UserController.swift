//
//  UserController.swift
//  MemoryBoxApp
//
//  Created by Upma  Sharma on 2019-12-11.
//  Copyright © 2019 Upma  Sharma. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth


class UserController{
    
    public func getAllUser(completion: @escaping ([User])->()) {
        let db = Firestore.firestore()
        var userList = [User]()
        
        db.collection("users").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting users: \(err)")
                return
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let userUID = data["uid"] as? String ?? ""
                    let fName = data["first_name"] as? String ?? ""
                    let lName = data["last_name"] as? String ?? ""
                    let phone = data["phone"] as? String ?? ""
                    let email = data["email"] as? String ?? ""
                    let password = data["password"] as? String ?? ""
                    let memoryList = data["user_memory"] as? [String] ?? []
                    
                    let user = User(userUID: userUID, firstName: fName, lastName: lName, phone: phone, email: email, password: password, userMemory: memoryList)
                    
                    userList.append(user)
                }
                print("Finished collecting user collection data")
                completion(userList)
            }
        }
    }
    
    public func createUser(newUser: User){
        Auth.auth().createUser(withEmail: newUser.email, password: newUser.password) { (result, err) in
            
            //check for errors
            if let err = err{
                //there was an error
                print("Error creating new user")
                print(err.localizedDescription)
            }else{
                
                // User was created successfully, now store the first name and last name
                let db = Firestore.firestore()
                
                db.collection("users").addDocument(data: ["email": newUser.email,"first_name": newUser.firstName, "last_name": newUser.lastName, "phone": newUser.phone, "uid": result!.user.uid, "user_memory": [] ]) { (error) in
                    
                    if error != nil {
                        // Show error message
                        print("Error saving user data")
                        print(error?.localizedDescription as Any)
                    }
                }
            }
        }
    }
    
    func getUserProfile(completion: @escaping (User)->()){
        let db = Firestore.firestore()
        
        db.collection("users").whereField("uid", isEqualTo: Auth.auth().currentUser?.uid).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting user: \(err)")
                return
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let userUID = data["uid"] as? String ?? ""
                    let fName = data["first_name"] as? String ?? ""
                    let lName = data["last_name"] as? String ?? ""
                    let phone = data["phone"] as? String ?? ""
                    let email = data["email"] as? String ?? ""
                    let password = data["password"] as? String ?? ""
                    let memoryList = data["user_memory"] as? [String] ?? []
                    
                    let user = User(userUID: userUID, firstName: fName, lastName: lName, phone: phone, email: email, password: password, userMemory: memoryList)
                    completion(user)
                }
                print("Successfully retrieved user")
            }
        }
    }
    
    func updateUser(updateUser: User){
        let db = Firestore.firestore()
        
        db.collection("users").whereField("uid", isEqualTo: Auth.auth().currentUser?.uid).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting user: \(err)")
                return
            } else {
                for document in querySnapshot!.documents {
                    db.collection("users").document(document.documentID).updateData([
                        "first_name": updateUser.firstName
                    ])
                }
                print("Successfully updated user")
            }
        }
    }
    
    func updateUserPassword(newPassword: String) {
        if (newPassword == "") {
            return
        }
        
        Auth.auth().currentUser?.updatePassword(to: newPassword) { (error) in
            if error != nil{
                print(error?.localizedDescription as Any)
            }else{
                print("Updated password Successfully")
            }
        }
    }
    
    
}
