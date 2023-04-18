//
//  PagViewController.swift
//  e-commerce
//
//  Created by Macbook on 25/02/2023.
//

import UIKit
import NVActivityIndicatorView
 

 
class PagViewController: UIViewController {
    
    
    var fromProfile : Bool?
    
 var cartsProduct : [CartsArr] = [CartsArr]()
    var totalPrice : Double!
    
  
    
    @IBOutlet weak var activtyIndictor: NVActivityIndicatorView!
    @IBOutlet weak var pagtableView: UITableView!
    
    
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var buyButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAPI()
        registerCell()
        
        buyButton.applyTheMainButtonDesign()
        title = "My Bag"
        navigationController?.navigationBar.prefersLargeTitles = true
      //  hideTabBar()
        fetchNofification()
        
        if fromProfile == true{
            hideTabBar()
        }
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
    
    func fetchNofification(){
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name("FromButton"), object: nil, queue: nil) { _ in
            self.fetchAPI()
        }
        NotificationCenter.default.addObserver(forName: NSNotification.Name("fromDeleteButton"), object: nil, queue: nil) { _  in
            self.fetchAPI()
        }
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name("fromIncrease"), object: nil, queue: nil) { _  in
            self.fetchAPI()
        }
        NotificationCenter.default.addObserver(forName: NSNotification.Name("fromDecrease"), object: nil, queue: nil) { _  in
            self.fetchAPI()
        }
        

    }
    
    
 
    func fetchAPI(){
        activtyIndictor.startAnimating()
        APICaller.getCartsProducts(token: Token.Tokenalready!) { [weak self] result in
          
            switch result{
            case .success(let carts):
                self?.totalPrice = carts.data.total
                self?.totalLabel.text = "\(self?.totalPrice! ?? 0) $"
                self?.cartsProduct = carts.data.cart_items
                self?.pagtableView.reloadData()
                self?.activtyIndictor.stopAnimating()

            case .failure(let error):
                print(error)
            }
        }

    }

    func registerCell(){
        pagtableView.register(UINib(nibName: CartsTableViewCell.identifer, bundle: nil), forCellReuseIdentifier: CartsTableViewCell.identifer)
        pagtableView.delegate = self
        pagtableView.dataSource = self
    }

    @IBAction func BuyButton(_ sender: Any) {
    }
    
}
extension PagViewController : UITableViewDelegate,UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartsProduct.count
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CartsTableViewCell.identifer, for: indexPath)as! CartsTableViewCell
 
        cell.delegete = self
        let data = cartsProduct[indexPath.row]
        cell.cardId = data.id
       cell.cartName.text = data.product.name
        cell.cartImage.sd_setImage(with: URL(string: data.product.image!))
        cell.cartPricw.text = "\(data.product.price!)$"
        cell.productId = data.product.id
        let cartViewModel =  CartViewModel(image: data.product.image!, name: data.product.name!, price: data.product.price!, count: 0)
        cell.cartProducts = cartViewModel
        cell.cartquentity.text = String(data.quantity)
        cell.quentity = data.quantity
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    
    
    
    
}
extension PagViewController : Presention{
    
    
    func presention(cart: String) {
        let alert = UIAlertController(title: "", message: cart, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Done", style: .default))
        present(alert, animated: true)
    }
    
    
    
    
}
