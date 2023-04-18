//
//  SignUp.swift
//  e-commerce
//
//  Created by Macbook on 03/03/2023.
//

import Foundation
import UIKit


struct SignUp : Codable{
    
    var status : Bool
    var message : String
    var data : SignUser?
}

struct SignUser : Codable{
    
    var name  : String?
    var phone : String?
    var email : String?
    var id : Int?
    var image : String?
    var token : String?
    
}
/*
 "status": true,
     "message": "تم التسجيل بنجاح",
     "data": {
         "name": "Karim_Tawfiq",
         "phone": "0101404320",
         "email": "Karimtawfeee@gmail.com",
         "id": 52985,
         "image": "https://student.valuxapps.com/storage/assets/defaults/user.jpg",
         "token": "dFJFRYkKZnMMCBD8cm4CuyhfgTU8lNgJNyL1WfxtPI4VfwdhPjjXFGYbPDIVLpmHc0A4YZ"
     }
 */
