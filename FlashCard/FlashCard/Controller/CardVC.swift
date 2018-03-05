//
//  CardVC.swift
//  FlashCard
//
//  Created by Anisa Ebadi on 2/19/18.
//  Copyright © 2018 NikanSoft. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation

class CardVC: UIViewController {

    private(set) public var collection : Collection!
    private(set) public var card = [Card]()
    
    private(set) public var cards = [Cards]()
    
    var player: AVAudioPlayer?
    
    var index = 0
    
    @IBOutlet weak var starBtn: UIButton!
    @IBOutlet weak var titleImg: UIImageView!
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var cardName: CardNameLbl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleImg.image = UIImage(named: collection.titleImage)
        setItems()  // Set card view controller entities
        
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
    
    @objc func swipeAction(swipe: UISwipeGestureRecognizer){
        switch swipe.direction {
        case UISwipeGestureRecognizerDirection.left: // next
            if index < (cards.count-1) {
                index = index + 1
            }
            else{
                index = 0
            }
            setItems() // set card view controller items
        case UISwipeGestureRecognizerDirection.right: // previous
            if index > 0{
                index = index - 1
            }
            else{
                index = cards.count - 1
            }
            setItems() // set card view controller items
        default:
            break
        }
    }
    
    /// set card view controller items
    func setItems(){
        if cards.count > 0
        {
            cardImage.image = UIImage(named: cards[index].imageName!)
            cardName.text = cards[index].name
            if(cards[index].isFavorit){
                starBtn.setImage(#imageLiteral(resourceName: "star_fill_btn"), for: .normal)
            }
            else{
                starBtn.setImage(#imageLiteral(resourceName: "star_btn"), for: .normal)
            }
            
            guard let url = Bundle.main.url(forResource: cards[index].voice, withExtension: "mp3") else { return }

            do{
                player = try AVAudioPlayer(contentsOf: url)
                
            }catch{
                print(error)
            }
           
            UIView.animate(withDuration: 0.7, animations: {
                
                self.cardImage.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                
            }, completion: {
                (true) in
                
                UIView.animate(withDuration: 0.7, animations: {
                    
                    self.cardImage.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                    
                }, completion: nil)
                
                guard let player = self.player else { return }
                player.play()
                
            })
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
        cards[index].isFavorit = !cards[index].isFavorit
        
        // save to database
        DataService.instance.setFavoritCrads(card: cards[index])
    }
    
}


