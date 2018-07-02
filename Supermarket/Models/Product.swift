//
//  Product.swift
//  Supermarket
//
//  Created by Kirill Koleno on 01.07.2018.
//  Copyright © 2018 Kirill Koleno. All rights reserved.
//

import Foundation
import UIKit

class Product {
    
    let name: String?
    let description: String?
    let image: UIImage?
    let price: Float?
    let count: Float?
    
    init(name: String?, description: String?, image: UIImage?, price: Float?, count: Float?) {
        self.name = name
        self.description = description
        self.image = image
        self.price = price
        self.count = count
    }
}
