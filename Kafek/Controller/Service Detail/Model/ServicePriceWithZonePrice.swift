//
//  ServicePriceWithZonePrice.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 09/04/25.
//

import Foundation

struct Api_ServicePriceWithZonePrice : Codable {
    let zone_id : String?
    let zone_price_id : String?
    let zone_price : String?
    let zone_name : String?
    let final_price : String?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case zone_id = "zone_id"
        case zone_price_id = "zone_price_id"
        case zone_price = "zone_price"
        case zone_name = "zone_name"
        case final_price = "final_price"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        zone_id = try values.decodeIfPresent(String.self, forKey: .zone_id)
        zone_price_id = try values.decodeIfPresent(String.self, forKey: .zone_price_id)
        zone_price = try values.decodeIfPresent(String.self, forKey: .zone_price)
        zone_name = try values.decodeIfPresent(String.self, forKey: .zone_name)
        final_price = try values.decodeIfPresent(String.self, forKey: .final_price)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}
