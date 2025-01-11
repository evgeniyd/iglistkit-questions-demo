//
//  QuestionOptionCell.swift
//  IGListKitQuestionDemo
//
//  Created by Yevhen Dubinin on 1/10/25.
//

import UIKit

final class OptionCell: UICollectionViewCell {

    override var isSelected: Bool {
        didSet {
            contentView.backgroundColor = isSelected ? UIColor.systemBlue : UIColor.secondarySystemBackground
        }
    }

    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        // Configure the appearance
        contentView.backgroundColor = .secondarySystemBackground
        contentView.layer.borderColor = UIColor.systemGray.cgColor // Border color
        contentView.layer.borderWidth = 1 // 1px border
        contentView.layer.cornerRadius = 20 // Default radius for pill shape
        contentView.layer.masksToBounds = true // Ensure the rounded corners are applied

        // Add the label
        contentView.addSubview(label)

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4)
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

