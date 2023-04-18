//
//  ProfileViewController.swift
//  e-commerce
//
//  Created by Macbook on 20/02/2023.
//

import UIKit
import SDWebImage
import NVActivityIndicatorView
struct UserInfo{
    
    var main : String
    var desc : String
    
}

class ProfileViewController: UIViewController {
    var countCart : Int!
    var userInfo : [UserInfo] = [
        .init(main: "My order", desc: ""),
        .init(main: "My saved", desc: ""),
        .init(main: "Sitting", desc: "Updete profile,change password"),
        .init(main: "Complaints and suggestions", desc: "help us to improve our sevices")

    ]
    
    
    @IBOutlet weak var activityIndictor: NVActivityIndicatorView!
    @IBOutlet weak var profileTableView: UITableView!
 
   @IBOutlet weak var nameLabel: UILabel!
   @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var userPhone: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        navigationController?.navigationBar.prefersLargeTitles = true
        fetchAPI()
        fetchAPICarts()
        fetchNoficationCenter()
        registerCell()
        fetchAPIFavourite()

   
     }
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        handleHideShowTabBar()
    }
    func fetchNoficationCenter(){
        
        NotificationCenter.default.addObserver(forName:  NSNotification.Name("fromFavButton"), object: nil, queue: nil) {  _ in
            self.fetchAPIFavourite()
        }
        //DidTappedFromCell
        NotificationCenter.default.addObserver(forName:  NSNotification.Name("DidTappedFromCell"), object: nil, queue: nil) {  _ in
            self.fetchAPIFavourite()
        }
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name("fromDeleteButton"), object: nil, queue: nil) { _  in
            self.fetchAPICarts()
        }
        NotificationCenter.default.addObserver(forName: NSNotification.Name("FromButton"), object: nil, queue: nil) { _ in
            self.fetchAPICarts()
        }
        
        // fromUpdateing
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name("updateProfile"), object: nil, queue: nil) { _ in
            self.fetchAPI()
        }
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
    
    
   private func registerCell(){
        profileTableView.register(UINib(nibName: ProfileTableViewCell.identfier, bundle: nil), forCellReuseIdentifier: ProfileTableViewCell.identfier)
        profileTableView.delegate = self
        profileTableView.dataSource = self
    }
    
    
    func fetchAPI(){
        activityIndictor.startAnimating()
        APICaller.getProfileInfo(token: Token.Tokenalready!) { [weak self] result in
            switch result{
            case .success(let userInfo):
                self?.configure(with: userInfo)
                self?.activityIndictor.stopAnimating()
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    
        // make it in pageViewController
    //Or make view model
    func configure(with model : Login){
        
        nameLabel.text = model.data?.name
        userEmail.text = model.data?.email
        userPhone.text = model.data?.phone
        print(model.data?.image)
        guard let url = URL(string: (model.data?.image)!)else{
            userImage.image = UIImage(systemName: "person")
            return
        }
        userImage.sd_setImage(with: url)
      
    }
    
    func fetchAPICarts(){
        
        APICaller.getCartsProducts(token: Token.Tokenalready!) { [weak self] result in
            switch result{
                
            case .success(let itemsCount):
                self?.userInfo[0].desc = "Already have \(itemsCount.data.cart_items.count) items"
                DispatchQueue.main.async {
                    self?.profileTableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
            
            
        }
    }
    func fetchAPIFavourite(){
        APICaller.getProductdInFavourite(token: Token.Tokenalready!) { [weak self] result in
            switch result{
                
            case .success(let itemsCount):
                self?.userInfo[1].desc = "Already have \((itemsCount.data?.data?.count)!) items"
                DispatchQueue.main.async {
                    self?.profileTableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    
    @IBAction func cartButton(_ sender: Any) {
        
        let vc = PagViewController()
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}
extension ProfileViewController : UITableViewDelegate,UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identfier, for: indexPath)as! ProfileTableViewCell
        
        cell.mainLabel.text = userInfo[indexPath.row].main
        cell.descLabel.text = userInfo[indexPath.row].desc

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        switch indexPath.row{

        case 0:
            let vc = PagViewController()
            vc.fromProfile = true
            navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = FavouriteViewController()
            vc.fromProfile = true
            navigationController?.pushViewController(vc, animated: true)

        case 2:
            let vc = SittingViewController()
            navigationController?.pushViewController(vc, animated: true)

        case 3:
            let vc = ComplaintsAndSuggestionsViewController()
            navigationController?.pushViewController(vc, animated: true)

        default:
            return
        }
        
        
    
    }
}
