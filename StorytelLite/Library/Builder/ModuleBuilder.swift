//
//  ModuleBuilder.swift
//  StorytelLite
//
//  Created by Alex Kravchenko on 12.12.2020.
//

import UIKit

protocol ModuleBuilder {
    associatedtype Controller: UIViewController
    associatedtype Interactor: Any

    func build() -> Controller
}
