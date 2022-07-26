//
//  Dish.swift
//  Food
//
//  Created by Николай Щербаков on 30.05.2022.
//

import Foundation

public protocol Dish {
    var title: String { get set }
    var description: String { get set }
    var recipe: String { get set }
    var subDishes: [Dish] { get set }
}
