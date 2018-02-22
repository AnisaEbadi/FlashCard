//
//  CardVC.swift
//  FlashCard
//
//  Created by Anisa Ebadi on 2/19/18.
//  Copyright © 2018 NikanSoft. All rights reserved.
//

import UIKit

class CardVC: UIViewController {

    private(set) public var collection : Collection!
    private(set) public var cards = [Card]()
    
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
        cards = DataService.instance.getCards(forCollectionTitle: collection.title)
        
    }
    
    @objc func swipeAction(swipe: UISwipeGestureRecognizer){
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
        cardImage.image = UIImage(named: cards[index].imageName)
        cardName.text = cards[index].name
        if(cards[index].isFavorit){
            starBtn.setImage(#imageLiteral(resourceName: "star_fill_btn"), for: .normal)
        }
        else{
            starBtn.setImage(#imageLiteral(resourceName: "star_btn"), for: .normal)
        }
    }

    @IBAction func onStarBtnTapped(_ sender: Any) {
        if(cards[index].isFavorit){
            starBtn.setImage(#imageLiteral(resourceName: "star_btn"), for: .normal)
        }
        else
        {
            starBtn.setImage(#imageLiteral(resourceName: "star_fill_btn"), for: .normal)
        }
        cards[index].Favorit = !cards[index].isFavorit
        
        // save to database
        DataService.instance.setFavoritCrads(card: cards[index])
        
    }
    
}


