//
//  TaskDB+CoreDataProperties.swift
//  todo_Inderjit_C0771917
//
//  Created by Inderjit on 25/06/20.
//  Copyright © 2020 Inderjit. All rights reserved.
//
//

import Foundation
import CoreData


extension TaskDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskDB> {
        return NSFetchRequest<TaskDB>(entityName: "TaskDB")
    }

    @NSManaged public var category: String?
    @NSManaged public var completed: Bool
    @NSManaged public var desc: String?
    @NSManaged public var time: Date?
    @NSManaged public var title: String?

}
