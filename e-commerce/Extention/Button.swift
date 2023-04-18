//
//  Button.swift
//  e-commerce
//
//  Created by Macbook on 03/03/2023.
//

import Foundation
import UIKit

extension UIButton{
    
    func applyTheMainButtonDesign(){
        
        backgroundColor = UIColor(named: "general")
        layer.cornerRadius = 25
        titleLabel?.font = .systemFont(ofSize: 17)
        titleLabel?.textColor = .white
        titleLabel?.tintColor = .white
        NSLayoutConstraint.activate([])
        NSLayoutConstraint.activate([heightAnchor.constraint(equalToConstant: 60)])
        
    }
    
    
}
