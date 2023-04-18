//
//  CardView.swift
//  e-commerce
//
//  Created by Macbook on 22/02/2023.
//

import Foundation
import UIKit
class CardView : UIView{
    
    
    @IBInspectable var cornerReduis:  CGFloat = 8
    @IBInspectable var shadowOffestWidth : CGFloat = 2
    @IBInspectable var shadowOffestHeight : CGFloat = 3
    @IBInspectable var shadowOpticty : CGFloat = 0.5
    @IBInspectable var shadowColor : UIColor = .lightGray
    @IBInspectable var borderWidth : CGFloat = 0
    @IBInspectable var borderColor : UIColor?

    
    override func layoutSubviews() {
        layer.cornerRadius = cornerReduis
        layer.shadowOpacity = Float(shadowOpticty)
        layer.shadowOffset = CGSize(width: shadowOffestWidth, height: shadowOffestHeight)
        layer.shadowOpacity = Float(shadowOpticty)
        layer.shadowColor = shadowColor.cgColor
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerReduis)
        layer.shadowPath = shadowPath.cgPath
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor?.cgColor
    }
    
    
    
}
