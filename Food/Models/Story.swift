//
//  Story.swift
//  Food
//
//  Created by Николай Щербаков on 04.07.2022.
//

import UIKit

class Story {
    
    let image: UIImage
    let lifeTime: Double = 1
    
    public init(image: UIImage) {
        self.image = image
    }
    
    public static func getStories()-> [Story] {
        var array = [Story]()
        
        for _ in 0...10 {
            let image = UIImage(systemName: "car")
            let story = Story(image: image!)
            array.append(story)
        }
        
        return array
    }
}
