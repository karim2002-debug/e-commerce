//
//  UpdateViewController.swift
//  e-commerce
//
//  Created by Macbook on 09/03/2023.
//

import UIKit

class SittingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Sitting"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationController?.navigationBar.tintColor = .label
        
    }


    @IBAction func personalInfo(_ sender: Any) {
        
        let vc = UpdatePersonalProfileViewController()
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func password(_ sender: Any) {
        let vc = ChangePasswordViewController()
        vc.modalPresentationStyle =  .overCurrentContext
       present(vc, animated: true)
    }
}
