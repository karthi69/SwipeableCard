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
    @IBOutlet weak var sampleLabel: UILabel!
    @IBOutlet weak var cardBackgroundView: UIView!
    @IBOutlet weak var scrollview: UIScrollView!
    
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
        scrollview.contentSize = CGSize.init(width: 1500, height: scrollview.frame.height)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
