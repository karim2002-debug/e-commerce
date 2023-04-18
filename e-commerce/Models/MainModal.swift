//
//  MainModal.swift
//  e-commerce
//
//  Created by Macbook on 21/02/2023.
//

import Foundation
import UIKit

//struct MainModel : Codable{
////
////    var status : Bool?
////    var message : String?
//    var data : [Datam]?
//
//}

struct MainModel : Codable {
    var status : Bool?
    var message : String?
    var data : Datam?
}

struct Datam : Codable{
    var current_page : Int?
    var data : [Dataum]
}
struct Dataum : Codable{
    var id : Int?
    var name : String?
    var image : String?
}

/*"status": true,
 "message": null,
 "data": {
     "current_page": 1,
     "data": [
         {
             "id": 44,
             "name": "اجهزه الكترونيه",
             "image": "https://student.valuxapps.com/storage/uploads/categories/16301438353uCFh.29118.jpg"
         },
         {
             "id": 43,
             "name": "مكافحة كورونا",
             "image": "https://student.valuxapps.com/storage/uploads/categories/1630142480dvQxx.3658058.jpg"
         },*/
