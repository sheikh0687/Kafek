//
//  Router.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 10/09/24.
//

import Foundation

enum Router: String {
    
    static let BASE_SERVICE_URL = "https://techimmense.in/kafak/webservice/"
    static let BASE_IMAGE_URL = "https://techimmense.in/kafak/uploads/images/"
    
    case login
    case signup
    
    case forgot_password
    
    case get_banner
    case get_services
    case get_all_store_list
    case get_provider_details
    case get_user_address
    case get_product_details
    
    case add_user_address
    
    case delete_user_address
    
    public func url() -> String {
        switch self {
            
        case .login:
            return Router.oAuthpath(path: "login")
        case .signup:
            return Router.oAuthpath(path: "signup")
            
        case .forgot_password:
            return Router.oAuthpath(path: "forgot_password")
            
        case .get_banner:
            return Router.oAuthpath(path: "get_banner")
        case .get_services:
            return Router.oAuthpath(path: "get_services")
        case .get_all_store_list:
            return Router.oAuthpath(path: "get_all_store_list")
        case .get_provider_details:
            return Router.oAuthpath(path: "get_provider_details")
        case .get_user_address:
            return Router.oAuthpath(path: "get_user_address")
        case .get_product_details:
            return Router.oAuthpath(path: "get_product_details")
            
        case .add_user_address:
            return Router.oAuthpath(path: "add_user_address")
            
        case .delete_user_address:
            return Router.oAuthpath(path: "delete_user_address")
        }
    }
    
    private static func oAuthpath(path: String) -> String {
        return BASE_SERVICE_URL + path
    }
}
