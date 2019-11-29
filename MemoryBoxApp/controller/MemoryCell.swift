//
//  MemoryCell.swift
//  MemoryBoxApp
//
//  Created by Duncan Levings on 2019-11-28.
//  Copyright © 2019 Upma  Sharma. All rights reserved.
//

import UIKit

class MemoryCell: UITableViewCell {
    
    @IBOutlet var memoryName: UILabel!
    @IBOutlet var memoryDesc: UILabel!
    @IBOutlet var memoryImg: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
