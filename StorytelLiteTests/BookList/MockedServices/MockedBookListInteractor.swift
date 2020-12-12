//
//  MockedBookListInteractor.swift
//  StorytelLiteTests
//
//  Created by Alex Kravchenko on 12.12.2020.
//

import Foundation
@testable import StorytelLite

final class MockedBookListInteractorDelegateImpl: BookListInteractorDelegate {
    var props = BookListInteractorProps()

    func didUpdateProps(_ props: BookListInteractorProps) {
        self.props = props
    }

    func showError(_ error: BookListInteractor.ServiceError) {}
}

final class MockedBookListInteractor: BookListInteractorRepresentable {
    var pagination = PaginationModel()
    var props = BookListInteractorProps()
    let formatter = BookListFormatter()
    weak var delegate: BookListInteractorDelegate?

    func requestBooks(query: String) {
        props.searchQuery = query
        do {
            let data = try Data(contentsOf: R.file.bookListMockJson.url()!)
            let response = try JSONDecoder().decode(PaginatedResponseModel<BookPreviewModelType>.self, from: data)
            pagination.update(page: response.nextPageToken)
            update(books: response.items)
            delegate?.didUpdateProps(props)
        } catch {
            delegate?.showError(.general(error: error))
        }
    }

    private func update(books: [BookPreviewModelType]) {
        let bookModels = books.map {
            BookListTableCellViewModel(id: $0.id,
                                       imageURL: $0.cover.url,
                                       bookTitle: $0.title,
                                       narrators: formatter.formattedNarrators($0.narrators),
                                       authors: formatter.formattedAuthors($0.authors))
        }
        props.books += bookModels
    }
}
