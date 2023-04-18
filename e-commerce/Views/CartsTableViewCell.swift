//
//  CartsTableViewCell.swift
//  e-commerce
//
//  Created by Macbook on 25/02/2023.
//

import UIKit
import NVActivityIndicatorView

protocol Presention{
    func presention(cart : String)
}

class CartsTableViewCell: UITableViewCell {

    
    var delegete : Presention!
    static let identifer = "CartsTableViewCell"
    //MARK: VARIBLE
    var cartProducts : CartViewModel!
    var cardId : Int!
    var productId : Int!
    var quentity : Int!
    //MARK: OUTLETS
    
    
    @IBOutlet weak var activityIndictor: NVActivityIndicatorView!
    @IBOutlet weak var decreaseButton: UIButton!
    @IBOutlet weak var increaseButton: UIButton!
    @IBOutlet weak var cartquentity: UILabel!
    @IBOutlet weak var cartName: UILabel!
    @IBOutlet weak var cartImage: UIImageView!
    @IBOutlet weak var cartPricw: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        //configer()
//        cartName.text = cartProducts.name
//        let url = URL(string: cartProducts.image)
//        cartImage.sd_setImage(with: url)
//        cartPricw.text = "\(cartProducts.price)"
        
     //   cartquentity.text = String(counter)

    }


    
  
    var counter  : Int = 1

    
    @IBAction func increaseItems(_ sender: Any) {
    counter = quentity + 1
    cartquentity.text = String(counter)
        activityIndictor.startAnimating()
        increaseButton.isEnabled = false
        APICaller.updateCart(token: Token.Tokenalready!, quantity: counter, cartId: cardId) { [weak self] result in
            switch result{
              
            case .success(let car):
               
                NotificationCenter.default.post(name: NSNotification.Name("fromIncrease"), object: nil)
                self?.cartquentity.text = String(car.data?.cart?.quantity ?? 0)
               self?.increaseButton.isEnabled = true
                self?.activityIndictor.stopAnimating()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @IBAction func decreaseItems(_ sender: Any) {
        
        counter = quentity - 1
        cartquentity.text = String(counter)
        decreaseButton.isEnabled = false
        activityIndictor.startAnimating()

        APICaller.updateCart(token: Token.Tokenalready!, quantity: counter, cartId: cardId) { [weak self] result in
            switch result{
            case .success(let car):
                
                NotificationCenter.default.post(name: NSNotification.Name("fromDecrease"), object: nil)
                self?.decreaseButton.isEnabled = true

                self?.cartquentity.text = String(car.data?.cart?.quantity ?? 0)
                self?.activityIndictor.stopAnimating()
            case .failure(let error):
                print(error)
            }

        }
    }
    
    
    
    @IBAction func deleteButton(_ sender: Any) {
        activityIndictor.startAnimating()

        APICaller.postCarts(token: Token.Tokenalready!, productId: productId) { [weak self] result in
            switch result{
            case .success(let cart):
                self?.delegete.presention(cart: cart.message!)
                self?.activityIndictor.stopAnimating()

            case .failure(let error):
                print(error)
            }
            NotificationCenter.default.post(name: NSNotification.Name("fromDeleteButton"), object: nil)
        }
    }
    
    func configer(){
        cartName.text = cartProducts.name
        let url = URL(string: cartProducts.image)
        cartImage.sd_setImage(with: url)
        cartPricw.text = "\(cartProducts.price)"
    }
    
}
