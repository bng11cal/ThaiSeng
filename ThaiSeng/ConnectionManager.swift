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
    static let sharedInstance : ConnectionManager = ConnectionManager()
    
    // MARK: - Products.GET
    func getAllProducts(completion: (success: Bool, products: [Product]) -> Void) {
        let products = [Product]()
        let URL = NSURL(string: baseURL + "products/")
        NSURLSession.sharedSession().dataTaskWithURL(URL!) {
            (data, response, error) in
            
            guard let httpResponse = response as? NSHTTPURLResponse else {
                completion(success: false, products: products)
                return
            }
            
            if httpResponse.statusCode != 200 {
                print("[Error] getAllProducts() status code not 200 - status code: " + httpResponse.statusCode.description)
                completion(success: false, products: products)
                return
            }
            
            do {
                if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as? [NSDictionary] {
                    completion(success: true, products: self.mapDictToProducts(json))
                    return
                } else {
                    print("[Error] ")
                    completion(success: false, products: products)
                    return
                }
            } catch {
                print(error)
                completion(success: false, products: products)
                return
            }
        }.resume()
    }
    
    // MARK: Products.POST
    
    // MARK: Products.PUT
    
    // MARK: - Mappings
    func mapDictToProduct(dict: NSDictionary) -> Product {
        let product = Product()
        self.mapDictToProduct(dict, product: product)
        return product
    }
    
    func mapDictToProduct(dict: NSDictionary, product: Product) {
        product.id = dict["_id"] as? String
        product.name = dict["name"] as? String
        product.country = dict["country"] as? String
        product.type = dict["type"] as? String
        product.company = dict["company"] as? String
        product.status = dict["status"] as? String
        product.unitPrice = dict["unitPrice"]?.doubleValue
        product.unitVol = dict["unitVol"]?.integerValue
        if let label = dict["label"] as? String {
            product.label = label
        }
        product.description = dict["description"] as? String
        if let vintage = dict["vintage"]?.integerValue {
            product.vintage = vintage
        }
        product.percentAlcohol = dict["percentAlchohol"]?.integerValue
        if let batchDate = dict["batchDate"]?.integerValue {
            product.dateAdded = NSDate(timeIntervalSince1970: Double(batchDate))
        }
        
        product.grapeVarieties.removeAll()
        if let grapeVarietiesArray = dict["grapeVarieties"] as? [String] {
            for grapeVariety in grapeVarietiesArray {
                product.grapeVarieties.append(grapeVariety)
            }
        }
        
        product.packages.removeAll()
        if let packagesDicts = dict["packages"] as? [NSDictionary] {
            for packageDict in packagesDicts {
                let package = Package()
                package.count = packageDict["count"]?.integerValue
                package.price = packageDict["price"]?.doubleValue
                package.volume = packageDict["volume"]?.integerValue
                package.productId = packageDict["productId"] as? String
                product.packages.append(package)
            }
        }
    }
    
    func mapDictToProducts(dict: [NSDictionary]) -> [Product] {
        var products = [Product]()
        for productDict in dict {
            products.append(self.mapDictToProduct(productDict))
        }
        return products
    }
    
    
}