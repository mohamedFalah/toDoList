//
//  Item+CoreDataClass.swift
//  toDoList
//
//  Created by Mohammed Alshulah on 04/11/2020.
//
//

import Foundation
import CoreData

@objc(Item)
public class Item: NSManagedObject {

    public override func awakeFromInsert() {
        super.awakeFromInsert()
        self.date = Date()
    }
}
