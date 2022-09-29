//
//  DishViewController.swift
//  Food
//
//  Created by Николай Щербаков on 03.08.2022.
//

import UIKit

class DishViewController: UIViewController {
    
    var dish: Dish?
    var ingredients: Dictionary<String, Int>?
    
    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var dishTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ingredients = getIngredientList(dish!) ?? nil
        dishImageView.backgroundColor = .yellow
        dishTableView.register(DishTableHeader.nib(), forHeaderFooterViewReuseIdentifier: DishTableHeader.identifier)
    }
    
    func countDishes(_ dish: Dish)-> Int {
        var count = 0
        for subDish in dish.subDishes {
            if subDish is DishItem {
                count += 1
                count += countDishes(subDish)
            }
        }
        return count
    }
    
    func getIngredientList(_ dish: Dish)-> Dictionary<String, Int>? {
        var ingredients: Dictionary<String, Int> = [:]
        
        if dish is Ingredient{
            ingredients[dish.title] = 500
            return ingredients
        }
        
        for subDish in dish.subDishes {
            guard let tmpIngredients = getIngredientList(subDish) else { return nil }
            ingredients.merge(tmpIngredients) { current, _ in current }
        }
        
        return ingredients
    }
}

extension DishViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let dish = dish else { return nil }
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: DishTableHeader.identifier) as? DishTableHeader else { return nil }
        header.dishTitleLabel?.text = dish.title

        return header
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        45
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return 300
        }
        return UITableView.automaticDimension
    }
}

extension DishViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let dish = dish else { return UITableViewCell() }
        
        if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: IngredientCollectionTableViewCell.identifier, for: indexPath) as? IngredientCollectionTableViewCell else { return UITableViewCell() }
            //cell.setIngredientsDictionary(ingredients)
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DishTableViewCell.identifier, for: indexPath) as? DishTableViewCell else { print("LOL"); return  UITableViewCell() }
        cell.descriptionTextView?.text = dish.description
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let dish = dish else { return 0 }
        return countDishes(dish) + 2
    }
}

extension DishViewController: UICollectionViewDelegate {
}

extension DishViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let dish = dish, let number = getIngredientList(dish)?.keys.count else { return 0 }
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
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        ingredients = getIngredientList(dish!) ?? nil
    }
}
