//
//  ListCollectionViewCell.swift
//  e-commerce
//
//  Created by Macbook on 22/02/2023.
//

import UIKit
import SDWebImage

protocol DidTabedFavoriteButton {
    func addToFavorite( _ row : Int)
}

class ListCollectionViewCell: UICollectionViewCell {
    
    
    //MARK: VARIBLES
    var fromFavouriteView : Bool?

    var productViewModel : ProductViewModel!
    var productId : Int!
    var inFavourit : Bool = false
    static let identfier = "ListCollectionViewCell"
    
    //MARK: OUTLETS
    
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productNamr: UILabel!
    @IBOutlet weak var productDesc: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
    
    @IBOutlet weak var discountView: CardView!
    @IBOutlet weak var discountLable: UILabel!
    
    @IBOutlet weak var favoruiteButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if fromFavouriteView ?? false{
            favoriteButton.setImage(UIImage(named: "favorite2"), for: .normal)

        }else{
                        favoriteButton.setImage(UIImage(named: "unfavorite"), for: .normal)
                    }
        
//        if inFavourit == false{
//            favoriteButton.setImage(UIImage(named: "unfavorite"), for: .normal)
//
//        }else{
//            favoriteButton.setImage(UIImage(named: "favorite2"), for: .normal)
//        }
//
//                print(productViewModel.inFavorute)
//                if productViewModel.inFavorute == false{
//                    favoriteButton.setImage(UIImage(named: "unfavorite"), for: .normal)
//
//                }else{
//                    favoriteButton.setImage(UIImage(named: "favorite2"), for: .normal)
//                }
        
        
        //  print(productViewModel.id)
        
        productImage.layer.cornerRadius = 10
    }
    
    
    func configure(with model : ProductViewModel){
        
        
        productNamr.text = model.name
        productDesc.text = model.description
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
    
    @IBAction func favouritButton(_ sender: Any) {
        
        inFavourit.toggle()
        if inFavourit == false{
            favoriteButton.setImage(UIImage(named: "unfavorite"), for: .normal)
            
        }else{
            favoriteButton.setImage(UIImage(named: "favorite2"), for: .normal)
        }
        APICaller.postProductInFavorite(token: Token.Tokenalready!, productId: productId) { result in
            switch result{
            case .success(let fav):
                print(fav.message)
                NotificationCenter.default.post(name: NSNotification.Name("DidTappedFromCell"), object: nil)
            case .failure(let error):
                print("errror")
            }
        }
    }
}
