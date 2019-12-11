//
//  User.swift
//  MemoryBoxApp
//
//  Created by Upma  Sharma on 2019-12-11.
//  Copyright © 2019 Upma  Sharma. All rights reserved.
//

import Foundation

class User {
    var firstName: String = ""
    var lastName: String = ""
    var phone:String = ""
    var email: String = ""
    var password: String = ""
   
    var userMemory: Array = [String]()
    
    
    init(firstName: String, lastName: String, phone: String, email: String, password: String, userMemory: [String]){
        self.firstName = firstName
        self.lastName = lastName
        self.phone = phone
        self.email = email
        self.password = password
        self.userMemory = userMemory
    }
    
    init() {}
}
