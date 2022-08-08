//
//  DishTableNameHeader.swift
//  Food
//
//  Created by Николай Щербаков on 03.08.2022.
//

import UIKit

class DishTableHeader: UITableViewHeaderFooterView{


    @IBOutlet weak var dishTitleLabel: UILabel!
    
    static let identifier: String = "DishTableHeader"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "DishTableHeader", bundle: nil)
    }
}
