//
//  BookAuthorModel.swift
//  StorytelLite
//
//  Created by Alex Kravchenko on 10.12.2020.
//

import Foundation

protocol BookAuthorModelRepresentable {
    var id: String { get }
    var name: String { get }
}

struct BookAuthorModel: BookAuthorModelRepresentable, Decodable {
    var id: String
    var name: String
}
