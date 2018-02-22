//
//  Collection.swift
//  FlashCard
//
//  Created by Anisa Ebadi on 2/19/18.
//  Copyright © 2018 NikanSoft. All rights reserved.
//

import Foundation

struct Collection {
//    var title: String!
//    var cards : [Card]?
    private(set) public var title: String
    private(set) public var titleImage: String
    
    init(title: String, titleImage: String) {
        self.title = title
        self.titleImage = titleImage
    }
}
