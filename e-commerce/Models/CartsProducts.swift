//
//  CartsProducts.swift
//  e-commerce
//
//  Created by Macbook on 25/02/2023.
//

import Foundation
import UIKit

struct CartsProducts : Codable{
    
    var status : Bool?
    var message : String?
    var data : CartsItem
    
 }

struct CartsItem : Codable{
    
    var cart_items : [CartsArr]
    var sub_total : Double?
    var total : Double?
}

struct CartsArr: Codable {
    let id, quantity: Int
    let product: Products
}

struct Products : Codable {
    
    var id : Int?
    var price : Double?
    var old_price : Double?
    var discount : Double?
    var image : String?
    var name : String?
    var description : String?
    var images : [String]?
    var in_favorites : Bool?
    var in_cart : Bool?
}

/*"status": true,
 "message": null,
 "data": {
     "cart_items": [
         {
             "id": 29139,
             "quantity": 1,
             "product": {
                 "id": 84,
                 "price": 1606.5,
                 "old_price": 1606.5,
                 "discount": 0,
                 "image": "https://student.valuxapps.com/storage/uploads/products/1638737146iLO2c.11.jpg",
                 "name": "حذاء رياضي للتمرين شبكي للنساء فليكس اسينشيال من نايكي - ابيض",
                 "description": "يتميز حذاء التمرين فليكس اسينشيال من نايكي للنساء بجزء علوي خفيف الوزن مصنوع من نسيج شبكي مزود بمسامات للتهوية مع نعل داعم مصمم بشكل مميز لتوفير مرونة الحركة في أي اتجاه. فهو حذاء مثالي للارتداء أثناء أداء التمارين الرياضية اليومية في أي مكان.\r\nجزء علوي من نسيج شبكي صناعي خفيف لتوفير التهوية للقدمين.\r\nنعل أوسط مبطن من الفوم خفيف الوزن لتوفير الراحة عند الارتداء .\r\nأجزاء متينة مصنوعة من المطاط لسهولة الحركة.\r\nفتحات مرنة بالنعل الخارجي لسهولة حركة القدم.\r\nالموديل: 924344-100",
                 "images": [
                     "https://student.valuxapps.com/storage/uploads/products/1638737146HIHWT.11.jpg",
                     "https://student.valuxapps.com/storage/uploads/products/1638737146A41I6.12.jpg",
                     "https://student.valuxapps.com/storage/uploads/products/1638737146CTmMi.13.jpg",
                     "https://student.valuxapps.com/storage/uploads/products/1638737146P2XeK.14.jpg",
                     "https://student.valuxapps.com/storage/uploads/products/1638737146vpmnS.15.jpg",
                     "https://student.valuxapps.com/storage/uploads/products/1638737146fgAq5.16.jpg"
                 ],
                 "in_favorites": false,
                 "in_cart": true
             }
         },
 */
