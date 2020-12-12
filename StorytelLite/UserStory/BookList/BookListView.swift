//
//  BookListView.swift
//  StorytelLite
//
//  Created by Alex Kravchenko on 10.12.2020.
//

import UIKit
import SnapKit

protocol BookListViewDelegate: class {
    func tableViewDidReachEnd()
}

final class BookListView: UIView {
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.hidesWhenStopped = true
        return indicator
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 100
        tableView.delegate = self
        tableView.backgroundColor = .white
        tableView.alwaysBounceVertical = true
        tableView.tableFooterView = loadingIndicator
        headerView.frame = CGRect(x: 0, y: 0, width: frame.width, height: 200)
        tableView.tableHeaderView = headerView
        tableView.backgroundColor = Color.backgroundColor()
        return tableView
    }()

    private let headerView = BookListViewHeader()

    private var dataSource: BookListDataSource?

    weak var delegate: BookListViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        registerCells()
        configureDataSource()
    }

    required init?(coder: NSCoder) {
        nil
    }
    
    func show(props: BookListInteractorProps, animated: Bool = true) {
        props.loading ? loadingIndicator.startAnimating() : loadingIndicator.stopAnimating()
        headerView.update(title: props.searchQuery)
        dataSource?.apply(props: props, animated: animated)
    }
}

// MARK: - Configuration
private extension BookListView {
    func configureUI() {
        backgroundColor = Color.backgroundColor()
        addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    func registerCells() {
        tableView.register(cell: BookListTableCell.self)
    }

    func configureDataSource() {
        dataSource = BookListDataSource(tableView: tableView, cellProvider: { (tableView, indexPath, item) -> UITableViewCell? in
            switch item {
            case .book(let model):
                guard let cell: BookListTableCell = tableView.dequeueReusableCell(for: indexPath) else { break }
                cell.update(with: model)
                return cell
            }
            return nil
        })
    }
}

// MARK: - UITableViewDelegate
extension BookListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updatePagination(scrollView)
    }
}

// MARK: - Pagination
private extension BookListView {
    func updatePagination(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y + scrollView.frame.height
        if scrollView.contentSize.height - offset <= 50 {
            delegate?.tableViewDidReachEnd()
        }
    }
}

extension BookListView {
    enum Section: Hashable {
        case books
    }

    enum Item: Hashable {
        case book(model: BookListTableCellViewModel)
    }
}
