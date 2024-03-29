//
//  TabBarItem.swift
//  AppMusic
//
//  Created by Nguyen Thi Oanh on 09/07/2022.
//

import UIKit

enum TabBarItem {
    case Home
    case Album
    case Artist
    case ForYou
    
    var allTab: [UIViewController] {
        return [TabBarItem.Home.viewController, TabBarItem.Album.viewController, TabBarItem.Artist.viewController, TabBarItem.ForYou.viewController]
    }
    
    var title: String {
        switch self {
        case .Home:
            return "Browse"
        case .Album:
            return "Album"
        case .Artist:
            return "Artist"
        case .ForYou:
            return "For You"
        }
    }
    
    var item: UITabBarItem {
        switch self {
        case .Home:
            return UITabBarItem(title: self.title, image: UIImage(named: "home-off")?.withRenderingMode(.alwaysTemplate), selectedImage: UIImage(named: "home-on")?.withRenderingMode(.alwaysTemplate))
        case .Album:
            return UITabBarItem(title: self.title, image: UIImage(named: "music-library")?.withRenderingMode(.alwaysTemplate), selectedImage: UIImage(named: "music-library")?.withRenderingMode(.alwaysTemplate))
        case .Artist:
            return UITabBarItem(title: self.title, image: UIImage(named: "micro")?.withRenderingMode(.alwaysTemplate), selectedImage: UIImage(named: "micro")?.withRenderingMode(.alwaysTemplate))
        case .ForYou:
            return UITabBarItem(title: self.title, image: UIImage(named: "user")?.withRenderingMode(.alwaysTemplate), selectedImage: UIImage(named: "user")?.withRenderingMode(.alwaysTemplate))
        }
    }
    
    var viewController: UIViewController {
        switch self {
        case .Home:
            let vc = BrowseViewController()
            vc.tabBarItem = self.item
            let navi = UINavigationController(rootViewController: vc)
            return navi
        case .Album:
            let vc = AlbumsCollectionView()
            vc.tabBarItem = self.item
            let navi = UINavigationController(rootViewController: vc)
            return navi
        case .Artist:
            let vc = ArtistViewController()
            vc.tabBarItem = self.item
            let navi = UINavigationController(rootViewController: vc)
            return navi
        case .ForYou:
            let vc = ForYouViewController()
            vc.tabBarItem = self.item
            let navi = UINavigationController(rootViewController: vc)
            return navi
        }
    }
}
