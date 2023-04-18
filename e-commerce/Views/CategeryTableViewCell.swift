//
//  CategeryTableViewCell.swift
//  e-commerce
//
//  Created by Macbook on 24/02/2023.
//

import UIKit

class CategeryTableViewCell: UITableViewCell {

    static let identifer = "CategeryTableViewCell"
    
    //MARK: OUTLETS
    
    @IBOutlet weak var Catogeryimage: UIImageView!
    
    @IBOutlet weak var catogeryName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        Catogeryimage.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    
    func configuer(with model : CatogeryViewModel){
        catogeryName.text = model.name
    }
    
}
