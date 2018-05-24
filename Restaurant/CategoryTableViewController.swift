//
//  CategoryTableViewController.swift
//  Restaurant
//
//  Created by Aluno on 23/05/2018.
//  Copyright © 2018 wpstudart. All rights reserved.
//

import UIKit

class CategoryTableViewController: UITableViewController {

    let menuController = MenuController()
    var categories = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuController.fetchCategories{ (categories) in
            if let categories = categories {
                self.updateUI(with: categories)
            }
        }
    }
    
    func updateUI(with categories: [String]) {
        DispatchQueue.main.async {
            self.categories = categories
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCellIdentifier", for: indexPath)
        configure(cell: cell, forItemAt: indexPath)
        return cell
    }
    
    func configure(cell: UITableViewCell, forItemAt indexPath: IndexPath){
        let categoryString = categories[indexPath.row]
        cell.textLabel?.text = categoryString.capitalized
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MenuSegue" {
            let menuTableViewController = segue.destination as! MenuTableViewController
            let index = tableView.indexPathForSelectedRow!.row
            menuTableViewController.category = categories[index]
        }
    }
    
}
