//
//  Login.swift
//  e-commerce
//
//  Created by Macbook on 03/03/2023.
//

import Foundation
import UIKit


struct Login : Codable{
    
    var status : Bool?
    var message : String?
    var data : LoginUser?
    
}


struct LoginUser : Codable{
    
    var name  : String?
    var phone : String?
    var email : String?
    var id,points,credit : Int?
    var image : String?
    var token : String?
    
}
/*
 "status": true,
     "message": "تم تسجيل الدخول بنجاح",
     "data": {
         "id": 21482,
         "name": "Karim_Tawfiq",
         "email": "Karimtawfee@gmail.com",
         "phone": "0101404520",
         "image": "https://student.valuxapps.com/storage/uploads/users/UXzYjcC4EA_1665848590.jpeg",
         "points": 0,
         "credit": 0,
         "token": "Xvs599Wxk4WqMEpPZPBOnHuaCBwSy88KspZ7c8FlGBTpBOpx63UxjINgbAv5QZJC646L9J"
     }
 
 */
