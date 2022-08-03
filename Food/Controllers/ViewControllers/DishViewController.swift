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
}

extension DishViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let dish = dish else { return nil }
        let header = UIView()
        header.backgroundColor = .red
        //header.titleLabel?.text = dish.title
        return header
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 50
//    }
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
