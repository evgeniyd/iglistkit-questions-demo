//
//  OptionSectionController.swift
//  IGListKitQuestionDemo
//
//  Created by Yevhen Dubinin on 1/11/25.
//

import IGListKit

final class OptionSectionController: ListSectionController {

    private var vm: OptionViewModel?

    override init() {
        super.init()

        inset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext!.dequeueReusableCell(of: OptionCell.self, for: self, at: index) as! OptionCell
        cell.configure(with: vm!.title)
        return cell
    }

    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width-10, height: 100)
    }

    override func didUpdate(to object: Any) {
        self.vm = object as? OptionViewModel ?? nil
    }

    override func didSelectItem(at index: Int) {
        print(">> Selected: \(vm!.title)")

        vm?.select()
    }
}
