//
//  CommonModule.swift
//  StorytelLite
//
//  Created by Alex Kravchenko on 12.12.2020.
//

import Swinject

final class CommonModule: AppModule {
    private(set) var container: Swinject.Container
    
    init(container: Swinject.Container) {
        self.container = container
    }

    func load() {
        registerFormatters()
        registerAPIServices()
    }

    func shouldLoadModule() -> Bool {
        true
    }

    private func registerFormatters() {
        container.register(BookListFormatterRepresentable.self, factory: { _ in BookListFormatter() })
    }

    private func registerAPIServices() {
        container.register(BooksAPIService.self) { _ in BooksAPIService() }.inObjectScope(.container)
    }
}
