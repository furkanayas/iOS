//
//  MainTableViewCell.swift
//  AyasNewsPaperFinal
//
//  Created by furkanayas on 28.04.2020.
//  Copyright © 2020 furkanayas. All rights reserved.
//

import UIKit
import CoreData

class MainTableViewCell: UITableViewCell {


    @IBOutlet weak var nameofNewsPaperMainCell: UILabel!
      
    @IBOutlet weak var  imageofNewsPaperMainCell: UIImageView!
       
   // @IBOutlet weak var isactiveofNewsPaperMainCell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
