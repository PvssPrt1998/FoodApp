//
//  DishCollectionViewCell.swift
//  Food
//
//  Created by Николай Щербаков on 30.05.2022.
//

import UIKit

class DishCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Outlets
    @IBOutlet var dishImageView: UIImageView!
    @IBOutlet weak var dishTitle: UILabel!
    
    static let identifier = "DishCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func configure(with image: UIImage) {
        dishImageView.image = image
        dishImageView.backgroundColor = .systemGray5
    }
    
    public func setDishTitle(_ title: String) {
        dishTitle.text = title
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "DishCollectionViewCell", bundle: nil)
    }

}
