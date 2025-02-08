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
            pillView.backgroundColor = isSelected ? .systemBlue : .secondarySystemBackground
        }
    }

    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()

    let pillView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        // Configure the appearance
        view.backgroundColor = .secondarySystemBackground
        view.layer.borderColor = UIColor.systemGray.cgColor // Border color
        view.layer.borderWidth = 1 // 1px border
        view.layer.masksToBounds = true // Ensure the rounded corners are applied
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        // Add background view
        contentView.addSubview(pillView)

        // Add the label
        contentView.addSubview(label)

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 8),
            label.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -8),
            label.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 4),
            label.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -4),
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])

        NSLayoutConstraint.activate([
            pillView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            pillView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            pillView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            pillView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
        ])

        pillView.setNeedsDisplay()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        pillView.layer.cornerRadius = pillView.bounds.height / 2.0
    }

    // MARK: - Configuration

    func configure(with text: String) {
        label.text = text
    }
}

