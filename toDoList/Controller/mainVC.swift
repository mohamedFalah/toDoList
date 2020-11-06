//
//  ViewController.swift
//  toDoList
//
//  Created by Mohammed Alshulah on 04/11/2020.
//

import UIKit
import CoreData
class mainVC: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {
   
    
    @IBOutlet weak var segmentController: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyListAlert: UILabel!
    
    //fetching controller with the type of object fetched <Item>
    var fetchedResults: NSFetchedResultsController<Item>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        //get the data from coreData
        //addData()
        fetch()
    
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if fetchedResults.fetchedObjects?.count == 0 {
            emptyListAlert.isHidden = false
        } else {
            emptyListAlert.isHidden = true
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchedResults.sections {
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell") as? TableViewCell {
            configureCell(cell: cell, index: indexPath as NSIndexPath)
            return cell
        } else {
            return TableViewCell()

        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    //for configure cell in two differernt places for ....
    func configureCell(cell: TableViewCell, index: NSIndexPath ){
        
        let item = fetchedResults.object(at: index as IndexPath)
        
        cell.configureCell(item: item)
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let objects = fetchedResults.fetchedObjects, objects.count > 0 {
            let item = objects[indexPath.row]
            performSegue(withIdentifier: "editItem", sender: item)
        }
        
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = fetchedResults.sections {
            return sections.count
        }
        
        return 0
    }
        
    @IBAction func AddToDo(_ sender: Any) {
        
        performSegue(withIdentifier: "newItem", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "editItem" else {return}
        if let destination = segue.destination as? itemDetailVC {
            if let item = sender as? Item {
                destination.itemToEdit = item
            }
        }
    }
    
    //get data function
    func fetch() {
        // fetch request variable to be passed to fetch controller
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        
        //sort the data descriptor
        let dateSort = NSSortDescriptor(key: "date", ascending: false)
        
        
        //pass the sorter
        request.sortDescriptors = [dateSort]
        
        //show based on segment selection
        if segmentController.selectedSegmentIndex == 0 {
            request.predicate = NSPredicate(format: "status == \(false)")
        } else {
            request.predicate = NSPredicate(format: "status == \(true)")
        }
        
        //create the fetch conterler
        
        fetchedResults = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResults.delegate = self
        
        
        
        do {
            try self.fetchedResults.performFetch()
            
            if fetchedResults.fetchedObjects?.count == 0 {
                emptyListAlert.isHidden = false
            } else {
                emptyListAlert.isHidden = true
            }
            
        }catch {
            let error = error as NSError
            print("error: \(error)")
        }
        
    }
    
    
    //reload data with segment choice
    @IBAction func segmentChange(_ sender: Any) {
        fetch()
        tableView.reloadData()
    }
    
    
    
    //when table view about to update listen to changes and hadle it here
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    // deals with manpulation of data in the controller
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch(type) {
            
            case.insert:
                if let indexPath = newIndexPath {
                    tableView.insertRows(at: [indexPath], with: .left)
                }
                break
            case.delete:
                if let indexPath = indexPath {
                    tableView.deleteRows(at: [indexPath], with: .left)
                }
                break
            case.move:
                if let indexPath = indexPath {
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }
                if let indexPath = newIndexPath {
                    tableView.insertRows(at: [indexPath], with: .fade)
                }
                
                break
            case.update:
                if let indexPath = indexPath {
                    let cell = tableView.cellForRow(at: indexPath) as! TableViewCell
                    configureCell(cell: cell, index: indexPath as NSIndexPath)
                }
                
                break
            
            @unknown default:
                print("not sure why all cases covered as known")
        }
    }
    
    
    
    func addData () {
        let person = Person(context: context)
        person.name = "Mohammed Falah"
        
        let item = Item(context: context)
        item.name = "Buy ps5"
        item.toPerson = person
        item.status = false
        
        let item1 = Item(context: context)
        item1.name = "Buy fifa21"
        item1.toPerson = person
        item1.status = false
        
        let item2 = Item(context: context)
        item2.name = "find new home"
        item2.toPerson = person
        item2.status = false
        
        let item3 = Item(context: context)
        item3.name = "Talk to her"
        item3.toPerson = person
        item3.status = false
        
        appDel.saveContext()
    }
    
    
}

