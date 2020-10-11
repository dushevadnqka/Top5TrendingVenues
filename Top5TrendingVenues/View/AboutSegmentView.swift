//
//  AboutSegmentView.swift
//  Top5TrendingVenues
//
//  Created by Georgi on 9.10.20.
//

import UIKit

class AboutSegmentView: UIView {
    
    let label = LabelWithPadding()
    
    let aboutUsLabelText = "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like)."
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        self.frame = CGRect(x: 0, y: 0, width: 400, height: 500)
        self.backgroundColor = .systemBackground
        
        // label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = aboutUsLabelText
        label.numberOfLines = 0
        label.textAlignment = .left
        
        self.addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }
}
