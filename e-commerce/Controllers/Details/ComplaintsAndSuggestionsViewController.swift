//
//  ComplaintsAndSuggestionsViewController.swift
//  e-commerce
//
//  Created by Macbook on 09/03/2023.
//

import UIKit
import TextFieldEffects
import NVActivityIndicatorView
import SDWebImage
class ComplaintsAndSuggestionsViewController: UIViewController {
    
    //MARK: VARIBLE
        
    var contactList : Contact?
    //MARK: OUTLETS
    @IBOutlet weak var contactUsCollectionView: UICollectionView!
    
    @IBOutlet weak var activityIndictor: NVActivityIndicatorView!
    @IBOutlet weak var userEmail: YoshikoTextField!
    
    @IBOutlet weak var userPhone: YoshikoTextField!
    @IBOutlet weak var userName: YoshikoTextField!
    @IBOutlet weak var userMessage: UITextView!
    @IBOutlet weak var comlaintsButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Complaints"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .label
         comlaintsButton.applyTheMainButtonDesign()
        hideTabBar()
        fetchContactListAPI()
        registerCell()
    }

    private func registerCell(){
        contactUsCollectionView.register(UINib(nibName:ContactsCollectionViewCell.idenifier, bundle: nil), forCellWithReuseIdentifier: ContactsCollectionViewCell.idenifier)
        contactUsCollectionView.delegate = self
        contactUsCollectionView.dataSource = self
        
    }
    
    
    func fetchContactListAPI(){
        
        APICaller.getContactsInfo { result in
            switch result{
            case .success(let contactsInfo):
                self.contactList = contactsInfo.data
                DispatchQueue.main.async {
                    self.contactUsCollectionView.reloadData()
                }
                print(self.contactList)
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
   
    @IBAction func submetcComplaints(_ sender: Any) {
        activityIndictor.startAnimating()
        comlaintsButton.setTitle("", for: .normal)
        APICaller.ComplaintsAandSuggestions(name: userName.text!, phone: userPhone.text!, email: userEmail.text!, message: userMessage.text!) { [ weak self] result in
            switch result{
            case .success(let message):
                let alert = UIAlertController(title: "", message: message.message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Done", style: .default))
                self?.present(alert, animated: true)
                self?.activityIndictor.stopAnimating()
                self?.comlaintsButton.setTitle("SUBMET", for: .normal)

            case .failure(let error):
                print(error)
            }
        }
    }
    
}

extension ComplaintsAndSuggestionsViewController : UICollectionViewDelegate,UICollectionViewDataSource{


    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contactList?.data?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContactsCollectionViewCell.idenifier, for: indexPath)as! ContactsCollectionViewCell
        let data = contactList?.data![indexPath.row].image
        let url = URL(string: data!)
        
        cell.ContactImage.sd_setImage(with: url)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = contactList?.data![indexPath.row].value
        UIApplication.shared.open(URL(string: data!)!as! URL , options: [:],completionHandler: nil)
 
    }
    
    
}
extension ComplaintsAndSuggestionsViewController : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.height
        let width =  collectionView.frame.width
        
        return CGSize(width: width / 4 , height: height / 1.2)
    }
    
}
