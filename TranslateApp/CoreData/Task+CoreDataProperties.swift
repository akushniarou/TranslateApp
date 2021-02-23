//
//  Task+CoreDataProperties.swift
//  
//
//  Created by Artur Kushniarou on 22.02.21.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var enteredWord: String?
    @NSManaged public var originalLanguage: String?
    @NSManaged public var picture: Data?
    @NSManaged public var targetLanguage: String?
    @NSManaged public var translatedWord: String?

}
