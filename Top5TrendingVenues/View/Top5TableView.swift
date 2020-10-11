//
//  Top5TableView.swift
//  Top5TrendingVenues
//
//  Created by Georgi on 9.10.20.
//

import UIKit

class Top5TableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        self.frame = CGRect(x: 0, y: 0, width: 400, height: 500)
        self.backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
