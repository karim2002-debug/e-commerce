//
//  SignUpViewController.swift
//  e-commerce
//
//  Created by Macbook on 02/03/2023.
//

import UIKit
import TextFieldEffects

class SignUpViewController: UIViewController {

    
    //MARK: OUTLETS
    
    @IBOutlet weak var nameTextField: YoshikoTextField!
    
    @IBOutlet weak var phoneTextField: YoshikoTextField!
    
    @IBOutlet weak var emailTextField: YoshikoTextField!
    
    @IBOutlet weak var passwordTextField: YoshikoTextField!
    @IBOutlet weak var signUpButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        title = "Sign up"
        navigationController?.navigationBar.prefersLargeTitles = true
        signUpButton.layer.cornerRadius = 25
     }
    @IBAction func signButton(_ sender: Any) {
        fetchAPI()
    }
    
    func fetchAPI(){
        
        APICaller.SignIn(name: nameTextField.text!, phone: phoneTextField.text!, email: emailTextField.text!, password: passwordTextField.text!) { result in
            switch result{
            case .success(let user):
                if user.data?.token != nil{
                    self.goToBar()
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }

    @IBAction func areadyHaveAcount(_ sender: Any) {
        let vc = LoginViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func goToBar(){
        
        let vc = MainViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }

}
