//
//  ContactsUs.swift
//  e-commerce
//
//  Created by Macbook on 10/03/2023.
//

import Foundation
import UIKit

struct ContactsUs : Codable{
    
    var status : Bool?
    var message : String?
    var data : Contact?
    
}
struct Contact : Codable{
    var current_page : Int?
    var data : [CommunactionSites]?
}
struct CommunactionSites : Codable{
    
    var id : Int?
    var type : Int?
    var value : String?
    var image : String
}
/*"status": true,
 "message": null,
 "data": {
     "current_page": 1,
     "data": [
         {
             "id": 1,
             "type": 3,
             "value": "https://facebook.com",
             "image": "https://student.valuxapps.com/storage/uploads/contacts/Facebook.png"
         },*/
