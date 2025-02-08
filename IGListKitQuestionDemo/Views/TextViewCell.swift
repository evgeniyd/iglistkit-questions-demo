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
        label.textAlignment = .left // Align text to the left like a header
        label.numberOfLines = 0 // Support multiline text
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.preferredFont(forTextStyle: .headline) // Use a bold, larger font
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
        contentView.addSubview(textField)
        textField.addSubview(placeholderLabel)
        contentView.addSubview(subtitleLabel)

        titleLabel.setContentHuggingPriority(.required, for: .vertical)
        textField.setContentHuggingPriority(.defaultLow, for: .vertical)
        subtitleLabel.setContentHuggingPriority(.required, for: .vertical)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16), // Add left padding
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16), // Add right padding
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8), // Add top padding
        ])
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16), // Add left padding
            textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16), // Add right padding
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8), // Add top padding
        ])
        NSLayoutConstraint.activate([
            placeholderLabel.topAnchor.constraint(equalTo: textField.topAnchor, constant: 8),
            placeholderLabel.leadingAnchor.constraint(equalTo: textField.leadingAnchor, constant: 12)
        ])
        NSLayoutConstraint.activate([
            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16), // Add left padding
            subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16), // Add right padding
            subtitleLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 8), // Add top padding
            subtitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8) // Add bottom padding
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

    func configure(title: String, placeholder: String, errorMessage: String = "", text: String? = nil) {
        titleLabel.text = title
        textField.text = text
        placeholderLabel.text = placeholder
        subtitleLabel.text = errorMessage
    }

    // MARK: - UITextViewDelegate

    func textViewDidChange(_ textView: UITextView) {
        print("text: \(textView.text ?? "")")
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
}
