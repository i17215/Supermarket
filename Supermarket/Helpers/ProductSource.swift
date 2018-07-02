//
//  ProductSource.swift
//  Supermarket
//
//  Created by Kirill Koleno on 01.07.2018.
//  Copyright © 2018 Kirill Koleno. All rights reserved.
//

import Foundation

/// Use PlistLoader to get data from ProductDB and set it to the Dictionary
class ProductSource {
    
    static var products: [Product] {
        let data = try! PlistLoader.getArray(fromFile: "ProductsData", ofType: "plist")
        
        return data.compactMap { Product(dictionary: $0) }
    }
}
