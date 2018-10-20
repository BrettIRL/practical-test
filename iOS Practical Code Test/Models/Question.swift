//
//  Question.swift
//  iOS Practical Code Test
//
//  Created by Brett Cocking on 2018/10/20.
//  Copyright © 2018 Trademark Technology. All rights reserved.
//

import Foundation

struct SearchResults: Codable {
    let questions: [Question]
    
    enum CodingKeys: String, CodingKey {
        case questions = "items"
    }
}

struct Question: Codable {
    let title: String
    let body: String
    let tags: [String]
    let votes: Int
    let answers: Int
    let views: Int
    let answered: Bool
    let date: Date
    let author: Author
    
    enum CodingKeys: String, CodingKey {
        case title
        case body
        case tags
        case votes = "score"
        case answers = "answer_count"
        case views = "view_count"
        case answered = "is_answered"
        case date = "creation_date"
        case author = "owner"
    }
}
