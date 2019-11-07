//
//  CardActionView.swift
//  CardSwipe
//
//  Created by Karthi Anandhan on 07/11/19.
//  Copyright © 2019 Karthi. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class CardActionView : UIView {
var contentView:UIView?
@IBInspectable var nibName:String?
    override func awakeFromNib() {
        super.awakeFromNib()
        nibName = "CardActionView"
         xibSetup()
    }

    func xibSetup() {
        if contentView == nil {
            guard let view = loadViewFromNib() else { return }
            view.frame = bounds
            view.autoresizingMask =
                [.flexibleWidth, .flexibleHeight]
            addSubview(view)
            contentView = view
        }
    }

    func loadViewFromNib() -> UIView? {
        guard let nibName = nibName else { return nil }
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(
                    withOwner: self,
                    options: nil).first as? UIView
    }
    
}
