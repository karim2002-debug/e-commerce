//
//  ChangePasswordViewController.swift
//  e-commerce
//
//  Created by Macbook on 09/03/2023.
//

import UIKit
import TextFieldEffects
import NVActivityIndicatorView

class ChangePasswordViewController: UIViewController {

    @IBOutlet weak var activityIndcator: NVActivityIndicatorView!
    @IBOutlet weak var newPasswordTextField: YoshikoTextField!
    @IBOutlet weak var oldPasswordTextField: YoshikoTextField!
    @IBOutlet weak var changePasswordButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        changePasswordButton.applyTheMainButtonDesign()
     
      }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIView.animate(withDuration: 0.2) {
            
            self.view.backgroundColor = .black.withAlphaComponent(0.3)
        }
       

    }
    
  

    
    @IBAction func screenDissmis(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func closeButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func savePassword(_ sender: Any) {
        activityIndcator.startAnimating()
        changePasswordButton.setTitle("", for: .normal)
        APICaller.changePassword(token: Token.Tokenalready!, newPassword: newPasswordTextField.text!, currentPassword: oldPasswordTextField.text!) { [weak self]result in
            switch result{
            case .success(let password):
                let alert = UIAlertController(title: "", message: password.message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Done", style: .default))
                self?.present(alert , animated: true)
                self?.activityIndcator.stopAnimating()
                self?.changePasswordButton.setTitle("SAVE PASSWORD", for: .normal)
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
}
