//
//  PaginatedResponseModel.swift
//  StorytelLite
//
//  Created by Alex Kravchenko on 10.12.2020.
//

import Foundation

struct PaginatedResponseModel<Item>: Decodable where Item: Decodable {
    let nextPageToken: String?
    let totalCount: Int
    let items: [Item]
}

struct PaginationModel {
    private var initiallyLoaded = false
    private(set) var nextPageToken: String? = nil

    func shouldLoadNext() -> Bool {
        !initiallyLoaded || nextPageToken != nil
    }

    mutating func update(page: String?) {
        nextPageToken = page
        initiallyLoaded = true
    }

    mutating func reset() {
        initiallyLoaded = false
        nextPageToken = nil
    }
}
