//
//  TextViewSectionController.swift
//  IGListKitQuestionDemo
//
//  Created by Yevhen Dubinin on 2/8/25.
//

import IGListKit

final class TextViewSectionController: ListSectionController {

    private var vm: TextViewViewModel?

    override init() {
        super.init()

        inset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext!.dequeueReusableCell(of: TextViewCell.self, for: self, at: index) as! TextViewCell
        cell.configure(title: vm!.title, placeholder: vm!.placeholder, errorMessage: vm!.errorMessage, text: vm!.text) { [weak self] text in
            self?.vm?.didChange(text)
        }
        cell.contentView.backgroundColor = .systemBackground
        return cell
    }

    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width-10, height: 120)
    }

    override func didUpdate(to object: Any) {
        self.vm = object as? TextViewViewModel ?? nil
    }
}
