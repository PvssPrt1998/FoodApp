//
//  Ingredient.swift
//  Food
//
//  Created by Николай Щербаков on 27.04.2022.
//

import Foundation

//    MARK: - Ingredient (Leaf)
public class Ingredient: Dish, Codable {
    //MARK: - Properties
    public var title: String
    public var description: String
    public var recipe: String
    public var subDishes: [Dish]
    
    enum CodingKeys: CodingKey {
        case title
        case description
    }
    
    //MARK: - ObjectLifecycle
    public init(title: String, description: String) {
        self.title = title
        self.description = description
        self.recipe = ""
        self.subDishes = []
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        description = try container.decode(String.self, forKey: .description)
        self.recipe = ""
        self.subDishes = []
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(description, forKey: .description)
    }
}

