//
//  DishTableMainFooterCollectionViewCell.swift
//  Food
//
//  Created by Николай Щербаков on 03.08.2022.
//

import UIKit

class DishTableMainFooterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var ingredientNameButton: UIButton!
    
    static let identifier = "DishTableMainFooterCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func configure(with title: String) {
        ingredientNameButton.setTitle(title, for: .normal)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "DishTableMainFooterCollectionViewCell", bundle: nil)
    }
}
