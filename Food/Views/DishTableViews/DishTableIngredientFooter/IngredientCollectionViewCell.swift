//
//  IngredientCollectionViewCell.swift
//  Food
//
//  Created by Николай Щербаков on 04.08.2022.
//

import UIKit

class IngredientCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var ingredientButton: UIButton!
    @IBOutlet weak var ingredientWeightLabel: UILabel!
    
    static let identifier: String = "IngredientCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "IngredientCollectionViewCell", bundle: nil)
    }
}
