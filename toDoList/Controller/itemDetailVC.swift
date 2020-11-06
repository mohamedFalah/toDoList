//
//  itemDetailVC.swift
//  toDoList
//
//  Created by Mohammed Alshulah on 05/11/2020.
//

import UIKit

class itemDetailVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
   
    
    
    @IBOutlet weak var itemNameTextField: UITextField!
    @IBOutlet weak var personNameTextField: UITextField!
    @IBOutlet weak var finishedPickerView: UIPickerView!
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    
    
    var choices = ["No, Not Finished yet", "yes, It is finished"]
    var itemToEdit: Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //remove the title from the leading button to go back
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        
        finishedPickerView.dataSource = self
        finishedPickerView.delegate = self
        
        if itemToEdit == nil {
            //hide the delete button if view to add new item
            
            deleteButton.isEnabled = false
            
        } else {
            //load date and keep the delete button
            loadInfo()
        }
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return choices.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return choices[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // update somthing
    }

    @IBAction func deleteItem(_ sender: Any) {
        
        //delete an item
        if itemToEdit != nil {
            context.delete(itemToEdit!)
            appDel.saveContext()
            navigationController?.popViewController(animated: true)
        }

    }
    @IBAction func saveItem(_ sender: Any) {
        
        guard let itemName = itemNameTextField.text,
              let personName = personNameTextField.text,
              let itemStatus = finishedPickerView else {
            
            print("error")
            //handle things
            return
        }
        
        //item entity to modify
        var item: Item!
        
        if itemToEdit == nil {
            item = Item(context: context)
        } else {
            item = itemToEdit
        }
        //add to name property
        item.name = itemName
        //create person entity (Relationship)
        let person = Person(context: context)
        person.name = personName
        //add person entity to item entity
        item.toPerson = person
        //get the value from pickerview and add it to item entity
        let status = itemStatus.selectedRow(inComponent: 0)
        if status == 0 {
            item.status = false
        } else {
            item.status = true
        }
        //save the changes
        appDel.saveContext()
        
        //back to previous view
        navigationController?.popViewController(animated: true)
    }
    
    func loadInfo () {
        
        guard let item = itemToEdit else {return}
        
        itemNameTextField.text = item.name
        personNameTextField.text = item.toPerson?.name
        if item.status {
            finishedPickerView.selectRow(1, inComponent: 0, animated: true)
        } else {
            finishedPickerView.selectRow(0, inComponent: 0, animated: true)
        }
        
        
    }
  
    

}
