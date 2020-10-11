//
//  myCustomActivityIndicator.swift
//  Top5TrendingVenues
//
//  Created by Georgi on 9.10.20.
//

import UIKit

class MyCustomActivityIndicator: UIActivityIndicatorView {

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        self.style = .large
    }
    
    func activityIndicatorTrigger() {
        DispatchQueue.main.async {
            self.startAnimating()
            self.tintColor = .systemRed
        }
    }
    
    func activityIndicatorStop() {
        DispatchQueue.main.async {
            self.stopAnimating()
            self.hidesWhenStopped = true
        }
    }
}
