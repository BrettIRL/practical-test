//
//  Author.swift
//  iOS Practical Code Test
//
//  Created by Brett Cocking on 2018/10/20.
//  Copyright © 2018 Trademark Technology. All rights reserved.
//

import Foundation

struct Author: Codable {
    let name: String
    let image: String
    let reputation: Int
    
    enum CodingKeys: String, CodingKey {
        case name = "display_name"
        case image = "profile_image"
        case reputation
    }
}
