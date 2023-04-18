//
//  UpdateProfileViewController.swift
//  e-commerce
//
//  Created by Macbook on 06/03/2023.
//

import UIKit
import TextFieldEffects
import NVActivityIndicatorView

class UpdatePersonalProfileViewController: UIViewController {

    @IBOutlet weak var eyeButton: UIButton!
    @IBOutlet weak var activityIndictor: NVActivityIndicatorView!
    
    @IBOutlet weak var nameTextField: YoshikoTextField!
    
    @IBOutlet weak var emailTextField: YoshikoTextField!
    
    @IBOutlet weak var phoneTextField: YoshikoTextField!
    
    @IBOutlet weak var imageTextField: YoshikoTextField!
    
    @IBOutlet weak var currentPasswordTextField: YoshikoTextField!
    
    
    @IBOutlet weak var updateButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
       currentPasswordTextField.isSecureTextEntry = true
        updateButton.applyTheMainButtonDesign()
        
       title = "Update Profile"
        navigationController?.navigationBar.prefersLargeTitles = true
        
    
        
        hideTabBar()
    }
    
    // to make secure when you write password
    var iconAction = true
    @IBAction func iconAction(_ sender: Any) {
        
        if iconAction == true{
            currentPasswordTextField.isSecureTextEntry = true
            eyeButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)

        }else{
            currentPasswordTextField.isSecureTextEntry = false
            eyeButton.setImage(UIImage(systemName: "eye"), for: .normal)

        }
        
        iconAction = !iconAction
    }
    
    
    
    func fetchAPI(){
        activityIndictor.startAnimating()
        self.updateButton.setTitle("", for: .normal)

        print(Token.Tokenalready)
        APICaller.updateProfile(token: Token.Tokenalready!, name: nameTextField.text!, phone: phoneTextField.text!, email: emailTextField.text!, image:imageTextField.text!) { result in
            
            switch result{
            case .success(let updateUser):
                
                let alert = UIAlertController(title: "", message: updateUser.message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Done", style: .default,handler: { _ in
                    self.makeTextFieldEmpty()
                }))
                self.present(alert, animated: true)
                
                NotificationCenter.default.post(name: NSNotification.Name("updateProfile"), object:nil)
                self.activityIndictor.stopAnimating()
                self.updateButton.setTitle("UPDATE", for: .normal)

            case .failure(let error):
                print(error)
            }
        }
      
    }

   
   func hideTabBar(){
       // to hide Tab bar
       UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.7, options: .curveEaseOut) {
           if let tabBarFrame = self.tabBarController?.tabBar.frame {
               self.tabBarController?.tabBar.frame.origin.y = self.navigationController!.view.frame.maxY + tabBarFrame.height
           }
           self.navigationController!.view.layoutIfNeeded()
       } completion: { _ in
           self.tabBarController?.tabBar.isHidden = true
       }
   }

    @IBAction func updateButton(_ sender: Any) {
        print(Token.password)
        if currentPasswordTextField.text == Token.password{
            fetchAPI()
        }else{
            let alert = UIAlertController(title: "", message: "Your current password not correct", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Done", style: .default))
            present(alert, animated: true)
        }
    
        
    }
    
    
    func makeTextFieldEmpty(){
        
        nameTextField.text = ""
        phoneTextField.text = ""
        emailTextField.text = ""
        currentPasswordTextField.text = ""
        imageTextField.text = ""
        
    }
   
   
}
 
