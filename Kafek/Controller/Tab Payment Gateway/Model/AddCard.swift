//
//  AddCard.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 10/04/25.
//

import Foundation

struct Api_AddCardForPayment : Codable {
    let result : Res_AddCardForPayment?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent(Res_AddCardForPayment.self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct Res_AddCardForPayment : Codable {
    let id : String?
    let user_id : String?
    let name : String?
    let account_number : String?
    let exp_month : String?
    let exp_year : String?
    let cvc : String?
    let date_time : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case user_id = "user_id"
        case name = "name"
        case account_number = "account_number"
        case exp_month = "exp_month"
        case exp_year = "exp_year"
        case cvc = "cvc"
        case date_time = "date_time"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        account_number = try values.decodeIfPresent(String.self, forKey: .account_number)
        exp_month = try values.decodeIfPresent(String.self, forKey: .exp_month)
        exp_year = try values.decodeIfPresent(String.self, forKey: .exp_year)
        cvc = try values.decodeIfPresent(String.self, forKey: .cvc)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
    }

}
