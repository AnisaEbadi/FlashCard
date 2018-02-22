//
//  HomeVC.swift
//  FlashCard
//
//  Created by Anisa Ebadi on 2/19/18.
//  Copyright © 2018 NikanSoft. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    //var collection : Collection!
    
    // Go the card view
//    func next() {
//        performSegue(withIdentifier: "cardVCSegue", sender: self)
//    }
    
    func selectedCollection(collection: Collection){
        performSegue(withIdentifier: "cardVCSegue", sender: collection)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func onAnimalBtnTapped(_ sender: Any) {
        //selectedCollection(title: "animals")
        
        selectedCollection(collection: DataService.instance.getCollections()[0])
    }
    
    @IBAction func onFruitsBtnTapped(_ sender: Any) {
        selectedCollection(collection: DataService.instance.getCollections()[1])
    }
    
    @IBAction func onColorBtnTapped(_ sender: Any) {
        //selectedCollection(collection: DataService.instance.getCollections()[2])
    }
    
    @IBAction func onThingsBtnTapped(_ sender: Any) {
        //selectedCollection(collection: DataService.instance.getCollections()[3])
    }
    
    @IBAction func onFavoritBtnTapped(_ sender: Any) {
        selectedCollection(collection: DataService.instance.getCollections()[2])
    }
    
    @IBAction func unwindFromCardVC(unwindSeue: UIStoryboardSegue){}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cardVC = segue.destination as? CardVC{
            assert(sender as? Collection != nil)
            cardVC.initCards(collection: sender as! Collection)
        }
    }

}
