//
//  Top5VenuesCell.swift
//  Top5TrendingVenues
//
//  Created by Georgi on 9.10.20.
//

import UIKit

class Top5VenuesCell: UITableViewCell {

    @IBOutlet weak var contentViewWrapper: UIView!
    @IBOutlet weak var venueTitle: UILabel!
    @IBOutlet weak var venueAddress: UILabel!
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 20, bottom: 5, right: 20))
    }
    
}
