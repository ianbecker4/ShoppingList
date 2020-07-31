//
//  GroceryItemTableViewCell.swift
//  ShoppingList
//
//  Created by Ian Becker on 7/31/20.
//  Copyright © 2020 Ian Becker. All rights reserved.
//

import UIKit

// MARK: - Protocols
protocol GroceryItemTableViewCellDelegate: class {
    func isInCartButtonTapped(_ sender: GroceryItemTableViewCell)
}

class GroceryItemTableViewCell: UITableViewCell {
    
    var groceryItem: ShoppingList? {
        didSet {
            updateViews()
        }
    }
    
    weak var delegate: GroceryItemTableViewCellDelegate?
    
    // MARK: - Outlets
    @IBOutlet weak var groceryItemLabel: UILabel!
    @IBOutlet weak var isInCartButton: UIButton!
    
    // MARK: - Actions
    @IBAction func isInCartButtonTapped(_ sender: Any) {
        delegate?.isInCartButtonTapped(self)
    }
    
    // MARK: - Helpers
    func updateViews() {
        guard let groceryItem = groceryItem else {return}
        groceryItemLabel.text = groceryItem.groceryItem
        updateButtonFor(groceryItem: groceryItem)
    }
    
    func updateButtonFor(groceryItem: ShoppingList) {
        if groceryItem.isInCart {
            isInCartButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        } else {
            isInCartButton.setImage(UIImage(systemName: "square"), for: .normal)
        }
    }
} // End of Class
