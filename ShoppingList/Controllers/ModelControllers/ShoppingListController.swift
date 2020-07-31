//
//  ShoppingListController.swift
//  ShoppingList
//
//  Created by Ian Becker on 7/31/20.
//  Copyright © 2020 Ian Becker. All rights reserved.
//

import Foundation
import CoreData

class ShoppingListController {
    
    // MARK: - Shared Instance
    static let shared = ShoppingListController()
    
    // MARK: - Properties
    var fetchedResultsController: NSFetchedResultsController<ShoppingList>
    
    init() {
        let request: NSFetchRequest<ShoppingList> = ShoppingList.fetchRequest()
        
        request.sortDescriptors = [NSSortDescriptor(key: "isInCart", ascending: true)]
        
        let resultsController: NSFetchedResultsController<ShoppingList> = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResultsController = resultsController
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("There was an error performing the fetch.")
        }
    }
    
    // MARK: - CRUD
    func addItem(groceryItem: String) {
        _ = ShoppingList(groceryItem: groceryItem)
        
    }
    
    func updateIsInCart(groceryItem: ShoppingList) {
        groceryItem.isInCart = !groceryItem.isInCart
        
    }
    
    func removeItem(groceryItem: ShoppingList) {
        let moc = CoreDataStack.context
        moc.delete(groceryItem)
        
    }
    
} // End of Class
