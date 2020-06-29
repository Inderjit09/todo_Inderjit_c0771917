//
//  CategoryDB+CoreDataProperties.swift
//  todo_Inderjit_C0771917
//
//  Created by Inderjit on 25/06/20.
//  Copyright © 2020 Inderjit. All rights reserved.
//
//

import Foundation
import CoreData


extension CategoryDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CategoryDB> {
        return NSFetchRequest<CategoryDB>(entityName: "CategoryDB")
    }

    @NSManaged public var title: String?

}
