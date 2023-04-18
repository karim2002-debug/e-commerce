//
//  ProfileTableViewCell.swift
//  e-commerce
//
//  Created by Macbook on 06/03/2023.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    static let identfier = "ProfileTableViewCell"
    
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var mainLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
