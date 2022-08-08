//
//  IngredientCollectionViewCell.swift
//  Food
//
//  Created by Николай Щербаков on 08.08.2022.
//

import UIKit

class IngredientCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "IngredientCollectionViewCell"
    
    @IBOutlet weak var ingredientButton: UIButton!
    @IBOutlet weak var ingredientWeightLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "IngredientCollectionViewCell", bundle: nil)
    }
    
    public func configure(with title: String, and weight: Int) {
        ingredientButton.setTitle(title, for: .normal)
        ingredientWeightLabel.text = String(weight)
    }
}
