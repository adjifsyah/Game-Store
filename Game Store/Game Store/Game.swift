//
//  Game.swift
//  Game Store
//
//  Created by Adji Firmansyah on 29/07/20.
//  Copyright © 2020 Dicoding. All rights reserved.
//

import Foundation

struct Response: Codable {
    var results: [GAME]
}
 
struct GAME: Codable {
    let id: Int
    let count = UUID()
    let name: String
    let released: String
    let RatingTop: Int
    let backgroundImage: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case count
        case name
        case released
        case RatingTop = "rating_top"
        case backgroundImage = "background_image"
    }
    init() {}
}
