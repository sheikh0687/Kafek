//
//  BookingStatus.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 06/02/25.
//

import Foundation

struct Api_BookingStatus : Codable {
    let result : [Res_BookingStatus]?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent([Res_BookingStatus].self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct Res_BookingStatus : Codable {
    let id : String?
    let user_id : String?
    let provider_id : String?
    let product_id : String?
    let cart_id : String?
    let cat_id : String?
    let size_id : String?
    let vehicle_id : String?
    let address_id : String?
    let address : String?
    let lat : String?
    let lon : String?
    let order_id : String?
    let price_type : String?
    let total_amount : String?
    let before_discount_amount : String?
    let total_discount_amount : String?
    let payment_type : String?
    let provider_amount : String?
    let admin_commission : String?
    let delivery_date : String?
    let delivery_time : String?
    let date_time : String?
    let status : String?
    let self_delivery_status : String?
    let delivery_status : String?
    let payment_status : String?
    let payment_method : String?
    let driver_id : String?
    let accept_driver_id : String?
    let driver_offer_amount : String?
    let bid_id : String?
    let remove_status : String?
    let delivery_fee : String?
    let order_pin : String?
    let pickup_address : String?
    let pickup_lat : String?
    let pickup_lon : String?
    let provider_note : String?
    let date : String?
    let time : String?
    let offer_id : String?
    let offer_code : String?
    let reason_title : String?
    let reason_detail : String?
    let order_type : String?
    let direct_accepted : String?
    let zone_id : String?
    let zone_price : String?
    let zone_name : String?
    let user_note : String?
    let cancel_by_user : String?
    let cancel_reason : String?
    let cart_details : [Cart_details]?
    let address_details : Address_details?
    let product_details : [Product_details]?
    let provider_details : Provider_details?
    let rating_review : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case user_id = "user_id"
        case provider_id = "provider_id"
        case product_id = "product_id"
        case cart_id = "cart_id"
        case cat_id = "cat_id"
        case size_id = "size_id"
        case vehicle_id = "vehicle_id"
        case address_id = "address_id"
        case address = "address"
        case lat = "lat"
        case lon = "lon"
        case order_id = "order_id"
        case price_type = "price_type"
        case total_amount = "total_amount"
        case before_discount_amount = "before_discount_amount"
        case total_discount_amount = "total_discount_amount"
        case payment_type = "payment_type"
        case provider_amount = "provider_amount"
        case admin_commission = "admin_commission"
        case delivery_date = "delivery_date"
        case delivery_time = "delivery_time"
        case date_time = "date_time"
        case status = "status"
        case self_delivery_status = "self_delivery_status"
        case delivery_status = "delivery_status"
        case payment_status = "payment_status"
        case payment_method = "payment_method"
        case driver_id = "driver_id"
        case accept_driver_id = "accept_driver_id"
        case driver_offer_amount = "driver_offer_amount"
        case bid_id = "bid_id"
        case remove_status = "remove_status"
        case delivery_fee = "delivery_fee"
        case order_pin = "order_pin"
        case pickup_address = "pickup_address"
        case pickup_lat = "pickup_lat"
        case pickup_lon = "pickup_lon"
        case provider_note = "provider_note"
        case date = "date"
        case time = "time"
        case offer_id = "offer_id"
        case offer_code = "offer_code"
        case reason_title = "reason_title"
        case reason_detail = "reason_detail"
        case order_type = "order_type"
        case direct_accepted = "direct_accepted"
        case zone_id = "zone_id"
        case zone_price = "zone_price"
        case zone_name = "zone_name"
        case user_note = "user_note"
        case cancel_by_user = "cancel_by_user"
        case cancel_reason = "cancel_reason"
        case cart_details = "cart_details"
        case address_details = "address_details"
        case product_details = "product_details"
        case provider_details = "provider_details"
        case rating_review = "rating_review"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        provider_id = try values.decodeIfPresent(String.self, forKey: .provider_id)
        product_id = try values.decodeIfPresent(String.self, forKey: .product_id)
        cart_id = try values.decodeIfPresent(String.self, forKey: .cart_id)
        cat_id = try values.decodeIfPresent(String.self, forKey: .cat_id)
        size_id = try values.decodeIfPresent(String.self, forKey: .size_id)
        vehicle_id = try values.decodeIfPresent(String.self, forKey: .vehicle_id)
        address_id = try values.decodeIfPresent(String.self, forKey: .address_id)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        lat = try values.decodeIfPresent(String.self, forKey: .lat)
        lon = try values.decodeIfPresent(String.self, forKey: .lon)
        order_id = try values.decodeIfPresent(String.self, forKey: .order_id)
        price_type = try values.decodeIfPresent(String.self, forKey: .price_type)
        total_amount = try values.decodeIfPresent(String.self, forKey: .total_amount)
        before_discount_amount = try values.decodeIfPresent(String.self, forKey: .before_discount_amount)
        total_discount_amount = try values.decodeIfPresent(String.self, forKey: .total_discount_amount)
        payment_type = try values.decodeIfPresent(String.self, forKey: .payment_type)
        provider_amount = try values.decodeIfPresent(String.self, forKey: .provider_amount)
        admin_commission = try values.decodeIfPresent(String.self, forKey: .admin_commission)
        delivery_date = try values.decodeIfPresent(String.self, forKey: .delivery_date)
        delivery_time = try values.decodeIfPresent(String.self, forKey: .delivery_time)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        self_delivery_status = try values.decodeIfPresent(String.self, forKey: .self_delivery_status)
        delivery_status = try values.decodeIfPresent(String.self, forKey: .delivery_status)
        payment_status = try values.decodeIfPresent(String.self, forKey: .payment_status)
        payment_method = try values.decodeIfPresent(String.self, forKey: .payment_method)
        driver_id = try values.decodeIfPresent(String.self, forKey: .driver_id)
        accept_driver_id = try values.decodeIfPresent(String.self, forKey: .accept_driver_id)
        driver_offer_amount = try values.decodeIfPresent(String.self, forKey: .driver_offer_amount)
        bid_id = try values.decodeIfPresent(String.self, forKey: .bid_id)
        remove_status = try values.decodeIfPresent(String.self, forKey: .remove_status)
        delivery_fee = try values.decodeIfPresent(String.self, forKey: .delivery_fee)
        order_pin = try values.decodeIfPresent(String.self, forKey: .order_pin)
        pickup_address = try values.decodeIfPresent(String.self, forKey: .pickup_address)
        pickup_lat = try values.decodeIfPresent(String.self, forKey: .pickup_lat)
        pickup_lon = try values.decodeIfPresent(String.self, forKey: .pickup_lon)
        provider_note = try values.decodeIfPresent(String.self, forKey: .provider_note)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        time = try values.decodeIfPresent(String.self, forKey: .time)
        offer_id = try values.decodeIfPresent(String.self, forKey: .offer_id)
        offer_code = try values.decodeIfPresent(String.self, forKey: .offer_code)
        reason_title = try values.decodeIfPresent(String.self, forKey: .reason_title)
        reason_detail = try values.decodeIfPresent(String.self, forKey: .reason_detail)
        order_type = try values.decodeIfPresent(String.self, forKey: .order_type)
        direct_accepted = try values.decodeIfPresent(String.self, forKey: .direct_accepted)
        zone_id = try values.decodeIfPresent(String.self, forKey: .zone_id)
        zone_price = try values.decodeIfPresent(String.self, forKey: .zone_price)
        zone_name = try values.decodeIfPresent(String.self, forKey: .zone_name)
        user_note = try values.decodeIfPresent(String.self, forKey: .user_note)
        cancel_by_user = try values.decodeIfPresent(String.self, forKey: .cancel_by_user)
        cancel_reason = try values.decodeIfPresent(String.self, forKey: .cancel_reason)
        cart_details = try values.decodeIfPresent([Cart_details].self, forKey: .cart_details)
        address_details = try values.decodeIfPresent(Address_details.self, forKey: .address_details)
        product_details = try values.decodeIfPresent([Product_details].self, forKey: .product_details)
        provider_details = try values.decodeIfPresent(Provider_details.self, forKey: .provider_details)
        rating_review = try values.decodeIfPresent(String.self, forKey: .rating_review)
    }
}

struct Cart_details : Codable {
    let id : String?
    let user_id : String?
    let cat_id : String?
    let provider_id : String?
    let product_id : String?
    let product_name : String?
    let product_price : String?
    let quantity : String?
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
    }

}

struct Address_details : Codable {
    let id : String?
    let user_id : String?
    let title : String?
    let address : String?
    let lat : String?
    let lon : String?
    let addresstype : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case user_id = "user_id"
        case title = "title"
        case address = "address"
        case lat = "lat"
        case lon = "lon"
        case addresstype = "addresstype"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        lat = try values.decodeIfPresent(String.self, forKey: .lat)
        lon = try values.decodeIfPresent(String.self, forKey: .lon)
        addresstype = try values.decodeIfPresent(String.self, forKey: .addresstype)
    }

}

struct Product_details : Codable {
    let id : String?
    let admin_product_id : String?
    let provider_id : String?
    let cat_id : String?
    let cat_name : String?
    let item_name : String?
    let item_name_ar : String?
    let item_name_ur : String?
    let item_price : String?
    let offer_item_price : String?
    let item_description : String?
    let item_quantity : String?
    let colour : String?
    let brand : String?
    let unit_measurement : String?
    let weight : String?
    let product_size : String?
    let status : String?
    let type : String?
    let item_type : String?
    let description : String?
    let description_ar : String?
    let available_status : String?
    let date_time : String?
    let remove_status : String?
    let driver_choice : String?
    let direct_accepted : String?
    let vehicle_id : String?
    let order_method : String?
    let note_for_user : String?
    let note_for_user_ar : String?
    let service_type : String?
    let retnal_time : String?
    let per_month_price : String?
    let per_day_price : String?
    let per_hour_price : String?
    let quantity : String?
    let total_amount : String?
    let call:String?
    let chat:String?
    let product_images : [Product_images]?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case admin_product_id = "admin_product_id"
        case provider_id = "provider_id"
        case cat_id = "cat_id"
        case cat_name = "cat_name"
        case item_name = "item_name"
        case item_name_ar = "item_name_ar"
        case item_name_ur = "item_name_ur"
        case item_price = "item_price"
        case offer_item_price = "offer_item_price"
        case item_description = "item_description"
        case item_quantity = "item_quantity"
        case colour = "colour"
        case brand = "brand"
        case unit_measurement = "unit_measurement"
        case weight = "weight"
        case product_size = "product_size"
        case status = "status"
        case type = "type"
        case item_type = "item_type"
        case description = "description"
        case description_ar = "description_ar"
        case available_status = "available_status"
        case date_time = "date_time"
        case remove_status = "remove_status"
        case driver_choice = "driver_choice"
        case direct_accepted = "direct_accepted"
        case vehicle_id = "vehicle_id"
        case order_method = "order_method"
        case note_for_user = "note_for_user"
        case note_for_user_ar = "note_for_user_ar"
        case service_type = "service_type"
        case retnal_time = "retnal_time"
        case per_month_price = "per_month_price"
        case per_day_price = "per_day_price"
        case per_hour_price = "per_hour_price"
        case quantity = "quantity"
        case total_amount = "total_amount"
        case call = "call"
        case chat = "chat"
        case product_images = "product_images"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        admin_product_id = try values.decodeIfPresent(String.self, forKey: .admin_product_id)
        provider_id = try values.decodeIfPresent(String.self, forKey: .provider_id)
        cat_id = try values.decodeIfPresent(String.self, forKey: .cat_id)
        cat_name = try values.decodeIfPresent(String.self, forKey: .cat_name)
        item_name = try values.decodeIfPresent(String.self, forKey: .item_name)
        item_price = try values.decodeIfPresent(String.self, forKey: .item_price)
        offer_item_price = try values.decodeIfPresent(String.self, forKey: .offer_item_price)
        item_description = try values.decodeIfPresent(String.self, forKey: .item_description)
        item_quantity = try values.decodeIfPresent(String.self, forKey: .item_quantity)
        colour = try values.decodeIfPresent(String.self, forKey: .colour)
        brand = try values.decodeIfPresent(String.self, forKey: .brand)
        unit_measurement = try values.decodeIfPresent(String.self, forKey: .unit_measurement)
        weight = try values.decodeIfPresent(String.self, forKey: .weight)
        product_size = try values.decodeIfPresent(String.self, forKey: .product_size)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        item_type = try values.decodeIfPresent(String.self, forKey: .item_type)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        description_ar = try values.decodeIfPresent(String.self, forKey: .description_ar)
        available_status = try values.decodeIfPresent(String.self, forKey: .available_status)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
        remove_status = try values.decodeIfPresent(String.self, forKey: .remove_status)
        driver_choice = try values.decodeIfPresent(String.self, forKey: .driver_choice)
        direct_accepted = try values.decodeIfPresent(String.self, forKey: .direct_accepted)
        vehicle_id = try values.decodeIfPresent(String.self, forKey: .vehicle_id)
        order_method = try values.decodeIfPresent(String.self, forKey: .order_method)
        note_for_user = try values.decodeIfPresent(String.self, forKey: .note_for_user)
        note_for_user_ar = try values.decodeIfPresent(String.self, forKey: .note_for_user_ar)
        service_type = try values.decodeIfPresent(String.self, forKey: .service_type)
        retnal_time = try values.decodeIfPresent(String.self, forKey: .retnal_time)
        per_month_price = try values.decodeIfPresent(String.self, forKey: .per_month_price)
        per_day_price = try values.decodeIfPresent(String.self, forKey: .per_day_price)
        per_hour_price = try values.decodeIfPresent(String.self, forKey: .per_hour_price)
        quantity = try values.decodeIfPresent(String.self, forKey: .quantity)
        total_amount = try values.decodeIfPresent(String.self, forKey: .total_amount)
        call = try values.decodeIfPresent(String.self, forKey: .call)
        chat = try values.decodeIfPresent(String.self, forKey: .chat)
        product_images = try values.decodeIfPresent([Product_images].self, forKey: .product_images)
        item_name_ar = try values.decodeIfPresent(String.self, forKey: .item_name_ar)
        item_name_ur = try values.decodeIfPresent(String.self, forKey: .item_name_ur)
    }

}
