//
//  ViewControllerTableViewCell.swift
//  RecyclingCenterApp
//
//  Created by Victor Garcia on 4/22/19.
//  Copyright © 2019 Diana Manzano. All rights reserved.
//

import UIKit

class ViewControllerTableViewCell: UITableViewCell {

   
    @IBOutlet weak var lblName: UILabel!
  
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
