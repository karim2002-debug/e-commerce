//
//  Favourit.swift
//  e-commerce
//
//  Created by Macbook on 01/03/2023.
//

import Foundation
import UIKit

struct Favourt : Codable{
    var data : Infromationn?
}

struct Infromationn :Codable{
    
    var current_page : Int?
    var data : [Productt]?
    
}

struct Productt : Codable{
    var id : Int
    var product : Infoo?
    
}

struct Infoo : Codable{
    
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
