//
//  QuestionCell.swift
//  IGListKitQuestionDemo
//
//  Created by Yevhen Dubinin on 1/11/25.
//

import UIKit

final class QuestionCell: UICollectionViewCell {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left // Align text to the left like a header
        label.numberOfLines = 0 // Support multiline text
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.preferredFont(forTextStyle: .headline) // Use a bold, larger font
        return label
    }()

    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left // Align text to the left like a header
        label.numberOfLines = 0 // Support multiline text
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.preferredFont(forTextStyle: .subheadline) // Use a bold, larger font
        label.textColor = .red
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear // No custom background color
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16), // Add left padding
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16), // Add right padding
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8), // Add top padding
        ])
        NSLayoutConstraint.activate([
            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16), // Add left padding
            subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16), // Add right padding
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8), // Add top padding
            subtitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8) // Add bottom padding
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        subtitleLabel.text = nil
    }

    // MARK: - Configuration

    func configure(with title: String, subtitle: String = "") {
        titleLabel.text = title
        subtitleLabel.text = subtitle
    }
}

