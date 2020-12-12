//
//  BooksAPI.swift
//  StorytelLite
//
//  Created by Alex Kravchenko on 10.12.2020.
//

import Moya

final class BooksAPIService: MoyaProvider<BooksAPI> {}

enum BooksAPI: TargetType {
    case searchBooks(query: String, page: String?)

    var baseURL: URL {
        URL(string: "https://api.storytel.net/")!
    }

    var path: String {
        switch self {
        case .searchBooks:
            return "search"
        }
    }

    var method: Method {
        switch self {
        case .searchBooks:
            return .get
        }
    }

    var sampleData: Data {
        switch self {
        case .searchBooks:
            return Data()
        }
    }

    var task: Task {
        switch self {
        case .searchBooks:
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }

    var headers: [String : String]? {
        nil
    }
    
    private var parameters: [String: Any] {
        switch self {
        case .searchBooks(let query, let page):
            var data: [String: Any] = ["query": query.lowercased()]
            if let pageToken = page {
                data["page"] = pageToken
            }
            return data
        }
    }
}
