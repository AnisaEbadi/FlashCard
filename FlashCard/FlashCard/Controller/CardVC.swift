//
//  CardVC.swift
//  FlashCard
//
//  Created by Anisa Ebadi on 2/19/18.
//  Copyright © 2018 NikanSoft. All rights reserved.
//

import UIKit
import CoreData

class CardVC: UIViewController {

    private(set) public var collection : Collection!
    private(set) public var card = [Card]()
    
    private(set) public var cards = [Cards]()
    
    var index = 0
    
    
    @IBOutlet weak var starBtn: UIButton!
    @IBOutlet weak var titleImg: UIImageView!
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var cardName: CardNameLbl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        titleImg.image = UIImage(named: collection.titleImage)
        setItems()
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(swipe:)))
        leftSwipe.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(swipe:)))
        rightSwipe.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(rightSwipe)
    }
    
    
    func initCards(collection: Collection){
        
        self.collection = collection
        //card = DataService.instance.getCards(forCollectionTitle: collection.title)
        cards = DataService.instance.getColCards(forCollectionTitle: collection.title)
        
    }
    // Core Data
    
//    let moc = DataController(completionClosure: () -> () ).managedObjectContext
//    func seedCards()
//    {
//        let entity = NSEntityDescription.insertNewObject(forEntityName: "Cards", into: moc) as! Cards
//        
//        for item in cards
//        {
//            entity.imageName = item.imageName
//            entity.name = item.name
//            entity.isFavorit = item.isFavorit
//            
//            do{
//                try moc.save()
//            }catch{
//                fatalError("Failure to save context \(error)")
//            }
//        }
//        
//    }
//    
//    func fetchCards(){
//        
//    }
    
    @objc func swipeAction(swipe: UISwipeGestureRecognizer){
//        switch swipe.direction {
//        case UISwipeGestureRecognizerDirection.left: // next
//            if index < (card.count-1) {
//                index = index + 1
//            }
//            else{
//                index = 0
//            }
//            setItems()
//            //print("left")
//        case UISwipeGestureRecognizerDirection.right: // previous
//            if index > 0{
//                index = index - 1
//            }
//            else{
//                index = card.count - 1
//            }
//            setItems()
//        default:
//            break
//        }
        
        switch swipe.direction {
        case UISwipeGestureRecognizerDirection.left: // next
            if index < (cards.count-1) {
                index = index + 1
            }
            else{
                index = 0
            }
            setItems()
        //print("left")
        case UISwipeGestureRecognizerDirection.right: // previous
            if index > 0{
                index = index - 1
            }
            else{
                index = cards.count - 1
            }
            setItems()
        default:
            break
        }
    }
    
    func setItems(){
//        cardImage.image = UIImage(named: card[index].imageName)
//        cardName.text = card[index].name
//        if(card[index].isFavorit){
//            starBtn.setImage(#imageLiteral(resourceName: "star_fill_btn"), for: .normal)
//        }
//        else{
//            starBtn.setImage(#imageLiteral(resourceName: "star_btn"), for: .normal)
//        }
        
        cardImage.image = UIImage(named: cards[index].imageName!)
        cardName.text = cards[index].name
        if(cards[index].isFavorit){
            starBtn.setImage(#imageLiteral(resourceName: "star_fill_btn"), for: .normal)
        }
        else{
            starBtn.setImage(#imageLiteral(resourceName: "star_btn"), for: .normal)
        }
    }

    @IBAction func onStarBtnTapped(_ sender: Any) {
//        if(card[index].isFavorit){
//            starBtn.setImage(#imageLiteral(resourceName: "star_btn"), for: .normal)
//        }
//        else
//        {
//            starBtn.setImage(#imageLiteral(resourceName: "star_fill_btn"), for: .normal)
//        }
//        card[index].Favorit = !card[index].isFavorit
//
//        // save to database
//        DataService.instance.setFavoritCrads(card: card[index])

        if(cards[index].isFavorit){
            starBtn.setImage(#imageLiteral(resourceName: "star_btn"), for: .normal)
        }
        else
        {
            starBtn.setImage(#imageLiteral(resourceName: "star_fill_btn"), for: .normal)
        }
        cards[index].isFavorit = !cards[index].isFavorit
        
        // save to database
        DataService.instance.setFavoritCrads(card: cards[index])
    }
    
}


