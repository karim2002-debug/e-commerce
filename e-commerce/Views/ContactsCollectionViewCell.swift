//
//  ContactsCollectionViewCell.swift
//  e-commerce
//
//  Created by Macbook on 10/03/2023.
//

import UIKit

class ContactsCollectionViewCell: UICollectionViewCell {

   static let idenifier = "ContactsCollectionViewCell"
    
    @IBOutlet weak var ContactImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        ContactImage.layer.cornerRadius = 10
        
    }

}
