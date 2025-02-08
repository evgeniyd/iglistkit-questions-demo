//
//  SAViewController.swift
//  IGListKitQuestionDemo
//
//  Created by Yevhen Dubinin on 2/7/25.
//


import UIKit
import IGListKit

final class SAViewController: UIViewController {

    private let pageViewModel: SAViewModel

    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()

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

    init(pageViewModel: SAViewModel) {
        self.pageViewModel = pageViewModel
        super.init(nibName: nil, bundle: nil)
        title = self.pageViewModel.title
    }

    // MARK: - View Lyfecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground

        navigationController?.navigationBar.prefersLargeTitles = true

        setupIGListKit()
        view.addSubview(ctaButton)

        setupConstraints()

        setupKeyboardDismissal()
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        addKeyboardObservers()
    }

    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        removeKeyboardObserver()
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
    }

    private func setupKeyboardDismissal() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    // MARK - Keyboard

    private func addKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    private func removeKeyboardObserver() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc private func dismissKeyboard() {
        // This resigns the first responder for all input views
        view.endEditing(true)
    }

    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
              let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
              let animationCurveValue = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else {
            return
        }

        let keyboardHeight = keyboardFrame.height

        // Update the button's bottom constraint to align above the keyboard
        buttonBottomConstraint?.constant = -keyboardHeight - 8 + view.safeAreaInsets.bottom

        UIView.animate(withDuration: animationDuration, delay: 0, options: UIView.AnimationOptions(rawValue: animationCurveValue)) {
            self.view.layoutIfNeeded()
        } completion: { [adapter, pageViewModel] completed in
            guard completed else { return }

            adapter.scroll(to: pageViewModel.textViewViewModel,
                           supplementaryKinds: nil,
                           scrollDirection: .vertical,
                           scrollPosition: .top,
                           additionalOffset: 0.0,
                           animated: true)
        }
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        guard
            let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
            let animationCurveValue = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else
        {
            return
        }

        buttonBottomConstraint?.constant = -8

        guard let collectionView = adapter.collectionView else {
            fatalError("Collection View instance cannot be nil")
        }

        collectionView.contentInset.bottom = 0
        collectionView.verticalScrollIndicatorInsets.bottom = 0

        UIView.animate(withDuration: animationDuration,
                       delay: 0,
                       options: UIView.AnimationOptions(rawValue: animationCurveValue))
        {
            self.view.layoutIfNeeded()
        }
    }
}

// MARK: - ListAdapterDataSource

extension SAViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [any ListDiffable] {
        return [pageViewModel.textViewViewModel]
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return TextViewSectionController()
    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        NoDataView(frame: .zero)
    }
}

