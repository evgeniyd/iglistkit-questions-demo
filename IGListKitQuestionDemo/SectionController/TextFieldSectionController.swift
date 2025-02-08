//
//  TextFieldSectionController.swift
//  IGListKitQuestionDemo
//
//  Created by Yevhen Dubinin on 2/7/25.
//

import IGListKit

final class TextFieldSectionController: ListSectionController {

    private var vm: TextFieldViewModel?

    override init() {
        super.init()

        inset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext!.dequeueReusableCell(of: TextFieldCell.self, for: self, at: index) as! TextFieldCell
        cell.configure(placeholder: vm!.placeholder)
        cell.contentView.backgroundColor = .systemBackground
        return cell
    }

    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width-10, height: 100)
    }

    override func didUpdate(to object: Any) {
        self.vm = object as? TextFieldViewModel ?? nil
    }
}
