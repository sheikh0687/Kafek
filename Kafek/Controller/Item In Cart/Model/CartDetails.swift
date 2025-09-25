//
//  CartDetails.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 07/02/25.
//

import Foundation

struct Api_CartDetails : Codable {
    let cart_total_amount : String?
    let delivery_fee : String?
    let service_fee : String?
    let total_tax : String?
    let sub_total_amount : String?
    let total_amount : String?
    let total_cart : String?
    let result : [Res_CartDetails]?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {
        case cart_total_amount = "cart_total_amount"
        case delivery_fee = "delivery_fee"
        case service_fee = "service_fee"
        case total_tax = "total_tax"
        case sub_total_amount = "sub_total_amount"
        case total_amount = "total_amount"
        case total_cart = "total_cart"
        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        cart_total_amount = try values.decodeIfPresent(String.self, forKey: .cart_total_amount)
        delivery_fee = try values.decodeIfPresent(String.self, forKey: .delivery_fee)
        service_fee = try values.decodeIfPresent(String.self, forKey: .service_fee)
        total_tax = try values.decodeIfPresent(String.self, forKey: .total_tax)
        sub_total_amount = try values.decodeIfPresent(String.self, forKey: .sub_total_amount)
        total_amount = try values.decodeIfPresent(String.self, forKey: .total_amount)
        total_cart = try values.decodeIfPresent(String.self, forKey: .total_cart)
        result = try values.decodeIfPresent([Res_CartDetails].self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct Res_CartDetails : Codable {
    let id : String?
    let user_id : String?
    let cat_id : String?
    let provider_id : String?
    let product_id : String?
    let product_name : String?
    let product_price : String?
    var quantity : String?
    let product_image : String?
    let size_id : String?
    let size_name : String?
    let size_price : String?
    let cat_name : String?
    let extra_item_id : String?
    let extra_item_name : String?
    let extra_item_price : String?
    let extra_item_qty : String?
    let total_amount : String?
    let save_money : String?
    let co2e : String?
    let total_extra_item_price : String?
    let before_discount_amount : String?
    let after_discount_amount : String?
    let discount_amount : String?
    let offer_id : String?
    let status : String?
    let offer_apply_status : String?
    let item_type : String?
    let date_time : String?
    let product_details : Product_details?
    let rest_details : Rest_details?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case user_id = "user_id"
        case cat_id = "cat_id"
        case provider_id = "provider_id"
        case product_id = "product_id"
        case product_name = "product_name"
        case product_price = "product_price"
        case quantity = "quantity"
        case product_image = "product_image"
        case size_id = "size_id"
        case size_name = "size_name"
        case size_price = "size_price"
        case cat_name = "cat_name"
        case extra_item_id = "extra_item_id"
        case extra_item_name = "extra_item_name"
        case extra_item_price = "extra_item_price"
        case extra_item_qty = "extra_item_qty"
        case total_amount = "total_amount"
        case save_money = "save_money"
        case co2e = "co2e"
        case total_extra_item_price = "total_extra_item_price"
        case before_discount_amount = "before_discount_amount"
        case after_discount_amount = "after_discount_amount"
        case discount_amount = "discount_amount"
        case offer_id = "offer_id"
        case status = "status"
        case offer_apply_status = "offer_apply_status"
        case item_type = "item_type"
        case date_time = "date_time"
        case product_details = "product_details"
        case rest_details = "rest_details"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        cat_id = try values.decodeIfPresent(String.self, forKey: .cat_id)
        provider_id = try values.decodeIfPresent(String.self, forKey: .provider_id)
        product_id = try values.decodeIfPresent(String.self, forKey: .product_id)
        product_name = try values.decodeIfPresent(String.self, forKey: .product_name)
        product_price = try values.decodeIfPresent(String.self, forKey: .product_price)
        quantity = try values.decodeIfPresent(String.self, forKey: .quantity)
        product_image = try values.decodeIfPresent(String.self, forKey: .product_image)
        size_id = try values.decodeIfPresent(String.self, forKey: .size_id)
        size_name = try values.decodeIfPresent(String.self, forKey: .size_name)
        size_price = try values.decodeIfPresent(String.self, forKey: .size_price)
        cat_name = try values.decodeIfPresent(String.self, forKey: .cat_name)
        extra_item_id = try values.decodeIfPresent(String.self, forKey: .extra_item_id)
        extra_item_name = try values.decodeIfPresent(String.self, forKey: .extra_item_name)
        extra_item_price = try values.decodeIfPresent(String.self, forKey: .extra_item_price)
        extra_item_qty = try values.decodeIfPresent(String.self, forKey: .extra_item_qty)
        total_amount = try values.decodeIfPresent(String.self, forKey: .total_amount)
        save_money = try values.decodeIfPresent(String.self, forKey: .save_money)
        co2e = try values.decodeIfPresent(String.self, forKey: .co2e)
        total_extra_item_price = try values.decodeIfPresent(String.self, forKey: .total_extra_item_price)
        before_discount_amount = try values.decodeIfPresent(String.self, forKey: .before_discount_amount)
        after_discount_amount = try values.decodeIfPresent(String.self, forKey: .after_discount_amount)
        discount_amount = try values.decodeIfPresent(String.self, forKey: .discount_amount)
        offer_id = try values.decodeIfPresent(String.self, forKey: .offer_id)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        offer_apply_status = try values.decodeIfPresent(String.self, forKey: .offer_apply_status)
        item_type = try values.decodeIfPresent(String.self, forKey: .item_type)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
        product_details = try values.decodeIfPresent(Product_details.self, forKey: .product_details)
        rest_details = try values.decodeIfPresent(Rest_details.self, forKey: .rest_details)
    }
}

struct Rest_details : Codable {
    let id : String?
    let first_name : String?
    let last_name : String?
    let mobile : String?
    let mobile_with_code : String?
    let email : String?
    let password : String?
    let country_id : String?
    let country_name : String?
    let state_id : String?
    let state_name : String?
    let city_id : String?
    let city_name : String?
    let image : String?
    let type : String?
    let social_id : String?
    let lat : String?
    let lon : String?
    let address : String?
    let address_id : String?
    let addresstype : String?
    let gender : String?
    let wallet : String?
    let register_id : String?
    let ios_register_id : String?
    let status : String?
    let approve_status : String?
    let available_status : String?
    let code : String?
    let date_time : String?
    let note : String?
    let note_block : String?
    let block_unblock : String?
    let remove_status : String?
    let open_time : String?
    let close_time : String?
    let referral_code : String?
    let signup_referral_code : String?
    let provider_name : String?
    let provider_email : String?
    let provider_mobile : String?
    let provider_streat_address : String?
    let provider_lat : String?
    let provider_lon : String?
    let provider_post_code : String?
    let provider_country : String?
    let provider_country_id : String?
    let facebook_url : String?
    let instagram_url : String?
    let description : String?
    let about_me : String?
    let provider_logo : String?
    let radius : String?
    let cat_id : String?
    let cat_name : String?
    let cat_name_ar : String?
    let driver_choice : String?
    let direct_accepted : String?
    let vehicle_name : String?
    let vehicle_id : String?
    let vehicle_type : String?
    let driver_experience : String?
    let vehicle_delivery_type : String?
    let service_id : String?
    let service_name : String?
    let sub_service_id : String?
    let sub_service_name : String?
    let registration_image : String?
    let supervisor_name : String?
    let supervisor_number : String?
    let front_view : String?
    let rear_view : String?
    let side_view : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case first_name = "first_name"
        case last_name = "last_name"
        case mobile = "mobile"
        case mobile_with_code = "mobile_with_code"
        case email = "email"
        case password = "password"
        case country_id = "country_id"
        case country_name = "country_name"
        case state_id = "state_id"
        case state_name = "state_name"
        case city_id = "city_id"
        case city_name = "city_name"
        case image = "image"
        case type = "type"
        case social_id = "social_id"
        case lat = "lat"
        case lon = "lon"
        case address = "address"
        case address_id = "address_id"
        case addresstype = "addresstype"
        case gender = "gender"
        case wallet = "wallet"
        case register_id = "register_id"
        case ios_register_id = "ios_register_id"
        case status = "status"
        case approve_status = "approve_status"
        case available_status = "available_status"
        case code = "code"
        case date_time = "date_time"
        case note = "note"
        case note_block = "note_block"
        case block_unblock = "block_unblock"
        case remove_status = "remove_status"
        case open_time = "open_time"
        case close_time = "close_time"
        case referral_code = "referral_code"
        case signup_referral_code = "signup_referral_code"
        case provider_name = "provider_name"
        case provider_email = "provider_email"
        case provider_mobile = "provider_mobile"
        case provider_streat_address = "provider_streat_address"
        case provider_lat = "provider_lat"
        case provider_lon = "provider_lon"
        case provider_post_code = "provider_post_code"
        case provider_country = "provider_country"
        case provider_country_id = "provider_country_id"
        case facebook_url = "facebook_url"
        case instagram_url = "instagram_url"
        case description = "description"
        case about_me = "about_me"
        case provider_logo = "provider_logo"
        case radius = "radius"
        case cat_id = "cat_id"
        case cat_name = "cat_name"
        case cat_name_ar = "cat_name_ar"
        case driver_choice = "driver_choice"
        case direct_accepted = "direct_accepted"
        case vehicle_name = "vehicle_name"
        case vehicle_id = "vehicle_id"
        case vehicle_type = "vehicle_type"
        case driver_experience = "driver_experience"
        case vehicle_delivery_type = "vehicle_delivery_type"
        case service_id = "service_id"
        case service_name = "service_name"
        case sub_service_id = "sub_service_id"
        case sub_service_name = "sub_service_name"
        case registration_image = "registration_image"
        case supervisor_name = "supervisor_name"
        case supervisor_number = "supervisor_number"
        case front_view = "front_view"
        case rear_view = "rear_view"
        case side_view = "side_view"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
        last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        mobile_with_code = try values.decodeIfPresent(String.self, forKey: .mobile_with_code)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        password = try values.decodeIfPresent(String.self, forKey: .password)
        country_id = try values.decodeIfPresent(String.self, forKey: .country_id)
        country_name = try values.decodeIfPresent(String.self, forKey: .country_name)
        state_id = try values.decodeIfPresent(String.self, forKey: .state_id)
        state_name = try values.decodeIfPresent(String.self, forKey: .state_name)
        city_id = try values.decodeIfPresent(String.self, forKey: .city_id)
        city_name = try values.decodeIfPresent(String.self, forKey: .city_name)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        social_id = try values.decodeIfPresent(String.self, forKey: .social_id)
        lat = try values.decodeIfPresent(String.self, forKey: .lat)
        lon = try values.decodeIfPresent(String.self, forKey: .lon)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        address_id = try values.decodeIfPresent(String.self, forKey: .address_id)
        addresstype = try values.decodeIfPresent(String.self, forKey: .addresstype)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        wallet = try values.decodeIfPresent(String.self, forKey: .wallet)
        register_id = try values.decodeIfPresent(String.self, forKey: .register_id)
        ios_register_id = try values.decodeIfPresent(String.self, forKey: .ios_register_id)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        approve_status = try values.decodeIfPresent(String.self, forKey: .approve_status)
        available_status = try values.decodeIfPresent(String.self, forKey: .available_status)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
        note = try values.decodeIfPresent(String.self, forKey: .note)
        note_block = try values.decodeIfPresent(String.self, forKey: .note_block)
        block_unblock = try values.decodeIfPresent(String.self, forKey: .block_unblock)
        remove_status = try values.decodeIfPresent(String.self, forKey: .remove_status)
        open_time = try values.decodeIfPresent(String.self, forKey: .open_time)
        close_time = try values.decodeIfPresent(String.self, forKey: .close_time)
        referral_code = try values.decodeIfPresent(String.self, forKey: .referral_code)
        signup_referral_code = try values.decodeIfPresent(String.self, forKey: .signup_referral_code)
        provider_name = try values.decodeIfPresent(String.self, forKey: .provider_name)
        provider_email = try values.decodeIfPresent(String.self, forKey: .provider_email)
        provider_mobile = try values.decodeIfPresent(String.self, forKey: .provider_mobile)
        provider_streat_address = try values.decodeIfPresent(String.self, forKey: .provider_streat_address)
        provider_lat = try values.decodeIfPresent(String.self, forKey: .provider_lat)
        provider_lon = try values.decodeIfPresent(String.self, forKey: .provider_lon)
        provider_post_code = try values.decodeIfPresent(String.self, forKey: .provider_post_code)
        provider_country = try values.decodeIfPresent(String.self, forKey: .provider_country)
        provider_country_id = try values.decodeIfPresent(String.self, forKey: .provider_country_id)
        facebook_url = try values.decodeIfPresent(String.self, forKey: .facebook_url)
        instagram_url = try values.decodeIfPresent(String.self, forKey: .instagram_url)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        about_me = try values.decodeIfPresent(String.self, forKey: .about_me)
        provider_logo = try values.decodeIfPresent(String.self, forKey: .provider_logo)
        radius = try values.decodeIfPresent(String.self, forKey: .radius)
        cat_id = try values.decodeIfPresent(String.self, forKey: .cat_id)
        cat_name = try values.decodeIfPresent(String.self, forKey: .cat_name)
        cat_name_ar = try values.decodeIfPresent(String.self, forKey: .cat_name_ar)
        driver_choice = try values.decodeIfPresent(String.self, forKey: .driver_choice)
        direct_accepted = try values.decodeIfPresent(String.self, forKey: .direct_accepted)
        vehicle_name = try values.decodeIfPresent(String.self, forKey: .vehicle_name)
        vehicle_id = try values.decodeIfPresent(String.self, forKey: .vehicle_id)
        vehicle_type = try values.decodeIfPresent(String.self, forKey: .vehicle_type)
        driver_experience = try values.decodeIfPresent(String.self, forKey: .driver_experience)
        vehicle_delivery_type = try values.decodeIfPresent(String.self, forKey: .vehicle_delivery_type)
        service_id = try values.decodeIfPresent(String.self, forKey: .service_id)
        service_name = try values.decodeIfPresent(String.self, forKey: .service_name)
        sub_service_id = try values.decodeIfPresent(String.self, forKey: .sub_service_id)
        sub_service_name = try values.decodeIfPresent(String.self, forKey: .sub_service_name)
        registration_image = try values.decodeIfPresent(String.self, forKey: .registration_image)
        supervisor_name = try values.decodeIfPresent(String.self, forKey: .supervisor_name)
        supervisor_number = try values.decodeIfPresent(String.self, forKey: .supervisor_number)
        front_view = try values.decodeIfPresent(String.self, forKey: .front_view)
        rear_view = try values.decodeIfPresent(String.self, forKey: .rear_view)
        side_view = try values.decodeIfPresent(String.self, forKey: .side_view)
    }
}
