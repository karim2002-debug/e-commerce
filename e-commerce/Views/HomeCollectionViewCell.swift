//
//  HomeCollectionViewCell.swift
//  e-commerce
//
//  Created by Macbook on 21/02/2023.
//

import UIKit
import SDWebImage
class HomeCollectionViewCell: UICollectionViewCell {

    
    static let identfier = "HomeCollectionViewCell"
    
    //MARK: VAR
    
    var productPreview : MainTitlePreview!
    
    //MARK: OUTLETS
    
    @IBOutlet weak var cardView: CardView!
    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var productName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    func configuer(with model : MainTitlePreview){
        productName.text = model.productName
        guard let url = URL(string: model.productImage!)else{
            productImage.image = UIImage(named : "lunchScren")
            return
        }
        productImage.sd_setImage(with: url)
    }

    
    
}
