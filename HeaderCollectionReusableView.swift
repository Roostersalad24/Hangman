//
//  HeaderCollectionReusableView.swift
//  Hangman
//
//  Created by Andrew Johnson on 9/13/24.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
        
    
   static let identifier = "HeaderCollectionReusableView"
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Header"
        label.textAlignment = .center
        label.textColor = .white
        return label
    } ()
    
    public func configure() {
        backgroundColor = .systemGreen
        addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }
    
}
