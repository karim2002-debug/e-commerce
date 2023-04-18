//
//  UpdataCart.swift
//  e-commerce
//
//  Created by Macbook on 28/02/2023.
//

import Foundation
import UIKit
//struct UpdataCart : Codable{
//
//    var status : Bool?
//    var message : String?
//    var data : Cart?
//
//}
//struct Cart : Codable{
//
//    var cart : CartInformation?
//    var sub_total : Double?
//    var total : Double?
//}
//
//struct CartInformation : Codable{
//    var id : Int?
//    var quantity : Int?
//    var product : ProductInf?
//}
//
//struct ProductInf : Codable{
//
//    var id : Int?
//    var price : Double?
//    var old_price  : Double?
//    var discount : Double?
//    var image : String?
//}
/*"status": true,
 "message": "تم التعديل بنجاح",
 "data": {
     "cart": {
         "id": 29213,
         "quantity": 5,
         "product": {
             "id": 54,
             "price": 11499,
             "old_price": 12499,
             "discount": 8,
             "image": "https://student.valuxapps.com/storage/uploads/products/1615441020ydvqD.item_XXL_51889566_32a329591e022.jpeg"
         }
     },
     "sub_total": 58524,
     "total": 58524
 }
}*/
struct Cart: Codable {
    let status: Bool
    let message: String
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    let cart: CartClass?
    let sub_total, total: Int?

//    enum CodingKeys: String, CodingKey {
//        case cart
//        case subTotal = "sub_total"
//        case total
//    }
}

// MARK: - CartClass
struct CartClass: Codable {
    let id, quantity: Int?
    let product: Productinf?
}

// MARK: - Product
struct Productinf: Codable {
    let id, price, old_price, discount: Double?
    let image: String?

//    enum CodingKeys: String, CodingKey {
//        case id, price
//        case oldPrice = "old_price"
//        case discount, image
//    }
}
