//
//  SearchResultsViewController.swift
//  e-commerce
//
//  Created by Macbook on 24/02/2023.
//

import UIKit

protocol MovingToDetails {
    func moveTodetails(model : ProductsDetailsViewModel)
}



class SearchResultsViewController: UIViewController {

     
    var delegte : MovingToDetails!
    var searchList : [Info] =   [Info]()
    
    @IBOutlet weak var searchListcollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        registerCell()
        
    }

    func registerCell(){
        
        searchListcollectionView.register(UINib(nibName: GridCollectionViewCell.identifer, bundle: nil), forCellWithReuseIdentifier: GridCollectionViewCell.identifer)
        
        searchListcollectionView.delegate = self
        searchListcollectionView.dataSource = self
        
    }
     

}
extension SearchResultsViewController : UICollectionViewDelegate,UICollectionViewDataSource{
     
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GridCollectionViewCell.identifer, for: indexPath)as! GridCollectionViewCell
        let data = searchList[indexPath.row]
        let productViewModel =  ProductViewModel(id: data.id ?? 0, name: data.name ?? "", image: data.image ?? "", description: data.description ?? "" , price: String(data.price ?? 0), discount: data.discount ?? 0, inFavorute: data.in_favorites ?? false)
        cell.configuer(with: productViewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = searchList[indexPath.row]
        print("Discount = ",data.discount)
        print("price = ",data.price)

        let productViewModel = ProductsDetailsViewModel(id: data.id ?? 0, name: data.name ?? "", images: data.images ?? [], discreption: data.description ?? "", price: Float(data.price ?? 0), discount: Float(data.discount ?? 0), oldPrice: Float(data.old_price ?? 0))
        delegte.moveTodetails(model: productViewModel)
    }
    
}
extension SearchResultsViewController : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = collectionView.frame.height
        
       return CGSize(width: width / 2.1, height: height / 2.2)
    }
    
}
