//
//  PhotoModel.swift
//  com.MariusDAMIEN.iOS-test-task
//
//  Created by MacBook Pro on 10/09/2021.
//

import Foundation

// PHOTOS MODEL
struct Photo: Decodable {
    let id: Int
    let albumId: Int
    let url: String
    let title: String
}
