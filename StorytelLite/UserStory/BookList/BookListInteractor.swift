//
//  BookListInteractor.swift
//  StorytelLite
//
//  Created by Alex Kravchenko on 10.12.2020.
//

import Moya

protocol BookListInteractorDelegate: class {
    func didUpdateProps(_ props: BookListInteractorProps)
    func showError(_ error: BookListInteractor.ServiceError)
}

protocol BookListInteractorRepresentable {
    var delegate: BookListInteractorDelegate? { get set }

    func requestBooks(query: String)
}

typealias BookPreviewModelType = BookPreviewModel<BookAuthorModel, BookNarratorModel, BookCoverModel>

final class BookListInteractor: BookListInteractorRepresentable {
    private let booksService: BooksAPIService
    private let formatter: BookListFormatterRepresentable

    private var pagination = PaginationModel()
    private var props = BookListInteractorProps()

    weak var delegate: BookListInteractorDelegate?

    init(booksService: BooksAPIService, formatter: BookListFormatterRepresentable) {
        self.booksService = booksService
        self.formatter = formatter
    }
}

// MARK: - request books
extension BookListInteractor {
    func requestBooks(query: String) {
        guard pagination.shouldLoadNext(), !props.loading else { return }

        props.searchQuery = query
        props.loading = true
        delegate?.didUpdateProps(props)

        booksService.request(.searchBooks(query: query, page: pagination.nextPageToken)) { [weak self] response in
            guard let `self` = self else { return }

            self.props.loading = false

            switch response {
            case .success(let data):
                do {
                    let model = try data.map(PaginatedResponseModel<BookPreviewModelType>.self)
                    self.pagination.update(page: model.nextPageToken)
                    self.update(books: model.items)
                } catch {
                    self.delegate?.showError(.cannotDecodeResponse)
                }
            case .failure(let error):
                self.delegate?.showError(.general(error: error))
            }

            self.delegate?.didUpdateProps(self.props)
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

// MARK: - Error
extension BookListInteractor {
    enum ServiceError: Error {
        case cannotDecodeResponse
        case general(error: Error)

        var localizedMessage: String {
            switch self {
            case .cannotDecodeResponse:
                return Localizable.errorGeneralLocalizedMessage()
            case .general(let error):
                return error.localizedDescription
            }
        }
    }
}

// MARK: - Props
struct BookListInteractorProps {
    var searchQuery: String = ""
    var books: [BookListTableCellViewModel] = []
    var loading: Bool = false
}
