//
//  Moods+CoreDataProperties.swift
//  MoodLog
//
//  Created by Meghna . on 01/02/2021.
//
//

import Foundation
import CoreData


extension Moods {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Moods> {
        return NSFetchRequest<Moods>(entityName: "Moods")
    }

    @NSManaged public var date: Date
    @NSManaged public var mood: String

}

extension Moods : Identifiable {

    //returns the last mood logged
    static func fetchRequestLimit1() -> NSFetchRequest<Moods> {
        let request: NSFetchRequest<Moods> = Moods.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Moods.date, ascending: false)]
        request.fetchLimit = 1
        request.includesPendingChanges = false
        request.includesPropertyValues = true

        return request
    }
    
    
    
    
}
