//
//  ShopViewController.swift
//  e-commerce
//
//  Created by Macbook on 20/02/2023.
//

import UIKit
import NVActivityIndicatorView

struct Catgries{
   
    var imagies : [UIImage]
    
}


class ShopViewController: UIViewController {

    
    
     //MARK: VARIBLE
    var catories : [String] = [String]()
    var imagies : [UIImage] = [UIImage]()
    
    //MARK: OUTLETS
    
    
    @IBOutlet weak var activityIndictor: NVActivityIndicatorView!
    @IBOutlet weak var catogriesTableViewView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Categories"
        
        imagies.append(UIImage(named: "electronic-devices")!)
        imagies.append(UIImage(named: "jewlary")!)
        imagies.append(UIImage(named: "mens")!)
        imagies.append(UIImage(named: "women's clothing")!)

        
        
        getCatoriesAPI()
        
        
        registerCell()
     }
    
    
    func getCatoriesAPI(){
        
        activityIndictor.startAnimating()
        APICaller.getCatories { [weak self] result in
            switch result{
            case .success(let catories):
                self?.catories = catories
                self?.catogriesTableViewView.reloadData()
                self?.activityIndictor.stopAnimating()
            case .failure(let error):
                print(error)
            }
        }
        
    }

    func registerCell(){
        catogriesTableViewView.register(UINib(nibName: CategeryTableViewCell.identifer, bundle: nil), forCellReuseIdentifier: CategeryTableViewCell.identifer)
        
        catogriesTableViewView.dataSource = self
        catogriesTableViewView.delegate = self
        
    }
  

}
extension ShopViewController : UITableViewDelegate,UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return catories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategeryTableViewCell.identifer, for: indexPath)as! CategeryTableViewCell
        var data = catories[indexPath.row]
        var dataIamge = imagies[indexPath.row]
        
        cell.Catogeryimage.image = dataIamge
        let CatogeryViewModel = CatogeryViewModel(name: data)
        cell.configuer(with:CatogeryViewModel)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ProductsViewController()
        vc.productName = catories[indexPath.row]
        print("prod",vc.productName)
        vc.fromCatgeries = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
}
