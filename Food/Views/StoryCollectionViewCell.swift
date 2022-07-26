//
//  StoryCollectionViewCell.swift
//  Food
//
//  Created by Николай Щербаков on 04.07.2022.
//

import UIKit

class StoryCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "StoryCollectionViewCell"
    
    @IBOutlet var storyImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func configure(with image: UIImage) {
        storyImageView.image = image
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "StoryCollectionViewCell", bundle: nil)
    }
    
    
}
