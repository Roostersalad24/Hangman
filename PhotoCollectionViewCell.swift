//
//  PhotoCollectionViewCell.swift
//  Hangman
//
//  Created by Andrew Johnson on 9/13/24.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    static let identifier = "PhotoCollectionViewCell"
    
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        
        let images = [
            UIImage(named: "sushi8.pdf"),
            UIImage(named: "sushi7.pdf"),
            UIImage(named: "sushi6.pdf"),
            UIImage(named: "sushi5.pdf"),
            UIImage(named: "sushi4.pdf"),
        ].compactMap({$0})
        imageView.image = images.randomElement()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        //imageView.image = nil
    }
    
}
