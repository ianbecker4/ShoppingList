//
//  GroceryItemDetailTableViewController.swift
//  ShoppingList
//
//  Created by Ian Becker on 7/31/20.
//  Copyright © 2020 Ian Becker. All rights reserved.
//

import UIKit

class GroceryItemDetailTableViewController: UITableViewController, UITextViewDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var nutritionInfoTextView: UITextView!
    
    
    // MARK: - Properties
    var groceryItem: ShoppingList? {
        didSet {
            loadViewIfNeeded()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = groceryItem?.groceryItem
        tableView.reloadData()
    }
    
    // MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let nutritionInfo = nutritionInfoTextView.text, !nutritionInfo.isEmpty else {return}
        
        if let groceryItem = groceryItem {
            ShoppingListController.shared.update(groceryItem: groceryItem, nutritionInfo: nutritionInfo)
        }
        self.navigationController?.popViewController(animated: true)
    }
} // End of Class
