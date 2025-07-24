//
//  TabViewController.swift
//  FastDelivery
//
//  Created by Gabriel Lopes on 18/07/25.
//

import UIKit

class TabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemGroupedBackground
        
        setupTabs()
    }
    
    private func setupTabs() {
        let home = createNav(with: "Home", and: UIImage(systemName: "house"), vc: HomeViewController())
        let cart = createNav(with: "Cart", and: UIImage(systemName: "cart"), vc: CartViewController())
        let perfil = createNav(with: "Perfil", and: UIImage(systemName: "person.fill"), vc: ProfileViewController())
        
        self.setViewControllers([home, cart, perfil], animated: true)
    }
    
    private func createNav(with title: String, and image: UIImage?, vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        nav.viewControllers.first?.navigationController?.title = title
        
        return nav
    }
}
