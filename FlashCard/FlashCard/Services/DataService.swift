//
//  DataService.swift
//  FlashCard
//
//  Created by Anisa Ebadi on 2/19/18.
//  Copyright © 2018 NikanSoft. All rights reserved.
//

import UIKit
import CoreData

class DataService {
    
    // Core Data
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context : NSManagedObjectContext
    
    private var collections = [Collection]()
    private var animales = [Card]()
    private var fruits = [Card]()
    private var favorits = [Card]()
    
    private var cards = [Cards]()
    private var card = [Card]()

    init() {
        //let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //let
        context = appDelegate.persistentContainer.viewContext

//        self.collections = [
//            Collection(title: "animals", titleImage: "animals_lbl"),
//            Collection(title: "fruits", titleImage: "fruits_lbl"),
//            Collection(title: "favorits", titleImage: "favorits_lbl")
//        ]
//
//        self.animales = [
//            Card(imageName: "cat", name: "گربه", isFavorit: false),
//            Card(imageName: "dog", name: "سگ", isFavorit: false),
//            Card(imageName: "horse", name: "اسب", isFavorit: false)
//        ]
//
//        self.fruits = [
//            Card(imageName: "apple", name: "سیب", isFavorit: false),
//            Card(imageName: "benana", name: "موز", isFavorit: false)
//        ]
//
        fetchCollections()
    }
    
    func fetchCollections() {
        //let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //let
        //context = appDelegate.persistentContainer.viewContext
        var colTitle : String
        var colTitleImage : String
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Collections")
        request.returnsObjectsAsFaults = false
        
        do{
            let result = try context.fetch(request)
            //let cols = try context.fetch(request) as! [Collections]
            //print(cols[0].relCards)
            if result.count > 0 {
                collections.removeAll()
                cards.removeAll()
                for res in result as! [NSManagedObject]
                {
                    colTitle = res.value(forKey: "title") as! String
                    colTitleImage = res.value(forKey: "titleImage") as! String
//                    if colTitle == "fruits"{
//                        var resCards = res. .mutableArrayValue(forKey: "relCards")
//                        //var resCards = res.value(forKey: "relCards") as? [Cards]
//                        //cards = (res.value(forKey: "relCards") as? [Cards])!
//                        print(resCards)
//                    }
                    collections.append(Collection(title: colTitle, titleImage: colTitleImage))
                    
                }
            }
            //fetchData(colTilte: collections[0].title)
            
       }catch{
            print(error)
       }
        //return collections
    }
    func fetchCards(colTilte: String) -> [Cards]{
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let context = appDelegate.persistentContainer.viewContext
        
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Cards")
//        request.returnsObjectsAsFaults = false

//        do{
//            let result = try context.fetch(request)
//            //var cardName : String
//            if result.count > 0 {
//                for res in result as! [NSManagedObject]
//                {
//                    //var col = res.value(forKey: "relCollection") as? Collections
//                    var cardName = res.value(forKey: "name") as! String
//                    print(cardName)
//
//                }
//            }
//
//        }catch{
//
//        }
        
        do {
            let predicate =  NSPredicate(format: "relCollections.title == %@", colTilte)//NSPredicate(format: "title == %@", colTilte)
            let fetchCards = NSFetchRequest<NSFetchRequestResult>(entityName: "Cards")
            fetchCards.predicate = predicate
            fetchCards.returnsObjectsAsFaults = false
            //if let CardsResults = try context.fetch(fetchCards) as? [Cards] {
            if let CardsResults = try context.fetch(fetchCards) as? [Cards]
            {
                card.removeAll()
                cards.removeAll()
                for res in CardsResults
                {
                   //var col = res.value(forKey: "relCollection") as? Collections
                    let imageName = res.value(forKey: "imageName") as! String
                    let cardName = res.value(forKey: "name") as! String
                    let favorit = res.value(forKey: "isFavorit") as! Bool
//                   print(cardName)
                    card.append(Card(imageName: imageName, name: cardName, isFavorit: favorit))
                }
                return CardsResults
            }
        }catch {
            print(error)
        }
        return cards
    }
    
    func fetchFavorits() -> [Cards]{
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let context = appDelegate.persistentContainer.viewContext
        do {
            let predicate =  NSPredicate(format: "isFavorit == %@", true as CVarArg)//NSPredicate(format: "title == %@", colTilte)
            let fetchCards = NSFetchRequest<NSFetchRequestResult>(entityName: "Cards")
            fetchCards.predicate = predicate
            fetchCards.returnsObjectsAsFaults = false
            //if let CardsResults = try context.fetch(fetchCards) as? [Cards] {
            if let CardsResults = try context.fetch(fetchCards) as? [Cards]
            {
                card.removeAll()
                cards.removeAll()
                for res in CardsResults
                {
                    //var col = res.value(forKey: "relCollection") as? Collections
                    let imageName = res.value(forKey: "imageName") as! String
                    let cardName = res.value(forKey: "name") as! String
                    let favorit = res.value(forKey: "isFavorit") as! Bool
                    //                   print(cardName)
                    card.append(Card(imageName: imageName, name: cardName, isFavorit: favorit))
                }
                return CardsResults
            }
        }catch {
            print(error)
        }
        return cards
    }
    
    func setCards(collection: Collection){
        //let context = appDelegate.persistentContainer.viewContext
        let newCard = NSEntityDescription.insertNewObject(forEntityName: "Cards", into: context)
        let newCollection = NSEntityDescription.insertNewObject(forEntityName: "Collections", into: context)
        
        for item in cards
        {
            newCard.setValue(item.imageName, forKey: "imageName")
            newCard.setValue(item.name, forKey: "name")
            newCard.setValue(item.isFavorit, forKey: "isFavorit")
            
            
            newCollection.setValue(collection.title, forKey: "title")
            newCollection.setValue(collection.titleImage, forKey: "titleImage")
            do{
                try context.save()
            }catch{
                print("Error in save data \(error)")
            }
        }
    }
    
    // **********************
    let didSeedPersistentStore = "didSeedPersistentStore"
    
    //let coreDataManager = CoreDataManager(modelName: "CardsModel")
    
     func seedPersistentStoreWithManagedObjectContext(_ managedObjectContext: NSManagedObjectContext) {
        guard !UserDefaults.standard.bool(forKey: didSeedPersistentStore) else { return }
        
        //let listNames = ["Home", "Work", "Leisure"]
        //let context = appDelegate.persistentContainer.viewContext
        //for listName in listNames {
        for col in collections {
        // Create List
            
       // if let list = createRecordForEntity("List", inManagedObjectContext: managedObjectContext) {
            let newCollection = NSEntityDescription.insertNewObject(forEntityName: "Collections", into: context)
            // Populate List
//            list.setValue(listName, forKey: "name")
//            list.setValue(Date(), forKey: "createdAt")
                newCollection.setValue(col.title, forKey: "title")
                newCollection.setValue(col.titleImage, forKey: "titleImage")
            
            card.removeAll()
            cards.removeAll()
            card = getCards(forCollectionTitle: col.title)
            
            // Add Items(cards)
            //for i in 1...10 {
                for cd in card {
                // Create Item
                //if let item = createRecordForEntity("Item", inManagedObjectContext: managedObjectContext) {
                 let newCard = NSEntityDescription.insertNewObject(forEntityName: "Cards", into: context) as! Cards
                    // Set Attributes
//                    item.setValue("Item \(i)", forKey: "name")
//                    item.setValue(Date(), forKey: "createdAt")
//                    item.setValue(NSNumber(value: (i % 3 == 0)), forKey: "completed")

                newCard.setValue(cd.imageName, forKey: "imageName")
                newCard.setValue(cd.name, forKey: "name")
                newCard.setValue(cd.isFavorit, forKey: "isFavorit")
                newCard.setValue(newCollection, forKey: "relCollections")
                    cards.append(newCard)
                    // Set List Relationship
                    //item.setValue(list, forKey: "list")
                
                     //newCollection.setValue(newCard, forKey: "relCards")
                }
           // }
        //}
            
            //newCollection.setValue(cards, forKey: "relCards")
            do {
                // Save Managed Object Context
                //try managedObjectContext.save()
                try context.save()
                
            } catch {
                print("Unable to save managed object context.")
            }
    }
    
    
    
    // Update User Defaults
    UserDefaults.standard.set(true, forKey: didSeedPersistentStore)
}

    
    static let instance = DataService()
    
//    private let collections = [
//        Collection(title: "animals", titleImage: "animals_lbl"),
//        Collection(title: "fruits", titleImage: "fruits_lbl"),
//        Collection(title: "favorits", titleImage: "favorits_lbl")
//    ]
//
//    private let animales = [
//        Card(imageName: "cat", name: "گربه", isFavorit: false),
//        Card(imageName: "dog", name: "سگ", isFavorit: false),
//        Card(imageName: "horse", name: "اسب", isFavorit: false)
//    ]
//
//    private let fruits = [
//        Card(imageName: "apple", name: "سیب", isFavorit: false),
//        Card(imageName: "benana", name: "موز", isFavorit: false)
//    ]
//
//    private var favorits = [Card]()
    
    func getCollections()->[Collection]
    {
        return collections
    }
    
    func getColCards(forCollectionTitle title: String) -> [Cards] {
        if title == "favorits"
        {
            return fetchFavorits()
        }
        
        return fetchCards(colTilte: title)
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
    
    func setFavoritCrads(card: Cards){
        favorits = [Card(imageName: card.imageName!, name: card.name!, isFavorit: card.isFavorit)]
        do {
            // Save Managed Object Context
            //try managedObjectContext.save()
            try context.save()
            
        } catch {
            print("Unable to save managed object context.")
        }
    }
    
    func  getFavoritCards() -> [Card] {
        return favorits
    }
}
