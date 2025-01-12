//
//  QuestionWithOptionSectionController.swift
//  IGListKitQuestionDemo
//
//  Created by Yevhen Dubinin on 1/11/25.
//

import IGListKit
import IGListSwiftKit

final class QuestionWithOptionsSectionController: ListSectionController, ListSupplementaryViewSource {

    private var pageItem: PageViewModel!

    override init() {
        super.init()
        supplementaryViewSource = self
    }

    // MARK: IGListSectionController Overrides

    override func numberOfItems() -> Int {
        return pageItem.optionViewModels.count
    }

    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width-10, height: 100)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell: OptionCell = collectionContext.dequeueReusableCell(for: self, at: index)
        cell.configure(with: pageItem.optionViewModels[index].title)
        return cell
    }

    override func didUpdate(to object: Any) {
        pageItem = object as? PageViewModel
    }

    // MARK: ListSupplementaryViewSource

    func supportedElementKinds() -> [String] {
        return [UICollectionView.elementKindSectionHeader]
    }

    func viewForSupplementaryElement(ofKind elementKind: String, at index: Int) -> UICollectionReusableView {
        switch elementKind {
            case UICollectionView.elementKindSectionHeader:
                return userHeaderView(atIndex: index)
            default:
                fatalError()
        }
    }

    func sizeForSupplementaryView(ofKind elementKind: String, at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width-10, height: 100)
    }

    // MARK: - Private

    private func userHeaderView(atIndex index: Int) -> UICollectionReusableView {
        let view: QuestionCell = collectionContext.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                                    for: self,
                                                                                    class: QuestionCell.self,
                                                                                    at: index) as! QuestionCell
        view.configure(with: pageItem.questionViewModel.title)
        return view
    }
}
