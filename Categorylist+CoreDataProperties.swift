//
//  Categorylist+CoreDataProperties.swift
//  E-CommerceTask
//
//  Created by Sierra 4 on 14/02/17.
//  Copyright © 2017 codebrew2. All rights reserved.
//

import Foundation
import CoreData


extension Categorylist {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Categorylist> {
        return NSFetchRequest<Categorylist>(entityName: "Categorylist");
    }

    @NSManaged public var categoryName: String?
    @NSManaged public var id: Int64
    @NSManaged public var parentId: Int64
    @NSManaged public var product: Productlist?

}
