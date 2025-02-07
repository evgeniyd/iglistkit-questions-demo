//
//  ViewController.swift
//  IGListKitQuestionDemo
//
//  Created by Yevhen Dubinin on 1/10/25.
//

import UIKit
import IGListKit

final class TwoSectionControllersExampleViewController: UIViewController {

    var pageViewModel: QuestionWithOptionsViewModel? {
        didSet {
            self.adapter.reloadData()
        }
    }

    private let optionCellId = "OptionCellId"
    private let questionCellId = "QuestionCellId"

    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()

    private let refreshController: RefreshQuestionController

    // MARK: - Init

    @available(*, unavailable, message: "Use dependency injection or other custom initializers.")
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        fatalError()
    }

    @available(*, unavailable, message: "Use dependency injection or other custom initializers.")
    required init?(coder: NSCoder) {
        fatalError()
    }

    init(refreshController: RefreshQuestionController) {
        self.refreshController = refreshController
        super.init(nibName: nil, bundle: nil)
        self.title = "Two"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground

        navigationController?.navigationBar.prefersLargeTitles = true

        setupIGListKit()
        setupRefreshButton()
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
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: 60, left: 0, bottom: 0, right: 0)

        collectionView.register(OptionCell.self, forCellWithReuseIdentifier: optionCellId)
        collectionView.register(QuestionCell.self, forCellWithReuseIdentifier: questionCellId)

        self.view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])

        return collectionView
    }

    private func setupRefreshButton() {
        let refreshView = refreshController.view
        self.view.addSubview(refreshView)
        refreshView.translatesAutoresizingMaskIntoConstraints = false

        // Set up constraints
        NSLayoutConstraint.activate([
            refreshView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 8),
            refreshView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8),
        ])

        // Bring button to the front
        self.view.addSubview(refreshView)
        self.view.bringSubviewToFront(refreshView)
    }
}


// MARK: - ListAdapterDataSource

extension TwoSectionControllersExampleViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [any ListDiffable] {
        guard let pageViewModel else {
            return []
        }
        // Question + Options are returned as heterogeneous array
        return [pageViewModel.questionViewModel] + pageViewModel.optionViewModels
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        if object is QuestionViewModel {
            return QuestionSectionController()
        } else if object is OptionViewModel {
            return OptionSectionController()
        } else {
            assert(false, "Unexpected data type that cannot be mapped to a list section controller")
            return ListSectionController()
        }
    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        NoDataView(frame: .zero)
    }
}
