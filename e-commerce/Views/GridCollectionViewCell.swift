//
//  GridCollectionViewCell.swift
//  e-commerce
//
//  Created by Macbook on 23/02/2023.
//

import UIKit

class GridCollectionViewCell: UICollectionViewCell {

    
    static let identifer = "GridCollectionViewCell"
    //MARK: OUTLETS
    
    
    @IBOutlet weak var discountView: CardView!
    @IBOutlet weak var discountLable: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productdescre: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
 
    
    func configuer(with model : ProductViewModel){
        
        productName.text = model.name
        productdescre.text = model.description
        productPrice.text = model.price
        if model.discount == 0{
            discountView.isHidden = true
            discountLable.isHidden = true
        }else{
            discountLable.text = "-\(model.discount)$"
        }
       
        guard let url = URL(string: model.image)else{
            return
        }
        productImage.sd_setImage(with: url)
    }
        
        
 

}
