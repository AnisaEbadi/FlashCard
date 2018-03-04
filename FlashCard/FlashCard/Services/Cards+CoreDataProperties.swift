//
//  Cards+CoreDataProperties.swift
//  FlashCard
//
//  Created by Anisa Ebadi on 2/26/18.
//  Copyright © 2018 NikanSoft. All rights reserved.
//
//

import Foundation
import CoreData


extension Cards {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cards> {
        return NSFetchRequest<Cards>(entityName: "Cards")
    }

    @NSManaged public var imageName: String?
    @NSManaged public var isFavorit: Bool
    @NSManaged public var name: String?
    @NSManaged public var relCollections: Collections?

}
