//
//  ShoppingList+Convenience.swift
//  ShoppingList
//
//  Created by Ian Becker on 7/31/20.
//  Copyright © 2020 Ian Becker. All rights reserved.
//

import Foundation
import CoreData

extension ShoppingList {
    
    convenience init(groceryItem: String, isInCart: Bool = false, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.groceryItem = groceryItem
        self.isInCart = isInCart
    }
}
