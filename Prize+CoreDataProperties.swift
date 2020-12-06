//
//  Prize+CoreDataProperties.swift
//  Prizes
//
//  Created by Valerii on 06.12.2020.
//  Copyright © 2020 Valerii. All rights reserved.
//
//

import Foundation
import CoreData


extension Prize {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Prize> {
        return NSFetchRequest<Prize>(entityName: "Prize")
    }

    @NSManaged public var uuid: UUID?
    @NSManaged public var name: String?
    @NSManaged public var price: Double
    @NSManaged public var isSelected: Bool
    @NSManaged public var date: Date?

}
