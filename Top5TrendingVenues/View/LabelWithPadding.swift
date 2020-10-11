//
//  LabelWithPadding.swift
//  Top5TrendingVenues
//
//  Created by Georgi on 9.10.20.
//

import UIKit

class LabelWithPadding: UILabel {
    let topInset: CGFloat = 5.0
    let bottomInset: CGFloat = 5.0
    let leftInset: CGFloat = 20.0
    let rightInset: CGFloat = 20.0

    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }
}
