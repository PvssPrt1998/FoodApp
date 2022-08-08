//
//  DishTableViewCell.swift
//  Food
//
//  Created by Николай Щербаков on 03.08.2022.
//

import UIKit

class DishTableViewCell: UITableViewCell {
    @IBOutlet var descriotionTextView: UITextView!
    
    static let identifier: String = "DishTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupDescription(_ description: String){
        descriotionTextView.text = description
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "DishTableViewCell", bundle: nil)
    }
    
}
