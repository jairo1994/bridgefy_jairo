//
//  TabBarViewController.swift
//  Bridgefy
//
//  Created by Jairo Lopez on 26/09/22.
//

import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create Tab one
        let tabOne = CountriesViewController()
        let tabOneBarItem = UITabBarItem(title: "Countries", image: UIImage(named: "defaultImage.png"), selectedImage: UIImage(named: "selectedImage.png"))
        tabOne.tabBarItem = tabOneBarItem
        
        
        // Create Tab two
        let tabTwo = BLEViewController()
        let tabTwoBarItem2 = UITabBarItem(title: "Tab 2", image: UIImage(named: "defaultImage2.png"), selectedImage: UIImage(named: "selectedImage2.png"))
        tabTwo.tabBarItem = tabTwoBarItem2
        
        viewControllers = [tabOne, tabTwo]
    }
    
    // UITabBarControllerDelegate method
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
    }
}
