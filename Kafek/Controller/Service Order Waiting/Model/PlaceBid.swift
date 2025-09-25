//
//  PlaceBid.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 18/02/25.
//

import Foundation

struct Api_PlaceBid : Codable {
    let result : [Res_PlaceBid]?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent([Res_PlaceBid].self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct Res_PlaceBid : Codable {
    let id : String?
    let driver_id : String?
    let order_user_id : String?
    let order_id : String?
    let amount : String?
    let total_amount : String?
    let item_count : String?
    let status : String?
    let date_time : String?
    let distance : Int?
    let message_count : String?
    let driver_details : Driver_details?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case driver_id = "driver_id"
        case order_user_id = "order_user_id"
        case order_id = "order_id"
        case amount = "amount"
        case total_amount = "total_amount"
        case item_count = "item_count"
        case status = "status"
        case date_time = "date_time"
        case distance = "distance"
        case message_count = "message_count"
        case driver_details = "driver_details"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        driver_id = try values.decodeIfPresent(String.self, forKey: .driver_id)
        order_user_id = try values.decodeIfPresent(String.self, forKey: .order_user_id)
        order_id = try values.decodeIfPresent(String.self, forKey: .order_id)
        amount = try values.decodeIfPresent(String.self, forKey: .amount)
        total_amount = try values.decodeIfPresent(String.self, forKey: .total_amount)
        item_count = try values.decodeIfPresent(String.self, forKey: .item_count)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
        distance = try values.decodeIfPresent(Int.self, forKey: .distance)
        message_count = try values.decodeIfPresent(String.self, forKey: .message_count)
        driver_details = try values.decodeIfPresent(Driver_details.self, forKey: .driver_details)
    }
}
