//
//  QuestionWithOptionSectionController.swift
//  IGListKitQuestionDemo
//
//  Created by Yevhen Dubinin on 1/11/25.
//

import IGListKit
import IGListSwiftKit

final class QuestionWithOptionsSectionController: ListSectionController, ListSupplementaryViewSource {

    private var questionWithOptionsItem: QuestionWithOptionsViewModel!

    override init() {
        super.init()
        supplementaryViewSource = self
    }

    // MARK: IGListSectionController Overrides

    override func numberOfItems() -> Int {
        return questionWithOptionsItem.optionViewModels.count
    }

    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width-10, height: 100)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell: OptionCell = collectionContext.dequeueReusableCell(for: self, at: index)
        cell.configure(with: questionWithOptionsItem.optionViewModels[index].title)
        return cell
    }

    override func didUpdate(to object: Any) {
        questionWithOptionsItem = object as? QuestionWithOptionsViewModel
    }

    override func didSelectItem(at index: Int) {
        questionWithOptionsItem.optionViewModels[index].select()
    }

    // MARK: ListSupplementaryViewSource

    func supportedElementKinds() -> [String] {
        return [UICollectionView.elementKindSectionHeader, UICollectionView.elementKindSectionFooter]
    }

    func viewForSupplementaryElement(ofKind elementKind: String, at index: Int) -> UICollectionReusableView {
        switch elementKind {
            case UICollectionView.elementKindSectionHeader:
                return questionHeaderView(atIndex: index)
            case UICollectionView.elementKindSectionFooter:
                return emptyFooterView(atIndex: index)
            default:
                fatalError()
        }
    }

    func sizeForSupplementaryView(ofKind elementKind: String, at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width-10, height: 100)
    }

    // MARK: - Private

    private func questionHeaderView(atIndex index: Int) -> UICollectionReusableView {
        let view: QuestionCell = collectionContext.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                                    for: self,
                                                                                    class: QuestionCell.self,
                                                                                    at: index) as! QuestionCell
        view.configure(with: questionWithOptionsItem.questionViewModel.title)
        return view
    }

    private func emptyFooterView(atIndex index: Int) -> UICollectionReusableView {
        let view: SpacerCell = collectionContext.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter,
                                                                                    for: self,
                                                                                    class: SpacerCell.self,
                                                                                    at: index) as! SpacerCell
        return view
    }
}
