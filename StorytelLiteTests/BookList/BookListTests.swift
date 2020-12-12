//
//  BookListTests.swift
//  StorytelLiteTests
//
//  Created by Alex Kravchenko on 12.12.2020.
//

import Quick
import Nimble
@testable import StorytelLite

final class BookListTests: QuickSpec {
    private typealias BookPreviewModelType = BookPreviewModel<BookAuthorModel, BookNarratorModel, BookCoverModel>
    private let interactor = MockedBookListInteractor()
    private let interactorDelegate = MockedBookListInteractorDelegateImpl()

    override func spec() {
        describe("Book List Mocks") {
            context("when accessing contents of the mocked books") {
                it("can be read") {
                    expect(try Data(contentsOf: R.file.bookListMockJson.url()!)).toNot(throwError())
                }

                it("decoded correctly") {
                    do {
                        let mockedBooks = try Data(contentsOf: R.file.bookListMockJson.url()!)
                        let books = try JSONDecoder().decode(PaginatedResponseModel<BookPreviewModelType>.self,
                                                             from: mockedBooks)
                        expect(books.items).toNot(beEmpty())
                    } catch {
                        fail(error.localizedDescription)
                    }
                }
            }
        }

        describe("Book List Interactor") {
            let query = "hello world!"

            beforeEach {
                self.interactor.delegate = self.interactorDelegate
                self.interactor.requestBooks(query: query)
            }
    
            context("when requested books") {
                it("fetched correctly") {
                    let booksFetched = self.interactorDelegate.props.books.count
                    expect(booksFetched).to(equal(10))
                }

                it("searched query saved") {
                    let searchQuery = self.interactorDelegate.props.searchQuery
                    expect(searchQuery).to(equal(query))
                }

                it("pagination model updated") {
                    let nextPageToken = self.interactor.pagination.nextPageToken
                    expect(nextPageToken).toNot(beNil())
                    expect(self.interactor.pagination.shouldLoadNext()).to(beTrue())
                }
            }
        }
    }
}
