//
//  UpdateUserController.swift
//  MemoryBoxApp
//
//  Created by Upma  Sharma on 2019-12-12.
//  Copyright © 2019 Upma  Sharma. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth

class UpdateUserController{
    
    func getUserProfile(){
        let user = Auth.auth().currentUser
        if let user = user {
          
         
        }
    }
    
    func updateUser(updateUser: User){
        Auth.auth().currentUser?.updateEmail(to: updateUser.email) { (error) in
            if error != nil{
                print(error?.localizedDescription as Any)
            }else{
                print("Updated Email Successfully")
            }
        }
    }
    
}
