//
//  BookCoverModel.swift
//  StorytelLite
//
//  Created by Alex Kravchenko on 10.12.2020.
//

import Foundation

protocol BookCoverModelRepresentable {
    var url: URL { get }
}

struct BookCoverModel: BookCoverModelRepresentable, Decodable {
    var url: URL
}
