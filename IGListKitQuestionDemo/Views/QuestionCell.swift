//
//  QuestionCell.swift
//  IGListKitQuestionDemo
//
//  Created by Yevhen Dubinin on 1/11/25.
//

import UIKit

final class QuestionCell: UICollectionViewCell {
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left // Align text to the left like a header
        label.numberOfLines = 0 // Support multiline text
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.preferredFont(forTextStyle: .headline) // Use a bold, larger font
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear // No custom background color
        contentView.addSubview(label)

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16), // Add left padding
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16), // Add right padding
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8), // Add top padding
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8) // Add bottom padding
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
    }

    // MARK: - Configuration

    func configure(with text: String) {
        label.text = text
    }
}

