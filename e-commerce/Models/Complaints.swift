//
//  Complaints.swift
//  e-commerce
//
//  Created by Macbook on 09/03/2023.
//

import Foundation
import UIKit

struct Complaints : Codable{
    
    var status : Bool?
    var message : String?
    var data : Complaint?
    
    
}

struct Complaint : Codable{
    
    var name : String?
    var phone : String?
    var email : String?
    var message : String?
    var id : Int?
    
}
/*

 Complaints
 
 
 
 "status": true,
 "message": "تم ارسال رسالتك بنجاح، وسوف يتم التواصل معك في أقرب وقت",
 "data": {
     "name": "Abdelrahman Algazzar",
     "phone": "12345678",
     "email": "algazzar.abdelrahman@gmail.com",
     "message": "some complaints goes here",
     "id": 12464
 }
*/
