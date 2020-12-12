//
//  BookPreviewModel.swift
//  StorytelLite
//
//  Created by Alex Kravchenko on 10.12.2020.
//

import Foundation

protocol BookPreviewModelRepresentable {
    associatedtype Author: BookAuthorModelRepresentable
    associatedtype Narrator: BookNarratorModelRepresentable
    associatedtype Cover: BookCoverModelRepresentable

    var id: String { get }
    var title: String { get }
    var cover: Cover { get }
    var authors: [Author] { get }
    var narrators: [Narrator] { get }
}

struct BookPreviewModel<Author, Narrator, Cover>: BookPreviewModelRepresentable, Decodable
where Author: BookAuthorModelRepresentable & Decodable,
      Narrator: BookNarratorModelRepresentable & Decodable,
      Cover: BookCoverModelRepresentable & Decodable {

    let id: String
    let title: String
    let cover: Cover
    let authors: [Author]
    let narrators: [Narrator]
}
