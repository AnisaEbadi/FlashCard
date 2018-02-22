//
//  Card.swift
//  FlashCard
//
//  Created by Anisa Ebadi on 2/19/18.
//  Copyright © 2018 NikanSoft. All rights reserved.
//

import Foundation

struct Card {
//    var image: UIImage?
//    var name: String?
//    var isFavorit: Bool?
    private(set) public var imageName: String
    private(set) public var name: String
    private(set) public var isFavorit: Bool
    
    var Favorit: Bool{
        get{
            return self.isFavorit
        }
        set(value){
            self.isFavorit = value
        }
    }
    
    init(imageName: String, name: String, isFavorit: Bool) {
        self.imageName = imageName
        self.name = name
        self.isFavorit = isFavorit
    }
}
