//
//  HomeViewController.swift
//  ThaiSeng
//
//  Created by Brian Ng on 7/10/16.
//  Copyright © 2016 ng. All rights reserved.
//

import UIKit
import SideMenu
import PageMenu

class HomeViewController: UIViewController, CAPSPageMenuDelegate {
    var pageMenu : CAPSPageMenu?
    let STATUS_BAR_HEIGHT:CGFloat = 20.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupSideMenu()
        self.setupPageMenu()
        Singleton.sharedInstance.homeViewController = self
    }
    
    func setupSideMenu() {
        SideMenuManager.menuFadeStatusBar = false
    }
    
    func setupPageMenu() {
        // Array to keep track of controllers in page menu
        var controllerArray : [UIViewController] = []
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newestViewController = mainStoryboard.instantiateViewControllerWithIdentifier("CatalogViewController")
        newestViewController.title = "Newest"
        controllerArray.append(newestViewController)
        
        let specialsViewController : UIViewController = UIViewController()
        specialsViewController.title = "Specials"
        controllerArray.append(specialsViewController)
        
        let hotViewController : UIViewController = UIViewController()
        hotViewController.title = "Hot"
        controllerArray.append(hotViewController)
        
        let recentViewController : UIViewController = UIViewController()
        recentViewController.title = "Recently Viewed"
        controllerArray.append(recentViewController)
        
        // Customize page menu parameters
        let parameters: [CAPSPageMenuOption] = [
            .MenuItemSeparatorWidth(10),
            .MenuItemWidthBasedOnTitleTextWidth(true),
            .EnableHorizontalBounce(true),
            .ScrollMenuBackgroundColor(UIColor(red: 157/256, green: 11/256, blue: 40/256, alpha: 1.0)),
            .UnselectedMenuItemLabelColor(UIColor.whiteColor())
        ]
        
        // Initialize page menu
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRectMake(0.0, 0.0, self.view.frame.width, self.view.frame.height), pageMenuOptions: parameters)
        
        // Set pageMenu delegate
        pageMenu!.delegate = self
        
        // Add page menu to view
        self.view.addSubview(pageMenu!.view)
    }
    
    func willMoveToPage(controller: UIViewController, index: Int) {
        
    }
    
    func didMoveToPage(controller: UIViewController, index: Int) {
        
    }


}

