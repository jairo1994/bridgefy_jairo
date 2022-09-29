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
        
        let countryOn = UIImage(named: "CountriesOn")
        let countryOff = UIImage(named: "CountriesOff")
        
        // Create Tab one
        let tabOne = CountriesViewController()
        let tabOneBarItem = UITabBarItem(title: "Countries", image: countryOff, selectedImage: countryOn)
        tabOne.tabBarItem = tabOneBarItem
        
        let bleOn = UIImage(named: "BLEOn")
        let bleOff = UIImage(named: "BLEOff")
        
        // Create Tab two
        let tabTwo = BLEViewController()
        let tabTwoBarItem2 = UITabBarItem(title: "BLE", image: bleOff, selectedImage: bleOn)
        tabTwo.tabBarItem = tabTwoBarItem2
        
        viewControllers = [tabOne, tabTwo]
        
        self.tabBar.tintColor = Colors.Enfasis.color
    }
    
    // UITabBarControllerDelegate method
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
    }
}
