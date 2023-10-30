//
//  MenuItem.swift
//  Little Lemon
//
//  Created by Kevin Troyan on 10/30/23.
//

import Foundation

struct MenuItem : Codable {
    var id = UUID()
    let title: String
    let image: String
    let price: String
}
