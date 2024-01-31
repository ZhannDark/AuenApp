//
//  TabBarController.swift
//  FinalProject
//
//  Created by Zhanna Zhanashova on 22.12.2023.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        tabBar.backgroundColor = .white
        tabBar.layer.cornerRadius = 20
        self.tabBar.tintColor = .systemIndigo
        self.tabBar.unselectedItemTintColor = .secondaryLabel
        
        let home = MainController()
        let search = SearchController()
        let fav = FavoritesController()
        let profile = ProfileController()
        
        let firstTabBarItemImage = UIImage(systemName: "music.house")
        let secondTabBarItemImage = UIImage(systemName: "waveform.badge.magnifyingglass")
        let thirdTabBarItemImage = UIImage(systemName: "suit.heart")
        let fourthTabBarItemImage = UIImage(systemName: "person.crop.circle")
  
        home.tabBarItem = UITabBarItem(
            title: "Main",
            image: firstTabBarItemImage,
            selectedImage: firstTabBarItemImage
        )
        
        search.tabBarItem = UITabBarItem(
            title: "Search",
            image: secondTabBarItemImage,
            selectedImage: secondTabBarItemImage
        )
        
        fav.tabBarItem = UITabBarItem(
            title: "Favorites",
            image: thirdTabBarItemImage,
            selectedImage: thirdTabBarItemImage
        )
        
        profile.tabBarItem = UITabBarItem(
            title: "Profile",
            image: fourthTabBarItemImage,
            selectedImage: fourthTabBarItemImage
        )
        
        viewControllers = [home, search, fav, profile]
        
    }
}
