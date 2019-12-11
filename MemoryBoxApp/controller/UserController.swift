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
    
    
}
