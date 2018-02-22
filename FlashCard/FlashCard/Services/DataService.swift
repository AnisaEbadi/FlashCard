//
//  DataService.swift
//  FlashCard
//
//  Created by Anisa Ebadi on 2/19/18.
//  Copyright © 2018 NikanSoft. All rights reserved.
//

import Foundation

class DataService {
    static let instance = DataService()
    
    private let collections = [
        Collection(title: "animals", titleImage: "animals_lbl"),
        Collection(title: "fruits", titleImage: "fruits_lbl.png"),
        Collection(title: "favorits", titleImage: "favorits_lbl.png")
    ]
    
    private let animales = [
        Card(imageName: "cat.png", name: "گربه", isFavorit: false),
        Card(imageName: "dog.png", name: "سگ", isFavorit: false),
        Card(imageName: "horse.png", name: "اسب", isFavorit: false)
    ]
    
    private let fruits = [
        Card(imageName: "apple.png", name: "سیب", isFavorit: false),
        Card(imageName: "benana", name: "موز", isFavorit: false)
    ]
    
    private var favorits = [Card]()
    
    func getCollections()->[Collection]
    {
        return collections
    }
    
    func  getCards(forCollectionTitle title: String) -> [Card] {
        switch title {
        case "animals":
            return getAnimals()
        case "fruits":
            return getFruits()
        case "favorits":
            return getFavoritCards()
        default:
            return getAnimals()
        }
    }
    
    func getAnimals() -> [Card]
    {
        return animales
    }
    
    func getFruits() -> [Card] {
        return fruits
    }
    
    func setFavoritCrads(card: Card){
        favorits = [Card(imageName: card.imageName, name: card.name, isFavorit: card.isFavorit)]
    }
    
    func  getFavoritCards() -> [Card] {
        return favorits
    }
}
