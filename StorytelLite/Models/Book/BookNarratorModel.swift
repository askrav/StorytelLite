//
//  BookNarratorModel.swift
//  StorytelLite
//
//  Created by Alex Kravchenko on 10.12.2020.
//

import Foundation

protocol BookNarratorModelRepresentable {
    var id: String { get }
    var name: String { get }
}

struct BookNarratorModel: BookNarratorModelRepresentable, Decodable {
    var id: String
    var name: String
}
