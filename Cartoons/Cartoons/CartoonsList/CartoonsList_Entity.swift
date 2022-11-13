//
//  CartoonsList_Entity.swift
//  Cartoons
//
//  Created by Supapon Pucknavin on 13/11/2565 BE.
//

import Foundation

struct Cartoon: Decodable {
    let title: String
    let year: Int
    let creator: [String]
    let rating: String
    let genre: [String]
    let runtime_in_minutes: Int
    let episodes: Int
    let image: String
    let id: Int
}
