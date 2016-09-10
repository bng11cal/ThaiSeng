//
//  CatalogViewController.swift
//  ThaiSeng
//
//  Created by Brian Ng on 8/21/16.
//  Copyright © 2016 ng. All rights reserved.
//

import Foundation
import UIKit

let screenSize: CGRect = UIScreen.mainScreen().bounds

enum CatalogType {
    case Hot
    case Specials
    case RecentlyViewed
    case Newest
}

class CatalogViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var products:[Product] = [Product]()
    var type:CatalogType!
    
    @IBOutlet var productCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ConnectionManager.sharedInstance.getAllProducts() {
            (success, products) in
            if success {
                self.products = products
                dispatch_async(dispatch_get_main_queue(), {
                    self.productCollectionView.reloadData()
                });
            }
        }
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ProductCell", forIndexPath: indexPath) as! ProductCollectionViewCell
        cell.updateContent(products[indexPath.row])
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(screenSize.width/2 - 10, screenSize.height/3 - 10)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("CatalogDetailViewController") as! CatalogDetailViewController
        detailVC.product = products[indexPath.row]
        
        Singleton.sharedInstance.homeViewController.navigationController?.pushViewController(detailVC, animated: true)
    }
    
}