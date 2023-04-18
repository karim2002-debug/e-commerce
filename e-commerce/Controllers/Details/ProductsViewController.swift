//
//  ProductsViewController.swift
//  e-commerce
//
//  Created by Macbook on 22/02/2023.
//

import UIKit
import NVActivityIndicatorView

 
class ProductsViewController: UIViewController {
    
    
    
    
    
    //MARK: VARIBLE
   
     
    var productId : Int!
    var catogeryId : Int!
    var catogeryName : String?
    var productName : String!
    var fromCatgeries : Bool = false
    var isList = false
    var products : [Info] = [Info]()
    var Caroriesproducts : [Catogeries] = [Catogeries]()
    //MARK: OUTLETS
    
    
    @IBOutlet weak var activityIndictor: NVActivityIndicatorView!
    @IBAction func convertingPriceButton(_ sender: Any) {
        
        products.sort(by: { $0.price! < $1.price! })
        Caroriesproducts.sort(by: {$0.price! < $1.price!})
        productCollectionView.reloadData()
    }
    
    
    
    @IBOutlet weak var productCollectionView: UICollectionView!
    
    @IBOutlet weak var gridListButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = catogeryName
        navigationController?.navigationBar.prefersLargeTitles = false
        regesterCells()
        fetchAPI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
      
    }
    
    func fetchAPI(){
        activityIndictor.startAnimating()
        if fromCatgeries{
            APICaller.getCateriosProducts(productName: productName) {[weak self] result in
                switch result{
                case .success(let cart):
                    self?.Caroriesproducts = cart
                    DispatchQueue.main.async {
                        self?.productCollectionView.reloadData()
                    }
                    
                    self?.activityIndictor.stopAnimating()
                case .failure(let error):
                    print(error)
                }
            }
        }else{
            APICaller.getSpesficProduct(catogeryId: catogeryId!) { [weak self] result in
                switch result{
                case .success(let model):
                    self!.products = (model.data?.data)!
                    DispatchQueue.main.async {
                        self?.productCollectionView.reloadData()
                    }
                    self?.activityIndictor.stopAnimating()
                case .failure(let error):
                    print(error)
                }
            }
            
        }
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        handleHideShowTabBar()
    }
    
    
    
    // show TabBar if its hidden
    @objc fileprivate func handleHideShowTabBar() {
        guard let navigationController = self.navigationController else { return }
        guard let tabBarIsHidden = self.tabBarController?.tabBar.isHidden else { return }
        
        if tabBarIsHidden {
            self.tabBarController?.tabBar.isHidden = false
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.7, options: .curveEaseOut) {
                if let tabBarFrame = self.tabBarController?.tabBar.frame {
                    self.tabBarController?.tabBar.frame.origin.y = navigationController.view.frame.maxY - tabBarFrame.height
                }
                navigationController.view.layoutIfNeeded()
            }
        }
    }
    
    
    
    private func regesterCells(){
        productCollectionView.register(UINib(nibName: GridCollectionViewCell.identifer, bundle: nil), forCellWithReuseIdentifier: GridCollectionViewCell.identifer)
        
        productCollectionView.register(UINib(nibName: ListCollectionViewCell.identfier, bundle: nil), forCellWithReuseIdentifier: ListCollectionViewCell.identfier)
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
    }
    
    
    @IBAction func gridListButtonDidTapped(_ sender: Any) {
        
        isList.toggle()
        if isList == true{
            gridListButton.setImage(UIImage(named: "list"), for: .normal)
        }else{
            gridListButton.setImage(UIImage(named: "grid"), for: .normal)
        }
        
        productCollectionView.reloadData()
        
    }
    
    
}


extension ProductsViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if fromCatgeries{
            return Caroriesproducts.count
        }else{
            return products.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        if isList == true {
            
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCollectionViewCell.identfier, for: indexPath)as!ListCollectionViewCell
             if fromCatgeries{
                let catories = Caroriesproducts[indexPath.row]
                
                let productViewModel = ProductViewModel(id: catories.id ?? 0, name: catories.title ?? "Not", image: catories.image ?? "", description: catories.descrebtion ?? "", price: String(catories.price ?? 0), discount: 0, inFavorute: false)
                cell.configure(with: productViewModel)
                
                return cell
            }else{
                let data = products[indexPath.row]
               // cell.inFavourite = data.in_favorites

                guard data.name != nil , data.price != nil, data.description != nil , data.image != nil else{
                    return UICollectionViewCell()
                }
                let productModel = ProductViewModel(id: data.id ?? 0, name: data.name ?? "Not", image: data.image ?? "", description: data.description ?? "", price: String(data.price ?? 0), discount: data.discount ?? 0, inFavorute: data.in_favorites ?? false)
                cell.configure(with: productModel)
                cell.productId = productModel.id
                cell.inFavourit = false
                 return cell
            }
        }else{
            
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GridCollectionViewCell.identifer, for: indexPath)as!GridCollectionViewCell
            
            if fromCatgeries{
                let catories = Caroriesproducts[indexPath.row]
                let productViewModel = ProductViewModel(id: catories.id ?? 0, name: catories.title ?? "Not", image: catories.image ?? "", description: catories.descrebtion ?? "", price: String(catories.price ?? 0), discount: 0, inFavorute: false)
                
                cell.configuer(with: productViewModel)
                
                
                return cell
            }
            let data = products[indexPath.row]
            
            guard data.name != nil , data.price != nil, data.description != nil , data.image != nil else{
                return UICollectionViewCell()
            }
            let productModel = ProductViewModel(id: data.id ?? 0, name: data.name ?? "Not", image: data.image ?? "", description: data.description ?? "", price: String(data.price ?? 0), discount: data.discount ?? 0, inFavorute: data.in_favorites ?? false)
        
            //cell.configure(with: productModel)
            cell.configuer(with: productModel)
            return cell
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        if fromCatgeries{
            
            let data = Caroriesproducts[indexPath.row]
            
            let productDetailsViewModel = ProductsDetailsViewModel(id: data.id ?? 0, name:  data.title ?? "Not", images: [] , discreption: data.descrebtion ?? "", price: Float(data.price ?? 0), discount: 0 , oldPrice: Float(data.price ?? 0))
            
            let vc = DetailsViewController()
            vc.model = productDetailsViewModel
            vc.imageCatogries = data.image
            navigationController?.pushViewController(vc, animated: true)
        }else{
            let data = products[indexPath.row]
            
           
            let productDetailsViewModel = ProductsDetailsViewModel(id: data.id ?? 0, name:  data.name ?? "Not", images: data.images ?? [], discreption: data.description ?? "", price: Float(data.price ?? 0), discount: Float(data.discount ?? 0), oldPrice: Float(data.old_price ?? 0))
            let vc = DetailsViewController()
          
            vc.model = productDetailsViewModel
            
//            vc.delegete?.getProductId(productId:productDetailsViewModel.id)
            vc.inFavorite = data.in_favorites!
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    
}
extension ProductsViewController : UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = collectionView.frame.height
        
        if isList == true{
            return CGSize(width: width, height: height / 3)
        }else{
            return CGSize(width: width/2, height: height / 2)
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if isList == false{
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right:  0)
        }
        return UIEdgeInsets.zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {

        if isList == false{
            return 0

        }
        return 0
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    
    
}

