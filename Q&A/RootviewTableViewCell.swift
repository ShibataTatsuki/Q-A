//
//  RootviewTableViewCell.swift
//  
//
//  Created by 柴田　樹希 on 2017/10/21.
//
//

import UIKit

class RootviewTableViewCell: UITableViewCell {
    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var postDateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
