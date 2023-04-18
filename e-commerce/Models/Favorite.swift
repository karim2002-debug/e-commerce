//
//  Favorite.swift
//  e-commerce
//
//  Created by Macbook on 01/03/2023.
//

import Foundation
import UIKit

struct Favorite : Codable{
    
    var status : Bool
    var message : String
    var data : Favoruit
}

struct Favoruit : Codable {
    
    var id : Int
    var product : Info
}
/*
 "status": true,
    "message": "تمت الإضافة بنجاح",
    "data": {
        "id": 124336,
        "product": {
            "id": 55,
            "price": 44500,
            "old_price": 44500,
            "discount": 0,
            "image": "https://student.valuxapps.com/storage/uploads/products/1615442168bVx52.item_XXL_36581132_143760083.jpeg"
        }
    }
}
 
 */
