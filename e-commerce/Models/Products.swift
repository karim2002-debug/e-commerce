//
//  Products.swift
//  e-commerce
//
//  Created by Macbook on 22/02/2023.
//

import Foundation
import UIKit


struct Infromation :Codable{
    
    var current_page : Int?
    var data : Product?
    
}

struct Product : Codable{
    
    var data : [Info]?
    
}

struct Info : Codable{
    
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
/*
 {
     "status": true,
     "message": null,
     "data": {
         "current_page": 1,
         "data": [
             {
                 "id": 80,
                 "price": 45,
                 "old_price": 45,
                 "discount": 0,
                 "image": "https://student.valuxapps.com/storage/uploads/products/1638734223uyATp.1.jpg",
                 "name": "كمامة لحماية الوجه، 50 قطعة - ازرق فاتح بأستك و دعامة",
                 "description": "العلامة التجارية : اخرى\r\nهل يتطلب هذا المنتج بطارية او يحتوي بطارية : لا\r\nهل هذا المنتج خطير أو يحتوي على مواد خطرة، سامة أو نفايات خاضعة لأنظمة تتعلق بالنقل، التخزين وأو التخلص منها؟ : لا\r\nالنوع : اقنعة حماية",
                 "images": [
                     "https://student.valuxapps.com/storage/uploads/products/1638734223zeTvx.1.jpg",
                     "https://student.valuxapps.com/storage/uploads/products/1638734223mvH7B.2.jpg"
                 ],
                 "in_favorites": false,
                 "in_cart": false
             },
             {
                 "id": 81,
                 "price": 50.25,
                 "old_price": 70,
                 "discount": 28,
                 "image": "https://student.valuxapps.com/storage/uploads/products/1638734575kfKn8.21.jpg",
                 "name": "كمامة طبية بحلقات اذن ناعمة ومرنة من ايفوني، 50 قطعة",
                 "description": "سهلة الارتداء\r\nمناسبة للاستعمال مرة واحدة\r\nصُنعت في مصر",
                 "images": [
                     "https://student.valuxapps.com/storage/uploads/products/1638734575Qcgiu.21.jpg",
                     "https://student.valuxapps.com/storage/uploads/products/1638734575rm6Mx.22.jpg",
                     "https://student.valuxapps.com/storage/uploads/products/1638734575FZ3NW.23.jpg",
                     "https://student.valuxapps.com/storage/uploads/products/1638734575S5MLu.24.jpg"
                 ],
                 "in_favorites": false,
                 "in_cart": false
             }
         ],
 
 */
