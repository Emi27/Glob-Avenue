//
//  Automobile.swift
//  Glob Avenue
//
//  Created by Imran Malik on 27/03/20.
//  Copyright © 2020 Era. All rights reserved.
//

import UIKit

// MARK: - Automobile
struct Automobile: Hashable, GlobCodable {
    var displayContact: [String]?
    var id, email, name, mobile: String?
    var userID, address, category, keywords: String?
    var automobileDescription, fuel, make, model: String?
    var seller, engine, variant, mileage: String?
    var gearType, condition, horsePower, emissionClass: String?
    var registrationYear, doors, seats, price: String?
    var color, warranty, location, currency: String?
    var accessories, interiorSeats, equipmentDescription, status: String?
    var paymentStatus, createdAt, video: String?
    var v: Int?

    enum CodingKeys: String, CodingKey {
        case displayContact = "display_contact"
        case id = "_id"
        case email, name, mobile
        case userID = "user_id"
        case address, category, keywords
        case automobileDescription = "description"
        case fuel, make, model, seller, engine, variant, mileage
        case gearType = "gear_type"
        case condition
        case horsePower = "horse_power"
        case emissionClass = "emission_class"
        case registrationYear = "registration_year"
        case doors, seats, price, color, warranty, location, currency, accessories
        case interiorSeats = "interior_seats"
        case equipmentDescription = "equipment_description"
        case status
        case paymentStatus = "payment_status"
        case createdAt = "created_at"
        case v = "__v"
        case video = "base64_video"
    }
}
