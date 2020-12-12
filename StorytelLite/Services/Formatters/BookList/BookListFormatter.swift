//
//  BookListFormatter.swift
//  StorytelLite
//
//  Created by Alex Kravchenko on 11.12.2020.
//

import Foundation

protocol BookListFormatterRepresentable {
    func formattedAuthors<Author: BookAuthorModelRepresentable>(_ authors: [Author]) -> String
    func formattedNarrators<Narrator: BookNarratorModelRepresentable>(_ narrators: [Narrator]) -> String
}

struct BookListFormatter: BookListFormatterRepresentable {
    func formattedAuthors<Author: BookAuthorModelRepresentable>(_ authors: [Author]) -> String {
        guard !authors.isEmpty else { return "" }
        var result = Localizable.by() + " " + authors.reduce("", { $0 + $1.name.capitalized + ", " })
        result.removeLast(2)
        return result
    }

    func formattedNarrators<Narrator: BookNarratorModelRepresentable>(_ narrators: [Narrator]) -> String {
        guard !narrators.isEmpty else { return "" }
        var result = Localizable.with() + " " + narrators.reduce("", { $0 + $1.name.capitalized + ", " })
        result.removeLast(2)
        return result
    }
}
