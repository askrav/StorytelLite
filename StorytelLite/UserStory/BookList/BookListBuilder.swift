//
//  BookListBuilder.swift
//  StorytelLite
//
//  Created by Alex Kravchenko on 10.12.2020.
//

import Swinject
import SwinjectAutoregistration

struct BookListBuilder: ModuleBuilder {
    typealias Controller = BookListViewController
    typealias Interactor = BookListInteractorRepresentable

    private let resolver: Swinject.Resolver

    init(resolver: Swinject.Resolver) {
        self.resolver = resolver
    }

    func build() -> BookListViewController {
        let interactor = BookListInteractor(booksService: resolver~>, formatter: resolver~>)
        let controller = BookListViewController(interactor: interactor)
        return controller
    }
}
