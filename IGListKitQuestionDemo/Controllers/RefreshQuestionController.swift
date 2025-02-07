//
//  RefreshQuestionController.swift
//  IGListKitQuestionDemo
//
//  Created by Yevhen Dubinin on 1/11/25.
//

import UIKit

final class RefreshQuestionController {

    private let service: SingleChoiceQuestionService
    var onRefresh: ((SingleChoiceQuestion) -> Void)?

    init(service: SingleChoiceQuestionService) {
        self.service = service
    }

    lazy var view: UIView = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false

        // Set up constraints
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 44),
            button.heightAnchor.constraint(equalToConstant: 44)
        ])

        // Style the button
        button.backgroundColor = .white
        button.layer.cornerRadius = 22 // Makes it a circle
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.2
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 4

        // Add SF Symbol as an icon
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .medium)
        let refreshIcon = UIImage(systemName: "arrow.clockwise", withConfiguration: config)
        button.setImage(refreshIcon, for: .normal)
        button.tintColor = .systemBlue // Icon color

        // Add target action
        button.addTarget(self, action: #selector(didPressRefreshButton), for: .touchUpInside)

        return button
    }()

    @objc
    private func didPressRefreshButton() {
        service.getSingleChoiceQuestion { [weak self] question in
            guard let self else { return }
            self.onRefresh?(question)
        }
    }
}
