//
//  Product+CoreDataProperties.swift
//  Supermarket
//
//  Created by Kirill Koleno on 02.07.2018.
//  Copyright © 2018 Kirill Koleno. All rights reserved.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var productDescription: String?
    @NSManaged public var productTitle: String?
    @NSManaged public var productPrice: Double
    @NSManaged public var image: NSData?

}
