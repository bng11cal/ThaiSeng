//
//  ProductCollectionViewCell.swift
//  ThaiSeng
//
//  Created by Brian Ng on 8/21/16.
//  Copyright © 2016 ng. All rights reserved.
//

import Foundation
import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var price: UILabel!
    
    override func awakeFromNib() {
        
    }
    
    func updateContent(product: Product) {
        self.name.text = product.name
        self.country.text = product.country
        self.price.text = "RM" + (product.unitPrice?.description)! + " / " + product.unitVol!.description + "mL"
    }
    
    
}