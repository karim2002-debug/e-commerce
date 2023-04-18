//
//  APICaller.swift
//  e-commerce
//
//  Created by Macbook on 21/02/2023.
//

import Foundation
import Alamofire


enum NetworkErorr : Error{
    case urlError
    case canNotPresentData
}

class APICaller{
    
    
    
    static func getMainProducts(completionHandler : @escaping (_ result : Result<MainModel,NetworkErorr>)->Void){
        
        guard let url = URL(string: "https://student.valuxapps.com/api/categories")else{
            completionHandler(.failure(.urlError))
            return
        }
        AF.request(url,method: .get).responseDecodable(of: MainModel.self) { response in
            switch response.result{
            case .success(let model):
                completionHandler(.success(model))
                
            case .failure(let error):
                print(error)
                completionHandler(.failure(.canNotPresentData))
                
            }
        }
    }
    
    static func getSpesficProduct(catogeryId : Int,completionHandler : @escaping(_ result : Result<Infromation,NetworkErorr>)->Void){
        
        
        guard let url = URL(string: "https://student.valuxapps.com/api/products/?")else{
            completionHandler(.failure(.urlError))
            return
        }
        
        let params  = [
            "category_id" : catogeryId
        ]
        
        AF.request(url,method: .get,parameters: params).responseDecodable(of: Infromation.self) { resopnse  in
            
            switch resopnse.result{
            case .success(let products):
                print("Product = ",products)
                completionHandler(.success(products))
            case .failure(let error):
                completionHandler(.failure(.canNotPresentData))
                print(error)
            }
            
        }
        
    }
    
    
    static func getAllProduct(CompletionHandler : @escaping (_ result : Result<Infromation,NetworkErorr>)->Void){
        
        
        guard let url = URL(string: "https://student.valuxapps.com/api/products")else{
            CompletionHandler(.failure(.urlError))
            return
        }
        
        AF.request(url,method: .get).responseDecodable(of: Infromation.self) { response in
            switch response.result{
            case .success(let products):
                print("products",products)
                CompletionHandler(.success(products))
            case .failure(let error):
                print(error)
                CompletionHandler(.failure(.canNotPresentData))
                
            }
        }
        
    }
    
    
    
    static func searchProduct(text : String ,CompletionHandler : @escaping (_ result : Result<Infromation,NetworkErorr>)->Void){
        
        guard let url = URL(string: "https://student.valuxapps.com/api/products/search")else{
            CompletionHandler(.failure(.urlError))
            return
        }
        let parms = [
            "text" : text
        ]
        
        AF.request(url,method: .post,parameters: parms).responseDecodable(of: Infromation.self) { response in
            switch response.result{
            case .success(let products):
                print("كproducts",products.data!)
                CompletionHandler(.success(products))
            case .failure(let error):
                print(error)
                CompletionHandler(.failure(.canNotPresentData))
                
            }
        }
        
    }
    
    static func getCatories(completionHandler : @escaping (_ result : Result<[String],NetworkErorr>)->Void){
        
        guard let url = URL(string: "https://fakestoreapi.com/products/categories")else{
            completionHandler(.failure(.urlError))
            return
        }
        
        AF.request(url,method: .get).responseDecodable(of: [String].self) { response in
            switch response.result{
            case .success(let catogery):
                print("products",catogery)
                completionHandler(.success(catogery))
            case .failure(let error):
                print(error)
                completionHandler(.failure(.canNotPresentData))
                
            }
        }
        
    }
    
    
    static func getCateriosProducts(productName : String,completionHandler : @escaping (_ result : Result<[Catogeries],NetworkErorr>)->Void){
        
        
        // To clear the spaces in url
        guard let productName = productName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)else{return}
        
        guard let url = URL(string: "https://fakestoreapi.com/products/category/\(productName)")else{
            return
        }
        AF.request(url,method: .get).responseDecodable(of: [Catogeries].self) { response in
            switch response.result{
            case .success(let products):
                print("products",products)
                completionHandler(.success(products))
            case .failure(let error):
                print(error)
                completionHandler(.failure(.canNotPresentData))
                
            }
        }
        
    }
    
    
    //MARK:  CART
    
    
    static func postCarts(token : String,productId : Int , completionHandler : @escaping (_ result : Result <Carts,NetworkErorr>)->Void){
        
        guard let url = URL(string: "https://student.valuxapps.com/api/carts")else{
            completionHandler(.failure(.urlError))
            return
        }
        let headers : HTTPHeaders = [
            "Authorization" :   token
            
        ]
        let parems  = [
            
            "product_id" :  productId
            
        ]
        
        AF.request(url,method: .post,parameters: parems,headers: headers).responseDecodable(of: Carts.self) { response in
            switch response.result{
            case .success(let cart):
                completionHandler(.success(cart))
            case.failure(let error):
                print(error)
            }
        }
        
    }
    
    
    static func getCartsProducts(token : String ,completionHandler : @escaping (_ result : Result<CartsProducts,NetworkErorr>)->Void){
        
        guard let url = URL(string: "https://student.valuxapps.com/api/carts")else{
            completionHandler(.failure(.urlError))
            return
        }
        let headers : HTTPHeaders = [
            "Authorization" :  token
            
        ]
        AF.request(url,method: .get,headers: headers).responseDecodable(of: CartsProducts.self) { response in
            switch response.result{
            case .success(let cart):
                print(cart)
                completionHandler(.success(cart))
            case.failure(let error):
                print(error)
            }
        }
        
    }
    
    
    
    static  func updateCart(token : String ,quantity : Int,cartId : Int , complertionHandler : @escaping ( _ result : Result <Cart , NetworkErorr>)->Void){
        
        guard let url = URL(string: "https://student.valuxapps.com/api/carts/\(cartId)")else{
            complertionHandler(.failure(.urlError))
            return
        }
        
        let headers : HTTPHeaders = [
            "Authorization" :  token
        ]
        let parms  =  [
            "quantity" : quantity
        ]
        let encoder = URLEncodedFormParameterEncoder(encoder: URLEncodedFormEncoder(dataEncoding: .deferredToData))
        
        AF.request(url,method: .put,parameters: parms, encoder: JSONParameterEncoder.default,headers: headers).responseDecodable(of: Cart.self) { response in
            
            print(response.result)
            switch response.result{
                
            case .success(let cart):
                print(cart)
                complertionHandler(.success(cart))
            case .failure(let error):
                complertionHandler(.failure(.canNotPresentData))
                print(error)
            }
        }
        
    }
    
    //MARK:  FAVORITE
    
    static func postProductInFavorite(token : String,productId : Int , completionHandler : @escaping ( _ result : Result<Favorite,NetworkErorr>)->Void){
        
        guard let url = URL(string: "https://student.valuxapps.com/api/favorites")else{
            completionHandler(.failure(.urlError))
            return
        }
        
        let headers : HTTPHeaders = [
            "Authorization" :  token
        ]
        
        let parms = [
            "product_id" : productId
        ]
        
        AF.request(url,method: .post,parameters: parms,headers: headers).responseDecodable(of: Favorite.self) { response in
            switch response.result{
                
            case .success(let favrite):
                print("Done")
                completionHandler(.success(favrite))
            case .failure(let error):
                print(error)
            }
        }
        
        
    }
    
    
    static func getProductdInFavourite(token : String,completionHandler : @escaping ( _ result : Result<Favourt,NetworkErorr>)->Void){
        
        
        
        guard let url = URL(string: "https://student.valuxapps.com/api/favorites")else{
            completionHandler(.failure(.urlError))
            return
        }
        
        let headers : HTTPHeaders = [
            "Authorization" :  token
        ]
        
        AF.request(url,method: .get,headers: headers).responseDecodable(of: Favourt.self) { response in
            switch response.result{
                
            case .success(let favrite):
                completionHandler(.success(favrite))
            case .failure(let error):
                print(error)
            }
        }
        
        
        
    }
    
    //MARK: SIGN UP
    
    static func SignIn(name : String , phone : String , email : String , password : String , completionHandler : @escaping ( _ result : Result<SignUp,NetworkErorr>)->Void){
        
        guard let url = URL(string: "https://student.valuxapps.com/api/register")else{
            completionHandler(.failure(.urlError))
            return
        }
        
        let parms = [
            
            "name": name,
            "phone": phone,
            "email": email,
            "password": password,
            "image":""
            
        ]
        
        AF.request(url,method: .post,parameters: parms,encoder: JSONParameterEncoder.default).responseDecodable(of: SignUp.self) { response in
            
            switch response.result{
            case .success(let signInfo):
                Token.password = password
                Token.Tokenalready = signInfo.data?.token
                
                //                UserDefaults.standard.set(Token.Tokenalready, forKey: "Register")
                
                print(signInfo.message)
                completionHandler(.success(signInfo))
            case .failure(let error):
                completionHandler(.failure(.canNotPresentData))
                print(error)
                
            }
        }
        
    }
    
    //MARK: LOGIN
    
    static func login(email : String , password : String , completionHandler : @escaping ( _ result : Result<Login,NetworkErorr>)->Void){
        
        guard let url = URL(string: "https://student.valuxapps.com/api/login")else{
            completionHandler(.failure(.urlError))
            return
        }
        
        let parms = [
            "email": email,
            "password": password
        ]
        
        AF.request(url,method: .post,parameters: parms,encoder: JSONParameterEncoder.default).responseDecodable(of: Login.self) { response in
            
            switch response.result{
            case .success(let LoginInfo):
                Token.Tokenalready = LoginInfo.data?.token
                Token.password = password
                UserDefaults.standard.set(Token.Tokenalready, forKey: "login")
                UserDefaults.standard.set(Token.password, forKey: "password")

                print(LoginInfo.message)
                completionHandler(.success(LoginInfo))
            case .failure(let error):
                completionHandler(.failure(.canNotPresentData))
                print(error)
                
            }
        }
    }
    
    //MARK: LOGOUT
    
    
    static func loginOut(token : String , completionHandler : @escaping ( _ result : Result<Login,NetworkErorr>)->Void){
        
        guard let url = URL(string: "https://student.valuxapps.com/api/logout")else{
            completionHandler(.failure(.urlError))
            return
        }
        
        let parms = [
            "fcm_token": token
            
        ]
        
        AF.request(url,method: .post,parameters: parms,encoder: JSONParameterEncoder.default).responseDecodable(of: Login.self) { response in
            
            switch response.result{
            case .success(let loggedOut):
                
                Token.Tokenalready = ""
                print(loggedOut.message)
                completionHandler(.success(loggedOut))
            case .failure(let error):
                completionHandler(.failure(.canNotPresentData))
                print(error)
                
            }
        }
    }
    
    //MARK: PROFILE
    
    static func getProfileInfo(token : String,completionHandler : @escaping ( _ result : Result<Login,NetworkErorr>)->Void){
        
        guard let url = URL(string: "https://student.valuxapps.com/api/profile")else{
            completionHandler(.failure(.urlError))
            return
        }
        
        
        let headers : HTTPHeaders = [
            "Authorization" :  token
        ]
        
        AF.request(url,method: .get,headers: headers).responseDecodable(of: Login.self) { response in
            switch response.result{
            case .success(let info):
                print(info)
                completionHandler(.success(info))
            case .failure(let error):
                completionHandler(.failure(.canNotPresentData))
            }
        }
    }
    // update Personal info

    static func updateProfile(token : String,name :String,phone : String , email : String, image : String , completionHandler : @escaping ( _ result : Result<Login,NetworkErorr>)->Void){
        
        
        guard let url = URL(string: "https://student.valuxapps.com/api/update-profile")else{
            completionHandler(.failure(.urlError))
            
            return
        }
        
        let header : HTTPHeaders = [
            "Authorization" :  token
        ]
        
        let parms = [
            
                "name": name,
                "phone": phone,
                "email": email,
                "image": image
        ]
        AF.request(url,method: .put,parameters: parms,encoder: JSONParameterEncoder.default,headers: header).responseDecodable(of: Login.self) { response in
            
            switch response.result{
            case .success(let updateInfo):
                completionHandler(.success(updateInfo))
                print(updateInfo)
            case .failure(let error):
                completionHandler(.failure(.canNotPresentData))
                print(error)
            }
            
        }
    }
    
    // changePassword
    
    
    static func changePassword(token : String , newPassword : String,currentPassword : String , completionHandler : @escaping ( _ result : Result<ChangePassword,NetworkErorr>)->Void){
        
        guard let url = URL(string: "https://student.valuxapps.com/api/change-password")else{
            completionHandler(.failure(.urlError))
            return
        }
        
        let header : HTTPHeaders = [
            "Authorization" :  token
        ]
        let parms = [
            "current_password": currentPassword,
                "new_password": newPassword
        ]
        
        
        AF.request(url , method: .post,parameters: parms,encoder: JSONParameterEncoder.default,headers: header).responseDecodable(of: ChangePassword.self) { response in
            
            switch response.result{
            case .success(let password):
                Token.password = newPassword
                completionHandler(.success(password))
            case .failure(let error):
                completionHandler(.failure(.canNotPresentData))
                print(error)
            }
        }
    }
    
 // MARK: COMPLAINTS AND SUGESSTION
    
    static func ComplaintsAandSuggestions(name : String , phone : String ,email : String,message : String,completionHandler : @escaping ( _ result : Result<Complaints,NetworkErorr>)->Void){
        
        guard let url = URL(string: "https://student.valuxapps.com/api/complaints")else{
            completionHandler(.failure(.urlError))
            return
        }
        
        let parms = [
        
            "name":name,
            "phone":phone,
            "email":email,
            "message":message
        
        ]
        
        AF.request(url,method: .post,parameters: parms,encoder: JSONParameterEncoder.default).responseDecodable(of: Complaints.self) { resposne in
            switch resposne.result{
                
            case .success(let complaint):
                completionHandler(.success(complaint))
                print(complaint)
            case .failure(let error):
                completionHandler(.failure(.canNotPresentData))
                print(error)
            }
        }
    }
    
    
    // MARK: CONTACTS US
    
    static func getContactsInfo(completionHAndler : @escaping ( _ result : Result<ContactsUs,NetworkErorr>)->Void){
        
        guard let url = URL(string: "https://student.valuxapps.com/api/contacts")else{
            completionHAndler(.failure(.urlError))
            return
        }
        
        AF.request(url,method: .get).responseDecodable(of: ContactsUs.self) { response in
            switch response.result{
            case .success(let contactInfo):
                completionHAndler(.success(contactInfo))
                print(contactInfo.data?.data)
            case .failure(let error):
                completionHAndler(.failure(.canNotPresentData))
                print(error)
            }
        }
        
    }
    
    //MARK: ABOUT US
    
    
    static func aboutUs(completionHandler : @escaping ( _ result : Result<AboutUs,NetworkErorr>)->Void){
        
        guard let url = URL(string: "https://student.valuxapps.com/api/settings")else{
            completionHandler(.failure(.urlError))
            return
        }
        
        AF.request(url,method: .get).responseDecodable(of: AboutUs.self) { response in
            switch response.result{
            case .success(let AboutUs):
                completionHandler(.success(AboutUs))
            case .failure(let error):
                completionHandler(.failure(.canNotPresentData))
                print(error)
            }
        }

        
    }
    
}
