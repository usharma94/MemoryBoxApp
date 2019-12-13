//
//  UserCell.swift
//  MemoryBoxApp
//
//  Created by Duncan Levings on 2019-12-13.
//  Copyright © 2019 Upma  Sharma. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    
    @IBOutlet var userName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
