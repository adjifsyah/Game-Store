//
//  Game.swift
//  Game Store
//
//  Created by Adji Firmansyah on 29/07/20.
//  Copyright © 2020 Dicoding. All rights reserved.
//

import Foundation

struct Response: Codable {
    var results: [Game]
}

struct Game: Codable {
    var id: Int32?
    var count: Int?
    var name: String?
    var nameOriginal: String?
    var released: String?
    var rating = Float("4.59")
    var description: String?
    var search: String?
    var backgroundImage: String?
    var imageBackground: String?
    var genres = [Games]()
    
    enum CodingKeys: String, CodingKey {
        case id
        case count
        case name
        case nameOriginal = "name_original"
        case released
        case rating
        case description
        case search
        case backgroundImage = "background_image"
        case imageBackground = "image_background"
        case genres
    }
    
    init() {
        
    }
    
}
struct Games: Codable {
    var id: Int?
    var name: String?
    var slug: String?
    var gamesCount : Int?
    var imageBackground: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case slug
        case gamesCount = "games_count"
        case imageBackground = "image_background"
    }
}
