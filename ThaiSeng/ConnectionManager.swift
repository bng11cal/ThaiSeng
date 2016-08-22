//
//  ConnectionManager.swift
//  ThaiSeng
//
//  Created by Brian Ng on 8/21/16.
//  Copyright © 2016 ng. All rights reserved.
//

import Foundation

let baseURL = "http://localhost:3000/api/"

class ConnectionManager {
    
    // Singleton
    class var sharedInstance : ConnectionManager {
        struct Static {
            static let instance : ConnectionManager = ConnectionManager()
        }
        return Static.instance
    }
    
    func getAllProducts(completion: (success: Bool, products: [Product]?) -> Void) {
        let URL = NSURL(string: baseURL + "products/")
        NSURLSession.sharedSession().dataTaskWithURL(URL!) {
            (data, response, error) in
            
            if let httpResponse = response as? NSHTTPURLResponse {
                if httpResponse.statusCode != 200 {
                    completion(success: false, products: nil)
                    return
                }
            }
            
            do {
                if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as? [NSDictionary] {
                    print(json)
                    completion(success: true, products: self.mapDictToProducts(json))
                } else {
                    completion(success: false, products: nil)
                }
            } catch {
                print(error)
                completion(success: false, products: nil)
            }
        }.resume()
    }
    
    func mapDictToProduct(dict: NSDictionary) -> Product {
        let product = Product()
        product.id = dict["_id"] as? String
        product.name = dict["name"] as? String
        product.origin = dict["origin"] as? String
        product.category = dict["category"] as? String
        product.company = dict["company"] as? String
        product.label = dict["label"] as? String
        product.description = dict["description"] as? String
        product.vintage = dict["vintage"]?.integerValue
        product.percentAlcohol = dict["percentAlchohol"]?.doubleValue
        if let batchDate = dict["batchDate"]?.integerValue {
            product.batchDate = NSDate(timeIntervalSince1970: Double(batchDate))
        }
        
        if let grapeVarietiesArray = dict["grapeVarieties"] as? [String] {
            for grapeVariety in grapeVarietiesArray {
                product.grapeVarieties.append(grapeVariety)
            }
        }
        
        if let packagesDicts = dict["packages"] as? [NSDictionary] {
            for packageDict in packagesDicts {
                let package = Package()
                package.count = dict["count"]?.integerValue
                package.price = dict["price"]?.doubleValue
                package.volume = dict["volume"]?.integerValue
                package.productId = dict["productId"] as? String
            }
        }
        return product
    }
    
    func mapDictToProduct(dict: NSDictionary, product: Product) {
        product.id = dict["_id"] as? String
        product.name = dict["name"] as? String
        product.origin = dict["origin"] as? String
        product.category = dict["category"] as? String
        product.company = dict["company"] as? String
        product.label = dict["label"] as? String
        product.description = dict["description"] as? String
        product.vintage = dict["vintage"]?.integerValue
        product.percentAlcohol = dict["percentAlchohol"]?.doubleValue
        product.batchDate = NSDate(timeIntervalSince1970: Double((dict["batchDate"]?.integerValue)!))
        
        product.grapeVarieties.removeAll()
        if let grapeVarietiesArray = dict["grapeVarieties"] as? [String] {
            for grapeVariety in grapeVarietiesArray {
                product.grapeVarieties.append(grapeVariety)
            }
        }
        
        if let packagesDicts = dict["packages"] as? [NSDictionary] {
            for packageDict in packagesDicts {
                let package = Package()
                package.count = dict["count"]?.integerValue
                package.price = dict["price"]?.doubleValue
                package.volume = dict["volume"]?.integerValue
                package.productId = dict["productId"] as? String
            }
        }
    }
    
    func mapDictToProducts(dict: [NSDictionary]) -> [Product]? {
        var products = [Product]()
        for productDict in dict {
            products.append(self.mapDictToProduct(productDict))
        }
        return products
    }
}