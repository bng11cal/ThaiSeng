//
//  Product.swift
//  ThaiSeng
//
//  Created by Brian Ng on 8/21/16.
//  Copyright © 2016 ng. All rights reserved.
//

import Foundation

class Product {
    var id:String?
    var name:String?
    var type:String?
    var company:String?
    var country:String?
    var percentAlcohol:Int?
    var status:String?
    var unitPrice:Double?
    var unitVol:Int?
    var label:String?
    var grapeVarieties:[String] = [String]()
    var vintage:Int?
    var description:String?
    var dateAdded:NSDate?
    var packages:[Package] = [Package]()
}