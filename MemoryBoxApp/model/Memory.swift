//
//  Memory.swift
//  MemoryBoxApp
//
//  Created by Duncan Levings on 2019-11-28.
//  Copyright © 2019 Upma  Sharma. All rights reserved.
//

import Foundation
class Memory {
    var memoryName: String = ""
    var memoryDesc: String = ""
    var memoryDate: Date = Date()
    var xCord: Double = 0.0
    var yCord: Double = 0.0
    var memoryImage: String = ""
    
    init(memoryName: String, memoryDesc: String, memoryDate: Date, memoryImage: String, x: Double, y: Double){
        self.memoryName = memoryName
        self.memoryDesc = memoryDesc
        self.memoryDate = memoryDate
        self.memoryImage = memoryImage
        self.xCord = x
        self.yCord = y
    }
    
    init() {}
}
