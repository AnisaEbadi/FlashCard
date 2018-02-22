//
//  CardNameLbl.swift
//  FlashCard
//
//  Created by Anisa Ebadi on 2/19/18.
//  Copyright © 2018 NikanSoft. All rights reserved.
//

import UIKit

@IBDesignable
class CardNameLbl: UILabel {

    override func prepareForInterfaceBuilder() {
        customizeView()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        customizeView()
    }
    
    func customizeView(){
        textColor = #colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1)
        textAlignment = .center
        font = UIFont(name: "BradleyHand-Bold", size: 32)
    }

}
