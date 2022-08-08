//
//  IngredientCollectionView.swift
//  Food
//
//  Created by Николай Щербаков on 08.08.2022.
//

import UIKit

class IngredientTableViewFooter: UITableViewHeaderFooterView{

    static let identifier = "IngredientTableViewFooter"
    
    @IBOutlet weak var ingredientCollectionView: UICollectionView!
    
    var ingredients: Dictionary<String, Int>?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        ingredientCollectionView.collectionViewLayout = layout
        ingredientCollectionView.register(IngredientCollectionViewCell.nib(), forCellWithReuseIdentifier: IngredientCollectionViewCell.identifier)
        ingredientCollectionView.delegate = self
        ingredientCollectionView.dataSource = self
    }
    
    public func setIngredientsDictionary(_ ingredients: Dictionary<String, Int>) {
        self.ingredients = ingredients
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "IngredientTableViewFooter", bundle: nil)
    }
}

extension IngredientTableViewFooter: UICollectionViewDelegate {
    
}

extension IngredientTableViewFooter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let number = ingredients?.keys.count else { return 0 }
        return number
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IngredientCollectionViewCell.identifier, for: indexPath) as? IngredientCollectionViewCell,
              let first = ingredients?.keys.first
        else { return UICollectionViewCell() }
        cell.configure(with: first, and: 500)
        ingredients?.removeValue(forKey: first)
        return cell
    }
    
    
}

extension IngredientTableViewFooter: UICollectionViewDelegateFlowLayout {

}

