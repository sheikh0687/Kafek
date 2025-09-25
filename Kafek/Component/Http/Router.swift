//
//  Router.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 10/09/24.
//

import Foundation

enum Router: String {
    
    static let BASE_SERVICE_URL = "https://kaffak.company/kaffak/webservice/"
    static let BASE_IMAGE_URL = "https://kaffak.company/kaffak/uploads/images/"
    
    case login
    case signup
    case send_otp
    
    case forgot_password
    case change_password
    case send_feedback
    
    case get_banner
    case get_services
    case get_all_store_list
    case get_provider_details
    case get_user_address
    case get_product_details
    case get_service_by_id
    case get_provider_cart
    case get_cart
    case get_user_order_by_status
    case get_order_details
    case get_transaction
    case get_send_feedback
    case get_welcome_page_banner
    case get_feedback_chat_detail
    case get_user_review_rating
    case get_withdraw_request
    case get_service_price_with_zone_price
    case get_notification_list
    case get_user_card
    
    case get_profile
    case update_profile
    
    case get_chat_detail
    case get_conversation_detail
    case insert_chat
    case insert_chat_feedback
    
    case add_user_address
    case add_to_cart_product
    case add_withdraw_request
    case update_cart
    case add_wallet_amount
    
    case delete_user_address
    case change_order_status
    case delete_cart_item
    
    case place_order_for_service
    case get_bid_place_list
    case place_order
    
    case offerAcceptOrReject
    
    case order_cancel_by_user_after_accept
    case update_payment_status_user_side
    case add_rating_review_by_order
    
    case delete_user_account
    case addPayment
    case add_user_card
    
    case delete_user_card
    case get_user_page
    
    case checkout
    case update_payment_status_by_user
    
    case update_app_language
    case send_otp_for_change_password
    
    public func url() -> String {
        switch self {
            
        case .login:
            return Router.oAuthpath(path: "login")
        case .signup:
            return Router.oAuthpath(path: "signup")
        case .send_otp:
            return Router.oAuthpath(path: "send_otp")
            
        case .forgot_password:
            return Router.oAuthpath(path: "forgot_password")
        case .change_password:
            return Router.oAuthpath(path: "change_password")
        case .send_feedback:
            return Router.oAuthpath(path: "send_feedback")
            
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
        case .get_service_by_id:
            return Router.oAuthpath(path: "get_service_by_id")
        case .get_send_feedback:
            return Router.oAuthpath(path: "get_send_feedback")
        case .get_welcome_page_banner:
            return Router.oAuthpath(path: "get_welcome_page_banner")
        case .get_user_review_rating:
            return Router.oAuthpath(path: "get_user_review_rating")
        case .get_withdraw_request:
            return Router.oAuthpath(path: "get_withdraw_request")
            
        case .get_chat_detail:
            return Router.oAuthpath(path: "get_chat_detail")
        case .get_conversation_detail:
            return Router.oAuthpath(path: "get_conversation_detail")
        case .get_feedback_chat_detail:
            return Router.oAuthpath(path: "get_feedback_chat_detail")
        case .insert_chat:
            return Router.oAuthpath(path: "insert_chat")
        case .insert_chat_feedback:
            return Router.oAuthpath(path: "insert_chat_feedback")
            
        case .get_profile:
            return Router.oAuthpath(path: "get_profile")
        case .update_profile:
            return Router.oAuthpath(path: "update_profile")
            
        case .add_user_address:
            return Router.oAuthpath(path: "add_user_address")
        case .add_to_cart_product:
            return Router.oAuthpath(path: "add_to_cart_product")
        case .add_withdraw_request:
            return Router.oAuthpath(path: "add_withdraw_request")
        case .add_wallet_amount:
            return Router.oAuthpath(path: "add_wallet_amount")

        case .delete_user_address:
            return Router.oAuthpath(path: "delete_user_address")
            
        case .get_provider_cart:
            return Router.oAuthpath(path: "get_provider_cart")
        case .get_cart:
            return Router.oAuthpath(path: "get_cart")
        case .get_user_order_by_status:
            return Router.oAuthpath(path: "get_user_order_by_status")
        case .get_order_details:
            return Router.oAuthpath(path: "get_order_details")
        case .change_order_status:
            return Router.oAuthpath(path: "change_order_status")
        case .get_transaction:
            return Router.oAuthpath(path: "get_transaction")
            
        case .update_cart:
            return Router.oAuthpath(path: "update_cart")
            
        case .delete_cart_item:
            return Router.oAuthpath(path: "delete_cart_item")
        case .place_order_for_service:
            return Router.oAuthpath(path: "place_order_for_service")
        case .get_bid_place_list:
            return Router.oAuthpath(path: "get_bid_place_list")
        case .get_user_card:
            return Router.oAuthpath(path: "get_user_card")
            
        case .offerAcceptOrReject:
            if offerAcceptOrRejectByUser {
                return Router.oAuthpath(path: "offer_accept_by_user")
            } else {
                return Router.oAuthpath(path: "reject_place_bid_by_user")
            }
            
        case .order_cancel_by_user_after_accept:
            return Router.oAuthpath(path: "order_cancel_by_user_after_accept")
            
        case .place_order:
            return Router.oAuthpath(path: "place_order")
        case .update_payment_status_user_side:
            return Router.oAuthpath(path: "update_payment_status_user_side")
        case .add_rating_review_by_order:
            return Router.oAuthpath(path: "add_rating_review_by_order")
            
        case .delete_user_account:
            return Router.oAuthpath(path: "delete_account")
      
        case .get_service_price_with_zone_price:
            return Router.oAuthpath(path: "get_service_price_with_zone_price")
        case .get_notification_list:
            return Router.oAuthpath(path: "get_notification_list")
        case .addPayment:
            return Router.oAuthpath(path: "addPayment")
        case .add_user_card:
            return Router.oAuthpath(path: "add_user_card")
            
        case .delete_user_card:
            return Router.oAuthpath(path: "delete_user_card")
            
        case .get_user_page:
            return Router.oAuthpath(path: "get_user_page")
            
        case .checkout:
            return Router.oAuthpath(path: "checkout")
        case .update_payment_status_by_user:
            return Router.oAuthpath(path: "update_payment_status_by_user")
            
        case .update_app_language:
            return Router.oAuthpath(path: "update_app_language")
            
        case .send_otp_for_change_password:
            return Router.oAuthpath(path: "send_otp_for_change_password")
        }
    }
    
    private static func oAuthpath(path: String) -> String {
        return BASE_SERVICE_URL + path
    }
}
