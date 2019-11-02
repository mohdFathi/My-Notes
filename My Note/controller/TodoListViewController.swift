//
//  ViewController.swift
//  My Note
//
//  Created by Fathi on 11/2/19.
//  Copyright © 2019 Fathi. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    let defualts = UserDefaults.standard
    
    let defaultsKey = "ToDoListArray"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let newItem = Item()
        newItem.title = "first"
        newItem.done = true
        itemArray.append(newItem)
        
        let newItem1 = Item()
        newItem1.title = "Second"
        itemArray.append(newItem1)
        
        let newItem2 = Item()
        newItem2.title = "Third"
        itemArray.append(newItem2)
        if let items = defualts.array(forKey: defaultsKey) as? [Item] {
            itemArray = items
        }
    
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell" ,for: indexPath)
        
         let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
    
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        
        let item = itemArray[indexPath.row]
        item.done = !item.done
        
        tableView.reloadData()
       
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addItemButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Note", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Note", style: .default) { (action) in
            print("note is : \(textField.text!)")
            
            //TODO: prevent adding note if it is empty
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            
            self.defualts.set(self.itemArray, forKey: self.defaultsKey)//this line saves the array to user defaults
            
            self.tableView.reloadData() //because the daatasource have been changed by adding the new note to the array
        }
        
        alert.addTextField { (alertTextField) in
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}

