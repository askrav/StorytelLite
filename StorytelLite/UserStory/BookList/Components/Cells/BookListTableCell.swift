//
//  BookListTableCell.swift
//  StorytelLite
//
//  Created by Alex Kravchenko on 10.12.2020.
//

import UIKit

struct BookListTableCellViewModel: Hashable {
    let id: String
    let imageURL: URL
    let bookTitle: String
    let narrators: String
    let authors: String

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

final class BookListTableCell: UITableViewCell {
    private lazy var bookImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        return imageView
    }()

    private let bookTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()

    private let bookAuthorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()

    private let bookNarratorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }

    required init?(coder: NSCoder) {
        nil
    }

    func update(with model: BookListTableCellViewModel) {
        bookImageView.loadImage(url: model.imageURL)
        bookTitleLabel.text = model.bookTitle
        bookAuthorLabel.text = model.authors
        bookNarratorLabel.text = model.narrators
    }
}

// MARK: - UI Configuration
private extension BookListTableCell {
    func configureUI() {
        contentView.addSubview(bookImageView)
        bookImageView.snp.makeConstraints {
            $0.size.equalTo(86)
            $0.leading.equalToSuperview().offset(8)
            $0.centerY.equalToSuperview()
        }

        contentView.addSubview(bookTitleLabel)
        bookTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(bookImageView.snp.trailing).offset(16)
            $0.top.equalTo(bookImageView).offset(6)
            $0.trailing.equalToSuperview().inset(6)
        }

        contentView.addSubview(bookAuthorLabel)
        bookAuthorLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(bookTitleLabel)
            $0.top.equalTo(bookTitleLabel.snp.bottom).offset(8)
        }

        contentView.addSubview(bookNarratorLabel)
        bookNarratorLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(bookTitleLabel)
            $0.top.equalTo(bookAuthorLabel.snp.bottom).offset(8)
        }
    }
}
