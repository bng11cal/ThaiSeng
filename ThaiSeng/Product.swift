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
    var category:String?
    var company:String?
    var origin:String?
    var percentAlcohol:Double?
    var status:String?
    var label:String?
    var grapeVarieties:[String] = [String]()
    var vintage:Int?
    var description:String?
    var batchDate:NSDate?
    var packages:[Package] = [Package]()
}