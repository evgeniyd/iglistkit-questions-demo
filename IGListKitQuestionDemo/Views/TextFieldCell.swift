//
//  TextFieldCell.swift
//  IGListKitQuestionDemo
//
//  Created by Yevhen Dubinin on 2/7/25.
//

import UIKit

final class TextFieldCell: UICollectionViewCell, UITextFieldDelegate {

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

    private let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 8.0
        textField.clipsToBounds = true

        // Enable the clear button to appear while editing
        textField.clearButtonMode = .whileEditing

        // Optional: Add left padding for better text positioning
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always

        return textField
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
        textField.placeholder = placeholder
        subtitleLabel.text = errorMessage
    }

    // MARK: - UITextFieldDelegate

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let currentText = textField.text {
            print("Entire updated text: \(currentText)")
        }
        return true
    }
}
