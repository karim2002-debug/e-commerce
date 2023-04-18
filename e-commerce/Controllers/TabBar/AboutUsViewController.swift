//
//  AboutUsViewController.swift
//  e-commerce
//
//  Created by Macbook on 10/03/2023.
//

import UIKit

class AboutUsViewController: UIViewController {

    @IBOutlet weak var aboutLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "About Us"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .label
        APICaller.aboutUs { [weak self] result in
            switch result{
            case .success(let aboutUs):
                self?.aboutLabel.text = aboutUs.data?.about
            case .failure(let error):
                print(error)
            }
        }
    }


   

}
