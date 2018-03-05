//
//  Collections+CoreDataProperties.swift
//  FlashCard
//
//  Created by Anisa Ebadi on 2/26/18.
//  Copyright © 2018 NikanSoft. All rights reserved.
//
//

import Foundation
import CoreData


extension Collections {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Collections> {
        return NSFetchRequest<Collections>(entityName: "Collections")
    }

    @NSManaged public var title: String?
    @NSManaged public var titleImage: String?
    //@NSManaged public var relCards: NSSet?
    @NSManaged public var relCards: Cards?

}

// MARK: Generated accessors for relCards
extension Collections {

    @objc(addRelCardsObject:)
    @NSManaged public func addToRelCards(_ value: Cards)

    @objc(removeRelCardsObject:)
    @NSManaged public func removeFromRelCards(_ value: Cards)

    @objc(addRelCards:)
    @NSManaged public func addToRelCards(_ values: NSSet)

    @objc(removeRelCards:)
    @NSManaged public func removeFromRelCards(_ values: NSSet)

}
