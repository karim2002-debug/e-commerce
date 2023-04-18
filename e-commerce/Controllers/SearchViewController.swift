//
//  SearchViewController.swift
//  e-commerce
//
//  Created by Macbook on 24/02/2023.
//

import UIKit
import NVActivityIndicatorView

class SearchViewController: UIViewController{
    
    
    
    //MARK: VARIBLES

    var products : [Info] = [Info]()
    let searchController = UISearchController(searchResultsController: SearchResultsViewController())
    
    
    //MARK: OUTLETS
    
    
    @IBOutlet weak var activityIndictor: NVActivityIndicatorView!
    
    @IBOutlet weak var productCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchController.searchBar.placeholder = "Enter The Product ?"
        navigationItem.searchController = searchController
        navigationController?.navigationBar.tintColor = .label

         searchController.searchResultsUpdater = self
        registerCell()
       getAllProductsAPI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        handleHideShowTabBar()

    }
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
    
    func getAllProductsAPI(){
        
        activityIndictor.startAnimating()
        APICaller.getAllProduct {[weak self] result in
            switch result{
            case .success(let product):
                print("productA",product)
                self?.products = (product.data?.data)!
                DispatchQueue.main.async {
                    self?.productCollectionView.reloadData()

                }
                self?.activityIndictor.stopAnimating()
            case .failure(let error):
                print(error)
            }
        }
    }
    

    private func registerCell(){
        productCollectionView.register(UINib(nibName: GridCollectionViewCell.identifer, bundle: nil), forCellWithReuseIdentifier: GridCollectionViewCell.identifer)
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
    }
    

}
extension SearchViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GridCollectionViewCell.identifer, for: indexPath)as! GridCollectionViewCell
        let data = products[indexPath.row]
        let productViewModel = ProductViewModel.init(id: data.id ?? 0, name: data.name ?? "Not Known", image: data.image ?? "", description: data.description ?? "", price: String(data.price ?? 0) , discount: data.discount ?? 0, inFavorute: data.in_favorites ?? false)
        
        print(productViewModel)
        cell.configuer(with: productViewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = products[indexPath.row]
        let productDetailsViewModel = ProductsDetailsViewModel(id: data.id ?? 0, name:  data.name ?? "Not", images: data.images ?? [], discreption: data.description ?? "", price: Float(data.price ?? 0), discount: Float(data.discount ?? 0), oldPrice: Float(data.old_price ?? 0))
        let vc = DetailsViewController()
        vc.model = productDetailsViewModel
        navigationController?.pushViewController(vc, animated: true)
    }
    
}


extension SearchViewController : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = collectionView.frame.height
        return CGSize(width: width / 2, height: height / 2.4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
       
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right:  0)
         
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {

         
        return 0
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    
}

// TO MAKE SEARCH
extension SearchViewController : UISearchResultsUpdating,MovingToDetails {
    func updateSearchResults(for searchController: UISearchController) {
        
        let searchBar = searchController.searchBar
        
        guard let text = searchBar.text,

                !text.trimmingCharacters(in: .whitespaces).isEmpty,// query != nil
              text.trimmingCharacters(in: .whitespaces).count >= 3, // the character not less than 3
              let resultsController = searchController.searchResultsController as? SearchResultsViewController else{
            return
        }
        
         APICaller.searchProduct(text:text) { result in
            switch result{
            case .success(let product):
                print("test",product.data?.data)
                resultsController.searchList = (product.data?.data)!
                resultsController.searchListcollectionView.reloadData()
            case .failure(let error):
                print(error)
            }
            
        }

        resultsController.delegte = self
        
    }
    
    func moveTodetails(model: ProductsDetailsViewModel) {
        let vc = DetailsViewController()
        vc.model = model
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
