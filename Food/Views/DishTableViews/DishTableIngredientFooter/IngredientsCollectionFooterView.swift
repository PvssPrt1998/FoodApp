//
//  IngredientsCollectionFooterView.swift
//  Food
//
//  Created by Николай Щербаков on 04.08.2022.
//

import UIKit

class IngredientsCollectionFooterView: UITableViewHeaderFooterView {
    
    @IBOutlet weak var ingredientsCollectionView: UICollectionView! {
        didSet {
            setupCollectionViewCell()
        }
    }
    static let identifier: String = "IngredientsCollectionFooterView"
    
    var ingredients: Dictionary<String, Int>?
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        ingredientsCollectionView.collectionViewLayout = layout
        setupCollectionViewCell()
    }
    
    private func setupCollectionViewCell() {
        ingredientsCollectionView.register(IngredientCollectionViewCell.nib(), forCellWithReuseIdentifier: IngredientCollectionViewCell.identifier)
        ingredientsCollectionView.delegate = self
        ingredientsCollectionView.dataSource = self
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "IngredientsCollectionFooterView", bundle: nil)
    }
}

extension IngredientsCollectionFooterView: UICollectionViewDelegate {
    
}

extension IngredientsCollectionFooterView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let number = ingredients?.count else { return 0 }
        return number
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard var ingredients = ingredients,
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IngredientCollectionViewCell.identifier, for: indexPath) as? IngredientCollectionViewCell,
              let first = ingredients.keys.first,
              let ingredient = ingredients.removeValue(forKey: first)
        else { return UICollectionViewCell() }
        
        cell.ingredientButton.setTitle(first, for: .normal)
        cell.ingredientWeightLabel?.text = String(ingredient)
        
        return cell
    }
    
    
}

extension IngredientsCollectionFooterView: UICollectionViewDelegateFlowLayout {
    
}
