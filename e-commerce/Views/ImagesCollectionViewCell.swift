//
//  ImagesCollectionViewCell.swift
//  e-commerce
//
//  Created by Macbook on 24/02/2023.
//

import UIKit
import SDWebImage


class ImagesCollectionViewCell: UICollectionViewCell {

    static let identifer = "ImagesCollectionViewCell"
    
    var discount : Float!
     
    
    @IBOutlet weak var imagesProudct: UIImageView!
    
    @IBOutlet weak var labelDiscount: UILabel!
    @IBOutlet weak var dicountView: CardView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    
        print(discount)
//        if discount == 0{
//
//            labelDiscount.isHidden = true
//            dicountView.isHidden = true
//
//        }else{
//            labelDiscount.text = "\(discount) %"
//        }
//
        
    }
    func setCell(images : [String]){
        for imagee in images {
            print(imagee)
            guard let url = URL(string: imagee)else{
                return
            }
            
            imagesProudct.sd_setImage(with: url)
            
        }
    }
}
 
 
