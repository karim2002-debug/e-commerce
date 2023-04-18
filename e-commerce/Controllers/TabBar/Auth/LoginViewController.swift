//
//  LoginViewController.swift
//  e-commerce
//
//  Created by Macbook on 02/03/2023.
//

import UIKit
import TextFieldEffects

class LoginViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var emailTextFiled: YoshikoTextField!
    
    @IBOutlet weak var passwordTextField: YoshikoTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextFiled.text = "Karimtawfee@gmail.com"
        passwordTextField.text = "123456"
        loginButton.applyTheMainButtonDesign()
        title = "Login"
        navigationController?.navigationBar.prefersLargeTitles = true
      
    }

    @IBAction func loginButton(_ sender: Any) {
        
        APICaller.login(email: emailTextFiled.text!, password: passwordTextField.text!) { result in
            switch result{
            case .success(let userLogin):
                print(userLogin.message)
                
          //      Token.Tokenalready = userLogin.data?.token
                
                if userLogin.data?.token != nil{
                    Token.Tokenalready = userLogin.data?.token
                    self.goToBar()
                }
                let alert = UIAlertController(title: "", message: userLogin.message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Done", style: .default))
                self.present(alert, animated: true)
                
//                let alert = UIAlertController(title: "", message: userLogin.message, preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "Done", style: .default))
//                self.present(alert, animated: true)
//                
            case .failure(let error):
                print(error)
                
            }
        }
    }
    
    
    @IBAction func goToSignPage(_ sender: Any) {
        let vc = SignUpViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func goToBar(){
        
        let vc = MainViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}
 
