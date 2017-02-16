//
//  Productlist+CoreDataProperties.swift
//  E-CommerceTask
//
//  Created by Sierra 4 on 14/02/17.
//  Copyright © 2017 codebrew2. All rights reserved.
//

import Foundation
import CoreData


extension Productlist {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Productlist> {
        return NSFetchRequest<Productlist>(entityName: "Productlist");
    }

    @NSManaged public var descriptionProduct: String?
    @NSManaged public var id: Int64
    @NSManaged public var price: Float
    @NSManaged public var productName: String?
    @NSManaged public var category: Categorylist?

}
