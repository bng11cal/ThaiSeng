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
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ConnectionManager.sharedInstance.getAllProducts() {
            (success, products) in
            
        }
        
        // Make the status bar show in side menu
        SideMenuManager.menuFadeStatusBar = false
        
        // Array to keep track of controllers in page menu
        var controllerArray : [UIViewController] = []
        
        // Create variables for all view controllers you want to put in the
        // page menu, initialize them, and add each to the controller array.
        // (Can be any UIViewController subclass)
        // Make sure the title property of all view controllers is set
        // Example:
        let latestViewController : UIViewController = UIViewController()
        latestViewController.title = "Latest"
        controllerArray.append(latestViewController)
        
        let specialsViewController : UIViewController = UIViewController()
        specialsViewController.title = "Specials"
        controllerArray.append(specialsViewController)
        
        let hotViewController : UIViewController = UIViewController()
        hotViewController.title = "Hot"
        controllerArray.append(hotViewController)
        
        let recentViewController : UIViewController = UIViewController()
        recentViewController.title = "Recently Viewed"
        controllerArray.append(recentViewController)
        
        // Customize page menu to your liking (optional) or use default settings by sending nil for 'options' in the init
        // Example:
        let parameters: [CAPSPageMenuOption] = [
            .MenuItemSeparatorWidth(10),
            .MenuItemWidth(100),
            .EnableHorizontalBounce(true),
            .ScrollMenuBackgroundColor(UIColor(red: 157/256, green: 11/256, blue: 40/256, alpha: 1.0)),
            .UnselectedMenuItemLabelColor(UIColor.whiteColor())
        ]
        
        // Initialize page menu with controller array, frame, and optional parameters
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRectMake(0.0,navigationBar.frame.size.height, self.view.frame.width, self.view.frame.height - navigationBar.frame.size.height), pageMenuOptions: parameters)
        
        // Set pageMenu delegate
        pageMenu!.delegate = self
        
        // Lastly add page menu as subview of base view controller view
        // or use pageMenu controller in you view hierachy as desired
        self.view.addSubview(pageMenu!.view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func willMoveToPage(controller: UIViewController, index: Int) {
    
    }
    
    func didMoveToPage(controller: UIViewController, index: Int) {
    
    }


}

