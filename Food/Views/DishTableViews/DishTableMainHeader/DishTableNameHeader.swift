//
//  DishTableNameHeader.swift
//  Food
//
//  Created by Николай Щербаков on 03.08.2022.
//

import UIKit

class DishTableNameHeader: UIView{

    @IBOutlet var titleLabel: UILabel!
    
    static let identifier: String = "DishNameHeader"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "XIBDishNameHeader", bundle: nil)
    }
}
