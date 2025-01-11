//
//  ViewController.swift
//  IGListKitQuestionDemo
//
//  Created by Yevhen Dubinin on 1/10/25.
//

import UIKit
import IGListKit

final class ViewController: UIViewController {

    var pageViewModel: PageViewModel? {
        didSet {
            self.adapter?.reloadData()
        }
    }

    private let optionCellId = "OptionCellId"
    private let questionCellId = "QuestionCellId"
    private var adapter: ListAdapter?
    private let refreshController: RefreshQuestionController

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
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground

        setupIGListKit()
        setupRefreshButton()
    }

    // MARK: - Private

    private func setupIGListKit() {
        let collectionView = createCollectionView()
        let adapter = ListAdapter(updater: ListAdapterUpdater(), viewController: self)
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

extension ViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [any ListDiffable] {
        guard let pageViewModel else {
            return []
        }
        return [pageViewModel.questionViewModel] + pageViewModel.optionViewModels
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        if object is QuestionViewModel {
            return QuestionSectionController()
        } else if object is OptionViewModel {
            return OptionSectionController()
        } else {
            return ListSectionController()
        }
    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        let noDataLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.width))
        noDataLabel.text = "Nothing to display.\nTry to Refresh."
        noDataLabel.textAlignment = .center
        noDataLabel.numberOfLines = 0
        noDataLabel.lineBreakMode = .byWordWrapping
        noDataLabel.preferredMaxLayoutWidth = view.bounds.width - 16
        return noDataLabel
    }
}
