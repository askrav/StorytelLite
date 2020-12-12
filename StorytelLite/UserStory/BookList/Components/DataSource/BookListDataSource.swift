//
//  BookListDataSource.swift
//  StorytelLite
//
//  Created by Alex Kravchenko on 11.12.2020.
//

import UIKit

final class BookListDataSource: UITableViewDiffableDataSource<BookListView.Section, BookListView.Item> {
    private typealias Item = BookListView.Item
    private typealias Section = BookListView.Section

    private lazy var queue: DispatchQueue = DispatchQueue(label: "\(self)_Queue", qos: .userInteractive)

    private var props = BookListInteractorProps()

    func apply(props: BookListInteractorProps, animated: Bool = true) {
        queue.async { [weak self] in
            self?.props = props
            self?.reloadData(animatingDifferences: animated)
        }
    }

    private func reloadData(animatingDifferences: Bool) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.books])
        snapshot.appendItems(props.books.map { Item.book(model: $0) })
        queue.async { [weak self] in
            self?.apply(snapshot, animatingDifferences: animatingDifferences)
        }
    }
}
