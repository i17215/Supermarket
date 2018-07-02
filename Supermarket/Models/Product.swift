//
//  Product.swift
//  Supermarket
//
//  Created by Kirill Koleno on 01.07.2018.
//  Copyright © 2018 Kirill Koleno. All rights reserved.
//

import Foundation
import UIKit

struct Product {
    
    let title: String?
    let description: String?
    let price: String?
    let count: String?
    let image: UIImage?
}

extension Product {
    
    struct Key {
        
        static let title = "title"
        static let description = "description"
        static let price = "price"
        static let count = "count"
        static let image = "image"
    }
    
    init?(dictionary: [String: String]) {
        guard let titleString = dictionary[Key.title],
            let descriptionString = dictionary[Key.description],
            let priceString = dictionary[Key.price],
            let countString = dictionary[Key.count] else { return nil }
        
        self.title = titleString
        self.description = descriptionString
        self.price = priceString
        self.count = countString
        
        if let imageName = dictionary[Key.image] {
            self.image = UIImage(named: imageName)
        } else {
            image = #imageLiteral(resourceName: "no_logo")
        }
    }
}
