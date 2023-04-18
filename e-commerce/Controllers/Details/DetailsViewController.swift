//
//  DetailsViewController.swift
//  e-commerce
//
//  Created by Macbook on 24/02/2023.
//

import UIKit
import NVActivityIndicatorView


protocol Favourits {
    func getProductId(productId : Int)
}


class DetailsViewController: UIViewController {
    
    //MARK: VARIBLE
    
    var delegete : Favourits?
    var model : ProductsDetailsViewModel!
    var inFavorite : Bool!
    var imageCatogries : String!
    
    //MARK: OUTLETS
    
    @IBOutlet weak var activityIndictor: NVActivityIndicatorView!
    
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productDescribtion: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productDiscount: UILabel!
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var finalprice: UILabel!
    @IBOutlet weak var discountView: CardView!
    @IBOutlet weak var labelDiscount: UILabel!
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addToCartButton.applyTheMainButtonDesign()
        print(model.id)
        
        
       self.delegete?.getProductId(productId: model.id)
//        let vc = FavouriteViewController()
//        print(vc.productId)
//         for product in vc.favouriteList{
//            print(vc.favouriteList)
//            if model.id == product.product?.id{
//                favoriteButton.setImage(UIImage(named: "favorite2"), for: .normal)
//            }
//        }
//
       
       //print(inFavorite)
      
        
//        if  inFavorite == true{
//             favoriteButton.setImage(UIImage(named: "favorite2"), for: .normal)
//       }else{
//            favoriteButton.setImage(UIImage(named: "unfavorite"), for: .normal)
//       }
        
//        NotificationCenter.default.addObserver(forName: NSNotification.Name("Infav"), object: nil, queue: nil) { _ in
//            self.favoriteButton.setImage(UIImage(named: "favorite2"), for: .normal)
//        }
//        NotificationCenter.default.addObserver(forName: NSNotification.Name("NotInfav"), object: nil, queue: nil) { _ in
//            self.favoriteButton.setImage(UIImage(named: "unfavorite"), for: .normal)
//        }
//        hideTabBar()
        
       
        title = model.name
       
        if model.discount == 0 {
            discountView.isHidden = true
            labelDiscount.isHidden = true
        }else{
            labelDiscount.text = "\(model.discount) %"
        }
        
         configuers()
        regesterCelles()
        
     }
 
     
    func hideTabBar(){
        
        // to hide Tab bar
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.7, options: .curveEaseOut) {
            if let tabBarFrame = self.tabBarController?.tabBar.frame {
                self.tabBarController?.tabBar.frame.origin.y = self.navigationController!.view.frame.maxY + tabBarFrame.height
            }
            self.navigationController!.view.layoutIfNeeded()
        } completion: { _ in
            self.tabBarController?.tabBar.isHidden = true
        }
        

    }
    
  private  func configuers(){
        
        productName.text = model.name
      productPrice.text = "Price : \(model.oldPrice)$"
      productDiscount.text = "Discount : \(model.discount) %"
      finalprice.text = "Final Price : \(model.price)"
        productDescribtion.text = model.discreption
        
        
    }
    
    
   private func regesterCelles(){
        
        imagesCollectionView.register(UINib(nibName: ImagesCollectionViewCell.identifer, bundle: nil), forCellWithReuseIdentifier: ImagesCollectionViewCell.identifer)
        imagesCollectionView.delegate = self
        imagesCollectionView.dataSource = self
        
    }
  
    @IBAction func addToFav(_ sender: Any) {
        
        // true
        inFavorite.toggle()
    // false
        if  inFavorite == true{
             favoriteButton.setImage(UIImage(named: "favorite2"), for: .normal)
       }else{
           
               favoriteButton.setImage(UIImage(named: "unfavorite"), for: .normal)
        }
        APICaller.postProductInFavorite(token: Token.Tokenalready!, productId: model.id) { [weak self] result in
            switch result{
            case .success(let fav):
                print(fav.message)
                
//                if self?.inFavorite == true{
//
//                    NotificationCenter.default.post(name: NSNotification.Name("InFav"), object: nil)
//                   self?.favoriteButton.setImage(UIImage(named: "favorite2"), for: .normal)
//
//                }else{
//                    NotificationCenter.default.post(name: NSNotification.Name("NotInFav"), object: nil)
//                   self?.favoriteButton.setImage(UIImage(named: "unfavorite"), for: .normal)
//
//                }

                let alert = UIAlertController(title: "", message: fav.message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Done", style: .default))
                self?.present(alert, animated: true)
                
               // self?.favoriteButton.setImage(UIImage(named: "favorite2"), for: .normal)
                NotificationCenter.default.post(name: NSNotification.Name("fromFavButton"), object: nil)
            case.failure(let error):
                print(error)
            }
        }
        
    }
    
    @IBAction func addToCart(_ sender: Any) {
         
        addToCartButton.setTitle("", for: .normal)
        activityIndictor.startAnimating()
        
        APICaller.postCarts(token: Token.Tokenalready!, productId: model.id) { [weak self] result in
            switch result{
            case .success(let cart):
                
                 
                self?.addToCartButton.setTitle("DELETE FROM CART", for: .normal)

                self?.activityIndictor.stopAnimating()
                let Alert = UIAlertController(title: "", message: cart.message, preferredStyle: .alert)
                Alert.addAction(UIAlertAction(title: "Done", style: .default))
                self?.present(Alert, animated: true)
                
                if cart.message == "Added Successfully"{
                    self?.addToCartButton.setTitle("DELETE FROM CART", for: .normal)
                     
                }else{
                    self?.addToCartButton.setTitle("ADD TO CART", for: .normal)

                }
                NotificationCenter.default.post(name: NSNotification.Name("FromButton"), object: nil)
               
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    
    

}
extension DetailsViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        if model.images == []{
            return 1
        }else{
            return model.images.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imagesCollectionView.dequeueReusableCell(withReuseIdentifier: ImagesCollectionViewCell.identifer, for: indexPath)as! ImagesCollectionViewCell
 
        if model.images == []{
            guard let url = URL(string: imageCatogries)else{
                 return cell
             }
            cell.imagesProudct.sd_setImage(with: url)
        }else{
            let images = model.images[indexPath.row]

          guard let url = URL(string: images)else{
               return cell
           }
           cell.imagesProudct.sd_setImage(with: url)
           cell.discount = model.discount
           print(model.discount)
           return cell
        }
        
         return cell
    }
 
}



extension DetailsViewController : UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = collectionView.frame.height
        
        return CGSize(width: width / 1.3, height: height)

    }
    
}
