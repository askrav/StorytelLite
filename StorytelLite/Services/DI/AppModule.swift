//
//  AppModule.swift
//  StorytelLite
//
//  Created by Alex Kravchenko on 12.12.2020.
//

import Swinject

protocol AppModule {
    func load()
    func shouldLoadModule() -> Bool
}

struct AppContainer {
    static var current: Swinject.Container = Container()
}
