//
//  GlobalVariable.swift
//  Kafek
//
//  Created by Techimmense Software Solutions on 18/02/25.
//

import Foundation
import UIKit

var globalUserName          =       k.userDefault.value(forKey: "user_name")
var globalUserImage         =       k.userDefault.value(forKey: "user_image")

var isLogout:Bool = false

var is_Navigate:String!

var localTimeZoneIdentifier: String { return
    TimeZone.current.identifier }

var dictSignup:[String:AnyObject] = [:]

struct dataModel {
    var selectedName : String
    var selectedPrice : String
}

enum emLang: String {
    case en
    case ar
}
var cLang: emLang = .en

enum Status: String {
    case open = "OPEN"
    case close = "CLOSE"
}

struct TimeSlot {
    var open_day: String?
    var open_time: String?
    var close_time: String?
    var status: Status
}

var CURRENT_TIME: String {
    get {
        return Date().description(with: Locale.current)
    }
}

var offerAcceptOrRejectByUser:Bool = false
