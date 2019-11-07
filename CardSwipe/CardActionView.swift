//
//  CardActionView.swift
//  CardSwipe
//
//  Created by Karthi Anandhan on 07/11/19.
//  Copyright © 2019 Karthi. All rights reserved.
//

import Foundation
import UIKit

protocol CardViewActionDelegate {
    func startPayment()
    func viewCardDetails()
    func viewOthers()
}

@IBDesignable
class CardActionView : UIView {
var contentView:UIView?
    @IBOutlet weak var payNowButton: UIButton!
    @IBOutlet weak var viewDetailsButton: UIButton!
    @IBOutlet weak var othersButton: UIButton!
    @IBInspectable var nibName:String?
    
    var  cardActionDelegate : CardViewActionDelegate?
    
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
    
    @IBAction func payNowButtonClicked(_ sender: Any) {
        cardActionDelegate?.startPayment()
    }
    
    
    @IBAction func viewDetailsButtonClicked(_ sender: Any) {
        cardActionDelegate?.viewCardDetails()
    }
    
    @IBAction func othersButtonClicked(_ sender: Any) {
        cardActionDelegate?.viewOthers()
    }
    
}

extension CardActionView {
    
}
