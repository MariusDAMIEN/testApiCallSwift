//
//  UserModel.swift
//  com.MariusDAMIEN.iOS-test-task
//
//  Created by MacBook Pro on 10/09/2021.
//

import Foundation

// ADDRESS MODEL
struct Address: Decodable {
    let street: String?
    let suite: String?
    let city: String?
    let zipcode: String?
}

// USER MODEL
struct User: Decodable {
    let id: Int?
    let name: String?
    let address: Address?
}
