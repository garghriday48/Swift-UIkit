//
//  CDContacts+CoreDataProperties.swift
//  contact
//
//  Created by Pragath on 15/03/23.
//
//

import Foundation
import CoreData


extension CDContacts {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDContacts> {
        return NSFetchRequest<CDContacts>(entityName: "CDContacts")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var id: UUID?
    @NSManaged public var phnNumber: [String]?
    @NSManaged public var secondName: String?

}

extension CDContacts : Identifiable {

}
