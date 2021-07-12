//
//  ActivityRatings+CoreDataProperties.swift
//  MoodLog
//
//  Created by Meghna . on 23/03/2021.
//
//

import Foundation
import CoreData


extension ActivityRatings {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ActivityRatings> {
        return NSFetchRequest<ActivityRatings>(entityName: "ActivityRatings")
    }

    @NSManaged public var activity: String
    @NSManaged public var rating: Int16
    @NSManaged public var date: Date?


}

extension ActivityRatings : Identifiable {

}
