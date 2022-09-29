//
//  DishTableViewCell.swift
//  Food
//
//  Created by Николай Щербаков on 03.08.2022.
//

import UIKit

class DishTableViewCell: UITableViewCell {
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    static let identifier: String = "DishTableViewCell"
    
    func setupDescription(_ description: String){
        descriptionTextView?.text = description
    }
}
