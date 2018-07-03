//
//  ProductForSale+CoreDataProperties.swift
//  Supermarket
//
//  Created by Kirill Koleno on 03.07.2018.
//  Copyright © 2018 Kirill Koleno. All rights reserved.
//
//

import Foundation
import CoreData


extension ProductForSale {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductForSale> {
        return NSFetchRequest<ProductForSale>(entityName: "ProductForSale")
    }

    @NSManaged public var name: String?

}
