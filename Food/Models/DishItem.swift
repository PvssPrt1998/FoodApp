//
//  Dish.swift
//  Food
//
//  Created by Николай Щербаков on 25.04.2022.
//

import Foundation
import UIKit

public class DishItem: Dish, Codable{
    
    public var title: String
    public var description: String
    public var recipe: String
    public var subDishes: [Dish]
    
    enum CodingKeys: CodingKey {
        case title
        case description
        case recipe
        case subDishes
    }
    
    init(title: String, description: String, recipe: String, subDishes: [Dish]) {
        self.title = title
        self.description = description
        self.recipe = recipe
        self.subDishes = subDishes
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(description, forKey: .description)
        try container.encode(recipe, forKey: .recipe)
        
        var subDishesContainer = container.nestedUnkeyedContainer(forKey: .subDishes)
        
        for item in subDishes {
            if let dishItemCase = item as? DishItem {
                try subDishesContainer.encode(dishItemCase)
            } else if let ingredientCase = item as? Ingredient {
                try subDishesContainer.encode(ingredientCase)
            } else {
                print("can not encode \(item.title)")
            }
        }
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        description = try container.decode(String.self, forKey: .description)
        recipe = try container.decode(String.self, forKey: .recipe)
        
        var subDishesContainer = try container.nestedUnkeyedContainer(forKey: .subDishes)
        
        self.subDishes = []
        
        while !subDishesContainer.isAtEnd {
            if let item = try? subDishesContainer.decode(DishItem.self) {
                subDishes.append(item)
            }
            
            if let item = try? subDishesContainer.decode(Ingredient.self) {
                subDishes.append(item)
            }
        }
    }
}

public class DishCoder {
    
    public static let decoder = JSONDecoder()
    
    public static func createDocumentURL(withFileName fileName: String) -> URL {
        let fileManager = FileManager.default
        let url = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        return url.appendingPathComponent(fileName).appendingPathExtension("json")
    }

    public static func save<T: Encodable>(_ object: T, to fileName: String) throws {
        do {
            let encoder = JSONEncoder()
            let url = createDocumentURL(withFileName: fileName)
            let data = try encoder.encode(object)
            try data.write(to: url, options: .atomic)
        } catch (let error) {
            print("Save failed: Object: `\(object)`, " + "Error: `\(error)`")
            throw error
        }
    }
    
    public static func retrieve<T: Codable>(_ type: T.Type, from fileName: String) throws -> T {
        let url = createDocumentURL(withFileName: fileName)
        return try retrieve(T.self, from: url)
    }
    
    public static func retrieve<T: Codable>(_ type: T.Type, from url: URL) throws -> T {
        do {
            let data = try Data(contentsOf: url)
            return try decoder.decode(T.self, from: data)
        } catch (let error) {
            print("Retrieve failed: URL: `\(url)`, Error: `\(error)`")
            throw error
        }
    }
    
    public static func getDishes()-> [Dish] {
        var array = [Dish]()
        if let item = try? retrieve(DishItem.self, from: "Dishes") {
            array.append(item)
        }
        
        for _ in 0...50 {
            guard let item = array.first else { break }
            array.append(item)
        }
        
        return array
    }
}


