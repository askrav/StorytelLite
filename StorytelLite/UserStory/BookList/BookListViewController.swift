//
//  BookListViewController.swift
//  StorytelLite
//
//  Created by Alex Kravchenko on 10.12.2020.
//

import UIKit

final class BookListViewController: UIViewController {
    private var interactor: BookListInteractorRepresentable
    private let contentView = BookListView()

    private var searchQuery: String = "Harry"

    init(interactor: BookListInteractorRepresentable) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        nil
    }

    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.delegate = self
        interactor.delegate = self
        interactor.requestBooks(query: searchQuery)
    }
}

extension BookListViewController: BookListInteractorDelegate {
    func didUpdateProps(_ props: BookListInteractorProps) {
        contentView.show(props: props)
    }

    func showError(_ error: BookListInteractor.ServiceError) {
        showError(message: error.localizedMessage)
    }
}

extension BookListViewController: BookListViewDelegate {
    func tableViewDidReachEnd() {
        interactor.requestBooks(query: searchQuery)
    }
}
