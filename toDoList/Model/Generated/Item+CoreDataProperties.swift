//
//  Item+CoreDataProperties.swift
//  toDoList
//
//  Created by Mohammed Alshulah on 04/11/2020.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var date: Date?
    @NSManaged public var name: String?
    @NSManaged public var status: Bool
    @NSManaged public var toItemType: ItemType?
    @NSManaged public var toPerson: Person?

}

extension Item : Identifiable {

}
