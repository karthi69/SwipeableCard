//
//  CardTableviewCell.swift
//  CardSwipe
//
//  Created by Karthi Anandhan on 06/11/19.
//  Copyright © 2019 Karthi. All rights reserved.
//

import Foundation
import UIKit


class  CardTableviewCell : UITableViewCell {
    let cardViewWidth : CGFloat = 215
    private var lastContentOffset: CGFloat = 0
    
    enum ScrollDirection {
        case none,left, right
    }
    
    private var scrollDirection: ScrollDirection = .none

    @IBOutlet weak var cardBackgroundView: UIView!
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet var leftCardActionView: CardActionView!
    @IBOutlet var cardActionView: CardActionView!
    
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
        scrollview.scrollRectToVisible(CGRect.init(x: scrollview.contentSize.width/2, y: 0, width: 0, height: 0), animated: false)
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

extension CardTableviewCell : UIScrollViewDelegate {
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
    
        if left <= cardViewWidth/2  {
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
        print("startPayment")
    }
    
    func viewCardDetails() {
         print("viewCardDetails")
    }
    
    func viewOthers() {
         print("viewCardDetails")
    }
}
