//
//  FavouriteViewController.swift
//  e-commerce
//
//  Created by Macbook on 20/02/2023.
//

import UIKit
import NVActivityIndicatorView

class FavouriteViewController: UIViewController {

    
    //  MARK: VARIBLE
    var fromProfile : Bool?
    var productId : [Productt] = [Productt]()
    var favouriteList : [Productt] = [Productt]()
    var isList = true
    //  MARK: OUTLETS
    
    @IBOutlet weak var activityIndictor: NVActivityIndicatorView!
    @IBOutlet weak var favoriteCollectionView: UICollectionView!
    
    @IBOutlet weak var shownButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         tabBarController?.tabBar.barTintColor = .white
        
        
        title = "My favourite"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .label
        tabBarController?.tabBar.backgroundColor = .systemGray6
        
        
        fetchNotifation()
        fetchAPI()
        registerCells()
        
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
    
    func fetchNotifation(){
        NotificationCenter.default.addObserver(forName:  NSNotification.Name("fromFavButton"), object: nil, queue: nil) {  _ in
            self.fetchAPI()
        }
        //DidTappedFromCell
        NotificationCenter.default.addObserver(forName:  NSNotification.Name("DidTappedFromCell"), object: nil, queue: nil) {  _ in
            self.fetchAPI()
        }
        
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
    
    
    func fetchAPI(){
        activityIndictor.startAnimating()
        APICaller.getProductdInFavourite(token: Token.Tokenalready!) { [weak self] result in
            switch result{
            case .success(let product):
                self?.favouriteList = (product.data?.data)!
                DispatchQueue.main.async {
                    self?.favoriteCollectionView.reloadData()
                }
                self?.activityIndictor.stopAnimating()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func registerCells(){
        favoriteCollectionView.register(UINib(nibName: ListCollectionViewCell.identfier, bundle: nil), forCellWithReuseIdentifier: ListCollectionViewCell.identfier)
        favoriteCollectionView.register(UINib(nibName: GridCollectionViewCell.identifer, bundle: nil), forCellWithReuseIdentifier: GridCollectionViewCell.identifer)
        
        favoriteCollectionView.delegate = self
        favoriteCollectionView.dataSource = self
    }
    @IBAction func sortButton(_ sender: Any) {
        isList.toggle()
        if isList{
            shownButton.setImage(UIImage(named: "list"), for: .normal)
        }else{
            shownButton.setImage(UIImage(named: "grid"), for: .normal)
        }
        favoriteCollectionView.reloadData()
    }
    
    @IBAction func sortedPrice(_ sender: Any) {
        favouriteList.sort(by:{($0.product?.price)! < ($1.product?.price)!})
        favoriteCollectionView.reloadData()
     }
    
    
}
extension FavouriteViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favouriteList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if isList{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCollectionViewCell.identfier, for: indexPath)as! ListCollectionViewCell
            let data = favouriteList[indexPath.row].product
            let productViewModel = ProductViewModel(id: data?.id ?? 0, name: data?.name ?? "", image: data?.image ?? "", description: data?.description ?? "", price: String(data?.price ?? 0), discount: data?.discount ?? 0, inFavorute: data?.in_favorites ?? false)
            cell.productId = productViewModel.id
            cell.configure(with: productViewModel)
            cell.fromFavouriteView = true
            return cell
        }else{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GridCollectionViewCell.identifer, for: indexPath)as! GridCollectionViewCell
            let data = favouriteList[indexPath.row].product
            let productViewModel = ProductViewModel(id: data?.id ?? 0, name: data?.name ?? "", image: data?.image ?? "", description: data?.description ?? "", price: String(data?.price ?? 0), discount: data?.discount ?? 0, inFavorute: data?.in_favorites ?? false)
            cell.configuer(with: productViewModel)
            return cell
        }
        
    }
    
    
}
extension FavouriteViewController : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = collectionView.frame.height
        
        if isList{
            return CGSize(width: width, height: height / 4)
            
        }else{
            return CGSize(width: width / 2.1, height: height / 2.2)
            
        }
    }
    
}
