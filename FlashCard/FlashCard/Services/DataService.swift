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
    
    private var collections = [Collections]()
    private var cards = [Cards]()
    private var card = [Card]()

    static let instance = DataService()
    
    private let collection = [
        Collection(title: "animals", titleImage: "animals_lbl"),
        Collection(title: "fruits", titleImage: "fruits_lbl"),
        Collection(title: "favorits", titleImage: "favorits_lbl")
    ]
    
    private let animales = [
        //Card(imageName: "cat", name: "گربه", isFavorit: false, voice: "gorbeh"),
        Card(imageName: "dog", name: "سگ", isFavorit: false, voice: "sag"),
        Card(imageName: "horse", name: "اسب", isFavorit: false, voice: "asb"),
        //Card(imageName: "lion", name: "شیر", isFavorit: false, voice: "shir"),
        Card(imageName: "cow", name: "گاو", isFavorit: false, voice: "gav"),
//        Card(imageName: "sheep", name: "گوسفند", isFavorit: false, voice: "gusfand"),
        Card(imageName: "elephant", name: "فیل", isFavorit: false, voice: "fil"),
//        Card(imageName: "squirrel", name: "سنجاب", isFavorit: false, voice: "sanjab"),
//        Card(imageName: "zebra", name: "گورخر", isFavorit: false, voice: "gurekhar"),
        Card(imageName: "rabbit", name: "خرگوش", isFavorit: false, voice: "khargush")
    ]
    private let fruits = [
        Card(imageName: "apple", name: "سیب", isFavorit: false, voice: "sib"),
        Card(imageName: "benana", name: "موز", isFavorit: false, voice: "moz"),
        Card(imageName: "grape", name: "انگور", isFavorit: false, voice: "angur"),
        Card(imageName: "orange", name: "پرتقال", isFavorit: false, voice: "porteghal"),
        Card(imageName: "strawberry", name: "توت فرنگی", isFavorit: false, voice: "tutfarangi"),
        Card(imageName: "apricot", name: "زردآلو", isFavorit: false, voice: "zardalu"),
        Card(imageName: "kiwi", name: "کیوی", isFavorit: false, voice: "kiwi"),
        Card(imageName: "pear", name: "گلابی", isFavorit: false, voice: "golabi"),
        Card(imageName: "cherry", name: "گیلاس", isFavorit: false, voice: "gilas"),
        Card(imageName: "peach", name: "هلو", isFavorit: false, voice: "holu")
    ]

    private var favorits = [Card]()
    private var savedFavorits = [Cards]()

    init() {
        context = appDelegate.persistentContainer.viewContext
        
        fetchCollections()
        // ***
        savedFavorits.removeAll()
        savedFavorits = fetchFavorits()
    }
    
    // Fetch collection list from coredata
    func fetchCollections() {
//        var colTitle : String
//        var colTitleImage : String
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Collections")
        request.returnsObjectsAsFaults = false
        
        do{
            let result = try context.fetch(request)
            if result.count > 0 {
                collections.removeAll()
                collections = result as! [Collections]
//                for res in result as! [NSManagedObject]
//                {
//                    colTitle = res.value(forKey: "title") as! String
//                    colTitleImage = res.value(forKey: "titleImage") as! String
//                    collections.append(Collections(entity: colTitle, insertInto: colTitleImage))
//                }
            }
        }catch{
            print(error)
        }
    }
    
    // Fetch cards accoring to the collection title
    func fetchCards(colTilte: String) -> [Cards]{
        
        do {
            let predicate =  NSPredicate(format: "relCollections.title == %@", colTilte)
            let fetchCards = NSFetchRequest<NSFetchRequestResult>(entityName: "Cards")
            fetchCards.predicate = predicate
            fetchCards.returnsObjectsAsFaults = false
            if let CardsResults = try context.fetch(fetchCards) as? [Cards]
            {
                card.removeAll()
                cards.removeAll()
                for res in CardsResults
                {
                    let imageName = res.value(forKey: "imageName") as! String
                    let cardName = res.value(forKey: "name") as! String
                    let favorit = res.value(forKey: "isFavorit") as! Bool
                    let voice = res.value(forKey: "voice") as! String
                    card.append(Card(imageName: imageName, name: cardName, isFavorit: favorit, voice: voice))
                }
                return CardsResults
            }
        }catch {
            print(error)
        }
        return cards
    }
    
    // Fetch cards that user set to favorits
    func fetchFavorits() -> [Cards]{
        do {
            let predicate =  NSPredicate(format: "isFavorit == %@", true as CVarArg)
            let fetchCards = NSFetchRequest<NSFetchRequestResult>(entityName: "Cards")
            fetchCards.predicate = predicate
            fetchCards.returnsObjectsAsFaults = false
            if let CardsResults = try context.fetch(fetchCards) as? [Cards]
            {
                card.removeAll()
                cards.removeAll()
                for res in CardsResults
                {
                    let imageName = res.value(forKey: "imageName") as! String
                    let cardName = res.value(forKey: "name") as! String
                    let favorit = res.value(forKey: "isFavorit") as! Bool
                    let voice = res.value(forKey: "voice") as! String
                    card.append(Card(imageName: imageName, name: cardName, isFavorit: favorit, voice: voice))
                }
                return CardsResults
            }
        }catch {
            print(error)
        }
        return cards
    }
    
    func setCards(collection: Collection){
        let newCard = NSEntityDescription.insertNewObject(forEntityName: "Cards", into: context)
        let newCollection = NSEntityDescription.insertNewObject(forEntityName: "Collections", into: context)
        
        for item in cards
        {
            newCard.setValue(item.imageName, forKey: "imageName")
            newCard.setValue(item.name, forKey: "name")
            newCard.setValue(item.isFavorit, forKey: "isFavorit")
            newCard.setValue(item.voice, forKey: "voice")
            
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
    // call for first runnig app to fill the coredata
    let version = "V1"
    
    
    func seedPersistentStoreWithManagedObjectContext(_ managedObjectContext: NSManagedObjectContext) {
        let defautlVersion = UserDefaults()
        if defautlVersion.value(forKey: "version") as? String != version{
        // Delete info that saved before
        // collections
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Collections")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error")
        }
        //cards
        let deleteFetchCards = NSFetchRequest<NSFetchRequestResult>(entityName: "Cards")
        let deleteRequestCards = NSBatchDeleteRequest(fetchRequest: deleteFetchCards)
        
        do {
            try context.execute(deleteRequestCards)
            try context.save()
        } catch {
            print ("There was an error")
        }
        
        for col in collection {
            
            // Create collection List
            let newCollection = NSEntityDescription.insertNewObject(forEntityName: "Collections", into: context)
            newCollection.setValue(col.title, forKey: "title")
            newCollection.setValue(col.titleImage, forKey: "titleImage")
            
            card.removeAll()
            cards.removeAll()
            card = getCards(forCollectionTitle: col.title)

            var isFavorit : Bool
            for cd in card {
                isFavorit = cd.isFavorit
                // Create card Item
                let newCard = NSEntityDescription.insertNewObject(forEntityName: "Cards", into: context) as! Cards

                newCard.setValue(cd.imageName, forKey: "imageName")
                newCard.setValue(cd.name, forKey: "name")
                //newCard.setValue(cd.isFavorit, forKey: "isFavorit")
                if savedFavorits.count > 0{
                    for fv in savedFavorits{
                        if fv.imageName == cd.imageName{
                           isFavorit = true
                            break
                        }
                    }
                }
                newCard.setValue(isFavorit, forKey: "isFavorit")
                newCard.setValue(cd.voice, forKey: "voice")
                newCard.setValue(newCollection, forKey: "relCollections")
                cards.append(newCard)
                }
            do {
                // Save Managed Object Context
                //try managedObjectContext.save()
                try context.save()
                
            } catch {
                print("Unable to save managed object context.")
            }
        }

    // Update User Defaults
    //UserDefaults.standard.set(true, forKey: didSeedPersistentStore)
    defautlVersion.set(version, forKey: "version")
        }
        else {
            return
        }
    }

    
    func getCollections()->[Collection]
    {
        return collection
    }
    
    // Get the cards from coredata
    func getColCards(forCollectionTitle title: String) -> [Cards] {
        if title == "favorits"
        {
            return fetchFavorits()
        }
        
        return fetchCards(colTilte: title)
    }
    
    // get cards from default values
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
        favorits = [Card(imageName: card.imageName!, name: card.name!, isFavorit: card.isFavorit, voice: card.voice!)]
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
