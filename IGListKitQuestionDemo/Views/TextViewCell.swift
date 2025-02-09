//
//  TextViewCell.swift
//  IGListKitQuestionDemo
//
//  Created by Yevhen Dubinin on 2/8/25.
//

import UIKit

final class TextViewCell: UICollectionViewCell, UITextViewDelegate {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textColor = .black
        return label
    }()

    private let textField: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.borderColor = UIColor.gray.cgColor
        textView.layer.borderWidth = 1.0
        textView.layer.cornerRadius = 8.0
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        textView.font = UIFont.systemFont(ofSize: 16)
        return textView
    }()

    private let placeholderLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.textColor = .red
        return label
    }()

    // Create a layout guide to reserve space for the subtitle.
    private let subtitleSpaceGuide = UILayoutGuide()

    private var onTextDidChange: ((String) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear

        contentView.addSubview(titleLabel)
        contentView.addSubview(textField)
        textField.addSubview(placeholderLabel)
        contentView.addSubview(subtitleLabel)
        // Add the custom layout guide.
        contentView.addLayoutGuide(subtitleSpaceGuide)

        titleLabel.setContentHuggingPriority(.required, for: .vertical)
        textField.setContentHuggingPriority(.defaultLow, for: .vertical)
        subtitleLabel.setContentHuggingPriority(.required, for: .vertical)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8)
        ])

        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8)
        ])

        NSLayoutConstraint.activate([
            subtitleSpaceGuide.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            subtitleSpaceGuide.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            subtitleSpaceGuide.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 8),
            // Set a minimum height—for example, 20 points.
            subtitleSpaceGuide.heightAnchor.constraint(greaterThanOrEqualToConstant: 20),
            // Pin the bottom of the layout guide to the cell's bottom.
            subtitleSpaceGuide.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])

        NSLayoutConstraint.activate([
            subtitleLabel.leadingAnchor.constraint(equalTo: subtitleSpaceGuide.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: subtitleSpaceGuide.trailingAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: subtitleSpaceGuide.topAnchor),
            subtitleLabel.bottomAnchor.constraint(equalTo: subtitleSpaceGuide.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            placeholderLabel.topAnchor.constraint(equalTo: textField.topAnchor, constant: 8),
            placeholderLabel.leadingAnchor.constraint(equalTo: textField.leadingAnchor, constant: 12)
        ])

        textField.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        textField.text = nil
        subtitleLabel.text = nil
    }

    // MARK: - Configuration

    func configure(title: String,
                   placeholder: String,
                   errorMessage: String = "",
                   text: String?,
                   textDidChange: ((String) -> Void)?) {
        titleLabel.text = title
        textField.text = text
        placeholderLabel.text = placeholder
        subtitleLabel.text = errorMessage
        self.onTextDidChange = textDidChange

        textField.layer.borderColor = errorMessage.isEmpty ? UIColor.gray.cgColor : UIColor.red.cgColor
        textField.setNeedsDisplay()
    }

    // MARK: - UITextViewDelegate

    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
        onTextDidChange?(textView.text)
    }
}
