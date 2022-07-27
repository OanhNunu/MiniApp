//
//  TabBarController.swift
//  AppMusic
//
//  Created by Nguyen Thi Oanh on 09/07/2022.
//

import UIKit

class TabBarController: UITabBarController {
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewControllers = [TabBarItem.Home.viewController, TabBarItem.Album.viewController, TabBarItem.Artist.viewController,TabBarItem.Music.viewController, TabBarItem.ForYou.viewController]
    }
}
