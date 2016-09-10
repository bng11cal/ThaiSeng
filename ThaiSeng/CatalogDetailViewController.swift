//
//  CatalogDetailViewController.swift
//  ThaiSeng
//
//  Created by Brian Ng on 8/31/16.
//  Copyright © 2016 ng. All rights reserved.
//

import Foundation
import UIKit

class CatalogDetailViewController: UIViewController {
    var product:Product!
    
    @IBOutlet weak var iboName: UILabel!
    @IBOutlet weak var iboImage: UIImageView!
    @IBOutlet weak var iboCountry: UILabel!
    @IBOutlet weak var iboCompany: UILabel!
    @IBOutlet weak var iboDescription: UILabel!
    @IBOutlet weak var iboPrice: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if product != nil {
            self.updateContent(product)
        }
        
    }
    
    func updateContent(product: Product) {
        self.product = product
        iboName.text = product.name
        iboCountry.text = product.country
        iboCompany.text = product.company
        iboDescription.text = product.description
        iboPrice.text = String(format: "RM%.2f", product.unitPrice!)
    }
    
    
}
