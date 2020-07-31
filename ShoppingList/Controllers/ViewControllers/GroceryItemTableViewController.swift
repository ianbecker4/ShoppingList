//
//  GroceryItemTableViewController.swift
//  ShoppingList
//
//  Created by Ian Becker on 7/31/20.
//  Copyright © 2020 Ian Becker. All rights reserved.
//

import UIKit
import CoreData

class GroceryItemTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ShoppingListController.shared.fetchedResultsController.delegate = self
    }
    
    // MARK: - Actions
    @IBAction func addButtonTapped(_ sender: Any) {
        presentAlertController()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ShoppingListController.shared.fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "groceryItemCell", for: indexPath) as? GroceryItemTableViewCell else {return UITableViewCell()}
        
        let groceryItem = ShoppingListController.shared.fetchedResultsController.object(at: indexPath)

        cell.groceryItem = groceryItem
        cell.delegate = self

        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let groceryItemToDelete = ShoppingListController.shared.fetchedResultsController.object(at: indexPath)
            ShoppingListController.shared.removeItem(groceryItem: groceryItemToDelete)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / 7
    }
    
    // MARK: - Helpers
    
    func presentAlertController() {
        let alertController = UIAlertController(title: "Add Item", message: "Please add an item to your shopping list:", preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Add item here:"
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let addGroceryItemAction = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let groceryItem = alertController.textFields?[0].text, !groceryItem.isEmpty else {return}
            
            ShoppingListController.shared.addItem(groceryItem: groceryItem)
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(addGroceryItemAction)
        
        present(alertController, animated: true)
    }
} // End of Class

extension GroceryItemTableViewController: GroceryItemTableViewCellDelegate {
    func isInCartButtonTapped(_ sender: GroceryItemTableViewCell) {
        guard let index = tableView.indexPath(for: sender) else {return}
        let groceryItem = ShoppingListController.shared.fetchedResultsController.object(at: index)
        ShoppingListController.shared.updateIsInCart(groceryItem: groceryItem)
        sender.updateViews()
    }
}


extension GroceryItemTableViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .delete:
            guard let indexPath = indexPath else {break}
            tableView.deleteRows(at: [indexPath], with: .automatic)
        case .insert:
            guard let newIndexPath = newIndexPath else {break}
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .move:
            guard let oldIndexPath = indexPath, let newIndexPath = newIndexPath else {break}
            tableView.moveRow(at: oldIndexPath, to: newIndexPath)
        case .update:
            guard let indexPath = indexPath else {break}
            tableView.reloadRows(at: [indexPath], with: .automatic)
        default:
            fatalError()
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}
