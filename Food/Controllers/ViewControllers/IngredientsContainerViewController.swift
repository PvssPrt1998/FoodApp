//
//  IngredientsContainerViewController.swift
//  Food
//
//  Created by Николай Щербаков on 08.08.2022.
//

import UIKit

class IngredientsContainerViewController: UIViewController {
    
    @IBOutlet weak var ingredientCollectionView: UICollectionView!
    
    var ingredients: Dictionary<String, Int>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
    }
    
    static let identifier: String = "IngredientsCollectionFooterView"
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        ingredientCollectionView.collectionViewLayout = layout
        ingredientCollectionView.register(IngredientCollectionViewCell.nib(), forCellWithReuseIdentifier: IngredientCollectionViewCell.identifier)
    }
}

extension IngredientsContainerViewController: UICollectionViewDelegate {
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {



        guard section == 0,
              let dish = dish,
              let ingredients = getIngredientList(dish),
              let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: IngredientsCollectionFooterView.identifier) as? IngredientsCollectionFooterView
        else { return nil }

        var backgroundConfig = UIBackgroundConfiguration.listPlainHeaderFooter()
        backgroundConfig.backgroundColor = .systemGray
        footer.backgroundConfiguration = backgroundConfig
        footer.ingredients = ingredients

        return footer
    }
    
}

extension IngredientsContainerViewController: UICollectionViewDataSource {
    
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
        self.ingredients?.removeValue(forKey: first)
        cell.ingredientButton.setTitle(first, for: .normal)
        cell.ingredientWeightLabel?.text = String(ingredient)
        return cell
    }
    
    
}

extension IngredientsContainerViewController: UICollectionViewDelegateFlowLayout {
    
}
