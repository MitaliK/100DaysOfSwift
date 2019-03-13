//
//  ViewController.swift
//  MilestoneProject
//
//  Created by Mitali Kulkarni on 3/13/19.
//  Copyright © 2019 Mitali Kulkarni. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var shoppingList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // RightBarButtonItem  Add button
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addShoppingItem))
        
        // Share button
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareShoppingList))
        
    }
    
    // MARK: - UITableviewDataSource functions
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Items", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }
    
    @objc func addShoppingItem() {
        // Add AlertController with textField to add shoping items
        let ac = UIAlertController(title: "Enter Item", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let addAction = UIAlertAction(title: "Add", style: .default) { [weak self, weak ac] _ in
            guard let item = ac?.textFields?[0].text else { return }
            self?.shoppingList.insert(item, at: 0)
            let indexPath = IndexPath(row: 0, section: 0)
            self?.tableView.insertRows(at: [indexPath], with: .automatic)
        }
        ac.addAction(addAction)
        present(ac, animated: true, completion: nil)
    }
    
    @objc func shareShoppingList () {
        let listItems = shoppingList.joined(separator: "\n")
        
        let vc = UIActivityViewController(activityItems: [listItems], applicationActivities: [])
        // This is done for iPAD
        vc.popoverPresentationController?.barButtonItem = navigationItem.leftBarButtonItem
        present(vc, animated: true, completion: nil)
    }
}

