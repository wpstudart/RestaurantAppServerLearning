//
//  Menu.swift
//  Restaurant
//
//  Created by Aluno on 23/05/2018.
//  Copyright © 2018 wpstudart. All rights reserved.
//

import UIKit

struct MenuItem: Codable {
    var id: Int
    var name: String
    var description: String
    var price: Double
    var category: String
    var imageURL: URL
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case price
        case category
        case imageURL = "image_url"
    }
}

struct MenuItems: Codable {
    let items: [MenuItem]
}
