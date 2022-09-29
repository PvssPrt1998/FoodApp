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
    // @IBOutlet weak var ingredientWeightLabel: UILabel!
    
    public func configure(with title: String, and weight: Int) {
        ingredientButton.setTitle(title, for: .normal)
        //ingredientWeightLabel.text = String(weight)
    }
}
