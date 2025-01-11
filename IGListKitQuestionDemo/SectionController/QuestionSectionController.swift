//
//  QuestionSectionController.swift
//  IGListKitQuestionDemo
//
//  Created by Yevhen Dubinin on 1/11/25.
//

import IGListKit

final class QuestionSectionController: ListSectionController {

    private var vm: QuestionViewModel?

    override init() {
        super.init()

        inset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext!.dequeueReusableCell(of: QuestionCell.self, for: self, at: index) as! QuestionCell
        cell.configure(with: vm!.title)
        cell.contentView.backgroundColor = .systemBackground
        return cell
    }

    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width-10, height: 100)
    }

    override func didUpdate(to object: Any) {
        self.vm = object as? QuestionViewModel ?? nil
    }

    override func didSelectItem(at index: Int) {
        print(">> Selected: \(vm!.title)")
    }
}
