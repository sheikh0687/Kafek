//
//  AddToCart.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 07/02/25.
//

import Foundation

struct Api_AddToCart : Codable {
    let quantity : String?
    let result : String?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case quantity = "quantity"
        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        quantity = try values.decodeIfPresent(String.self, forKey: .quantity)
        result = try values.decodeIfPresent(String.self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}
