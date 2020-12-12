//
//  BookListViewHeader.swift
//  StorytelLite
//
//  Created by Alex Kravchenko on 11.12.2020.
//

import UIKit

final class BookListViewHeader: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 34)
        label.textColor = .white
        return label
    }()

    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: Image.bookListHeaderBackgroundIcon())
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    private let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .systemThinMaterial))

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        nil
    }

    func update(title: String) {
        titleLabel.text = Localizable.query().capitalized + ": " + title
    }
}

// MARK: - UI Configuration
private extension BookListViewHeader {
    func configureUI() {
        addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        backgroundImageView.addSubview(blurView)
        blurView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        blurView.contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
