//
//  Task+CoreDataProperties.swift
//  newsURL
//
//  Created by Kamiya Shogo on 2017/09/28.
//  Copyright © 2017年 Shogo Kamiya. All rights reserved.
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var article: String?
    @NSManaged public var name: String?
    @NSManaged public var saveDate: NSDate?
    @NSManaged public var url: String?

}
