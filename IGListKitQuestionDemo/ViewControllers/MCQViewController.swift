//
//  MCQViewController.swift
//  IGListKitQuestionDemo
//
//  Created by Yevhen Dubinin on 2/6/25.
//

import UIKit
import IGListKit

final class MCQViewController: UIViewController {

    private let pageViewModel: PageViewModel

    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()

    private let refreshController: RefreshQuestionController

    let ctaButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private var buttonBottomConstraint: NSLayoutConstraint?

    // MARK: - Init

    @available(*, unavailable, message: "Use dependency injection or other custom initializers.")
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        fatalError()
    }

    @available(*, unavailable, message: "Use dependency injection or other custom initializers.")
    required init?(coder: NSCoder) {
        fatalError()
    }

    init(refreshController: RefreshQuestionController, pageViewModel: PageViewModel) {
        self.refreshController = refreshController
        self.pageViewModel = pageViewModel
        super.init(nibName: nil, bundle: nil)
        title = "MCQ"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground

        navigationController?.navigationBar.prefersLargeTitles = true

        setupIGListKit()
        setupRefreshButton()
        view.addSubview(ctaButton)

        setupConstraints()

        bind()
    }

    // MARK: - Private

    private func setupIGListKit() {
        let collectionView = createCollectionView()
        adapter.collectionView = collectionView
        adapter.dataSource = self
        self.adapter = adapter
    }

    private func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 0

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: 60, left: 0, bottom: 0, right: 0)

        self.view.addSubview(collectionView)

        return collectionView
    }

    private func setupRefreshButton() {
        let refreshView = refreshController.view
        self.view.addSubview(refreshView)

        // Bring button to the front
        self.view.addSubview(refreshView)
        self.view.bringSubviewToFront(refreshView)
    }

    private func setupConstraints() {
        buttonBottomConstraint = ctaButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        NSLayoutConstraint.activate([
            ctaButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            ctaButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            ctaButton.heightAnchor.constraint(equalToConstant: 50),
            buttonBottomConstraint! // Activate the bottom constraint
        ])

        guard let collectionView = adapter.collectionView else {
            fatalError("Collection View instance cannot be nil")
        }
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: ctaButton.topAnchor)
        ])

        let refreshView = refreshController.view
        // Set up constraints
        refreshView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            refreshView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 8),
            refreshView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8),
        ])
    }

    private func bind() {
        ctaButton.setTitle(pageViewModel.submitButtonTitle, for: .normal)

        pageViewModel.onChangeState = { [weak self] viewModel, state in
            switch state {
                case .questionWithOptionsViewModel:
                    self?.adapter.reloadData()
            }
        }

        ctaButton.addTarget(self,
                            action: #selector(ctaButtonTapped),
                            for: .touchUpInside)
    }

    // MARK: - Action Handler

    @objc private func ctaButtonTapped() {
        pageViewModel.didTapCTA()
    }
}

// MARK: - ListAdapterDataSource

extension MCQViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [any ListDiffable] {
        guard let questionWithOptionsViewModel = pageViewModel.questionWithOptionsViewModel else {
            return []
        }
        // homogeneous array of Page VM
        return [questionWithOptionsViewModel]
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return QuestionWithOptionsSectionController()
    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        NoDataView(frame: .zero)
    }
}
