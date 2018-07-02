//
//  ProductDataSource.swift
//  Supermarket
//
//  Created by Kirill Koleno on 02.07.2018.
//  Copyright © 2018 Kirill Koleno. All rights reserved.
//

import Foundation

/// Use PlistLoader to get data from ProductDB and set it to the Dictionary
class ProductsSource {
    static var products: [Product] {
        let data = try! PlistLoader.array(fromFile: "ProductsData", ofType: "plist")
        return data.compactMap { Product(dictionary: $0) }
    }
}
