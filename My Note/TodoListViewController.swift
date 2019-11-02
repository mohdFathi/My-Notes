//
//  ViewController.swift
//  My Note
//
//  Created by Fathi on 11/2/19.
//  Copyright © 2019 Fathi. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = ["first " , "second" , "last"]
    let defualts = UserDefaults.standard
    
    let defaultsKey = "ToDoListArray"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let items = UserDefaults.standard.array(forKey: defaultsKey) as? [String] {
            itemArray = items
        }
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell" ,for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        
        
    
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else {
             tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
       
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    

    @IBAction func addItemButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Note", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Note", style: .default) { (action) in
            print("note is : \(textField.text!)")
            
            //TODO: prevent adding note if it is empty
            self.itemArray.append(textField.text!)
            
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

