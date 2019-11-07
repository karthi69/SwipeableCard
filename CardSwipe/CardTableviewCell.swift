//
//  CardTableviewCell.swift
//  CardSwipe
//
//  Created by Karthi Anandhan on 06/11/19.
//  Copyright © 2019 Karthi. All rights reserved.
//

import Foundation
import UIKit

protocol CellCallBacks {
    func beginSwipeCell(cardId : String)
    func startPayment(model : CardModel)
    func viewDetails(model : CardModel)
    func viewOtherDetails(model : CardModel)
}

class  CardTableviewCell : UITableViewCell {
    let cardViewWidth : CGFloat = 215
    private var lastContentOffset: CGFloat = 0
    var cellCallBacks : CellCallBacks?
    
    private var scrollDirection: ScrollDirection = .none
    
    @IBOutlet weak var cardBackgroundView: UIView!
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet var leftCardActionView: CardActionView!
    @IBOutlet var cardActionView: CardActionView!
    
    @IBOutlet weak var bankLogoLabel: UILabel! // has to be ImageView
    @IBOutlet weak var bankNameLabel: UILabel!
    @IBOutlet weak var cardIdLabel: UILabel!
    @IBOutlet weak var cardHolderNameLabel: UILabel!
    @IBOutlet weak var cardTypeLabel: UILabel!
    
    var cardModel : CardModel?
    
    @IBOutlet weak var cardViewWidthConstraint: NSLayoutConstraint!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)!
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        cardBackgroundView.layer.cornerRadius = 15
        setupCalbacks()
//        scrollview.scrollRectToVisible(CGRect.init(x: scrollview.contentSize.width/2, y: 0, width: 0, height: 0), animated: false)
    }
    
    func setupCalbacks()  {
        leftCardActionView.cardActionDelegate = self
        cardActionView.cardActionDelegate = self
        scrollview.delegate = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension CardTableviewCell {
    func configureView(model : CardModel)  {
        var bounds = UIScreen.main.bounds
        var width = bounds.size.width
        
        cardViewWidthConstraint.constant = width - 40
        cardModel = model
        cardBackgroundView.backgroundColor =  Utility.hexStringToUIColor(model.bgColor)
        bankLogoLabel.text = model.bankLogo
        bankNameLabel.text = model.bankName
        cardIdLabel.text = model.cardId
        cardHolderNameLabel.text = model.cardHolderName
        cardTypeLabel.text = model.name
    }
}

extension CardTableviewCell : UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if let id = cardModel?.cardId {
            cellCallBacks?.beginSwipeCell(cardId: id)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (self.lastContentOffset > scrollView.contentOffset.x) {
            // move right
            scrollDirection = .left
        }
        else if (self.lastContentOffset < scrollView.contentOffset.x) {
            // move left
            scrollDirection = .right
        }
        // update the new position acquired
        self.lastContentOffset = scrollView.contentOffset.x
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let left = scrollView.contentOffset.x
        let right = scrollView.contentOffset.x + scrollview.frame.width
        
        if left < cardViewWidth/2  {
            scrollToLeftEdge()
        }else if right > (scrollview.contentSize.width - cardViewWidth/2)  {
            scrollToRightEdge()
        }else{
            scrollToCenter()
        }
    }
    
    func scrollToLeftEdge()  {
        scrollview.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
    }
    
    func scrollToRightEdge()  {
        scrollview.setContentOffset(CGPoint.init(x:scrollview.contentSize.width - scrollview.frame.width, y: 0), animated: true)
    }
    
    func scrollToCenter()  {
        scrollview.setContentOffset(CGPoint.init(x: cardViewWidth, y: 0), animated: true)
    }
}

extension CardTableviewCell : CardViewActionDelegate {
    func startPayment() {
        if let model = cardModel{
            cellCallBacks?.startPayment(model: model)
        }
    }
    
    func viewCardDetails() {
        if let model = cardModel{
            cellCallBacks?.viewDetails(model: model)
        }
    }
    
    func viewOthers() {
        if let model = cardModel{
            cellCallBacks?.viewOtherDetails(model: model)
        }
    }
}


