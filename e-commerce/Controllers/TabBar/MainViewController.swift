//
//  MainViewController.swift
//  e-commerce
//
//  Created by Macbook on 20/02/2023.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
        let vc1 = UINavigationController(rootViewController: HomeViewController())
        let vc2 = UINavigationController(rootViewController: SearchViewController())
        let vc3 = UINavigationController(rootViewController: ShopViewController())
        let vc4 = UINavigationController(rootViewController: FavouriteViewController())
        let vc5 = UINavigationController(rootViewController: ProfileViewController())
        let vc6 = UINavigationController(rootViewController: PagViewController())
        let vc7 = UINavigationController(rootViewController: AboutUsViewController())

        vc1.title = "Home"
        vc2.title = "Search"
        vc3.title = "Shop"
        vc4.title = "Favorites"
        vc5.title = "Profile"
        vc6.title = "Bag"
        vc7.title = "About"
        
        vc1.tabBarItem.image = UIImage(systemName: "house.fill")
        vc2.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        vc3.tabBarItem.image = UIImage(systemName: "cart.fill")
        vc4.tabBarItem.image = UIImage(systemName: "heart.fill")
        vc5.tabBarItem.image = UIImage(systemName: "person.fill")
        vc6.tabBarItem.image = UIImage(named: "shopping-bag")
        vc7.tabBarItem.image = UIImage(named: "shopping-bag")

        
        
        tabBar.tintColor = UIColor(named: "general")

        setViewControllers([vc1,vc2,vc3,vc6,vc5,vc4,vc7], animated: true)
       
    }
    
 
}
