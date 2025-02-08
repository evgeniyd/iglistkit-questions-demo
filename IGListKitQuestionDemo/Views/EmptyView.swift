//
//  EmptyView.swift
//  IGListKitQuestionDemo
//
//  Created by Yevhen Dubinin on 1/11/25.
//

import UIKit

import UIKit

final class NoDataView: UIView {

    // MARK: - Subviews
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Nothing to display.\nTry to Refresh."
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    // MARK: - Setup
    private func setupView() {
        addSubview(messageLabel)

        // Constraints
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }

    // MARK: - Configuration
    func configure(with text: String) {
        messageLabel.text = text
    }
}



