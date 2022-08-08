//
//  DishViewController.swift
//  Food
//
//  Created by Николай Щербаков on 03.08.2022.
//

import UIKit

class DishViewController: UIViewController {
    
    var dish: Dish?
    
    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var dishTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dishImageView.backgroundColor = .yellow
        dishTableView.register(DishTableViewCell.nib(), forCellReuseIdentifier: DishTableViewCell.identifier)
        dishTableView.register(DishTableHeader.nib(), forHeaderFooterViewReuseIdentifier: DishTableHeader.identifier)
        dishTableView.register(IngredientTableViewFooter.nib() , forHeaderFooterViewReuseIdentifier: IngredientTableViewFooter.identifier)
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
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        guard section == 0,
              let dish = dish,
              let ingredients = getIngredientList(dish),
              let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: IngredientTableViewFooter.identifier) as? IngredientTableViewFooter
        else { return nil }
        footer.ingredients = ingredients
        
        return footer
    }
}

extension DishViewController: UITableViewDataSource {
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DishTableViewCell.identifier, for: indexPath) as? DishTableViewCell else { return UITableViewCell() }
        cell.descriotionTextView.text = dish?.description
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let dish = dish else { return 0 }
        return countDishes(dish) + 1
    }
}
