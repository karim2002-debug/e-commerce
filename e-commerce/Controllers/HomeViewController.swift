//
//  HomeViewController.swift
//  e-commerce
//
//  Created by Macbook on 20/02/2023.
//

import UIKit
import Alamofire
import NVActivityIndicatorView

class HomeViewController: UIViewController {

    
    
    //MARK: VAR

    var mainProducts : [Dataum] = [Dataum]()
    
    //MARK: OUTLETS
    
    
    @IBOutlet weak var activityIndictor: NVActivityIndicatorView!
    
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Token.Tokenalready)

   
        navigationController?.navigationBar.tintColor = .label
        
        navigationController?.navigationBar.prefersLargeTitles = false
 
         regesterCells()
        fetchAPI()
        
    
     }
    
     
    func fetchAPI(){
        activityIndictor.startAnimating()
        APICaller.getMainProducts { [weak self] result in
            switch result{
            case .success(let model):
                self?.mainProducts = model.data!.data
                print("model.data!.data = ",model.data!.data)
                self?.mainCollectionView.reloadData()
                self?.activityIndictor.stopAnimating()
            case .failure(let error):
                print(error)
            }
        }
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false

    }
    

    @objc func didTappedBarButton(){
        print("Done")
        
        
        
        
        
        let vc = ProfileViewController()
        navigationController?.modalPresentationStyle = .formSheet
        navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    private func regesterCells(){
        mainCollectionView.register(UINib(nibName: HomeCollectionViewCell.identfier, bundle: nil), forCellWithReuseIdentifier: HomeCollectionViewCell.identfier)

         
        mainCollectionView.dataSource = self
        mainCollectionView.delegate = self
    }
 

}

extension HomeViewController : UICollectionViewDelegate,UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identfier, for: indexPath)as! HomeCollectionViewCell
        let data = mainProducts[indexPath.row]
        let titlePreviewModel = MainTitlePreview(productImage: data.image ?? "", productName: data.name ?? "Not")
        cell.configuer(with: titlePreviewModel)
        print("titlePreviewModel",titlePreviewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var data = mainProducts[indexPath.row]
        let vc = ProductsViewController()
        vc.catogeryId = data.id
        vc.catogeryName = data.name
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//
//        // to make navigation Bar hide when you scroll down
//
//        let defualtOffset = view.safeAreaInsets.top
//        let offset = scrollView.contentOffset.y + defualtOffset
//
//
//        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0,  -offset))
//    }
    
}


extension HomeViewController : UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = collectionView.frame.height //- 20
        
        if indexPath.row.isMultiple(of: 3){  //0..3..6
            return CGSize(width: width, height: height / 2)
        }else{
            return CGSize(width: width / 2, height: height / 2)
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    // the space betwwen to over and the above
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
     
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
