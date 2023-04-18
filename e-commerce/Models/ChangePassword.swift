//
//  ChangePassword.swift
//  e-commerce
//
//  Created by Macbook on 09/03/2023.
//

import Foundation
import UIKit

struct ChangePassword : Codable{
    
    var status : Bool?
    var message : String?
    var data : Email?
}
struct Email : Codable{
  var email : String
}
