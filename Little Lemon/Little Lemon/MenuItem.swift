//
//  MenuItem.swift
//  Little Lemon
//
//  Created by Kevin Troyan on 10/30/23.
//

import Foundation

struct MenuItem: Decodable {
    let title: String
    let image: String
    let price: String
    let descriptionDish: String
    let category: String
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case descriptionDish = "description"
        case price = "price"
        case image = "image"
        case category = "category"
    }
}
