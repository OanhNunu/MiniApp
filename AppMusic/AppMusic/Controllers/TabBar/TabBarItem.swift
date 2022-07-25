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
    case Music
    case ForYou
    
    var allTab: [UIViewController] {
        return [TabBarItem.Home.viewController, TabBarItem.Album.viewController, TabBarItem.Artist.viewController, TabBarItem.ForYou.viewController]
    }
    
    var title: String {
        switch self {
        case .Home:
            return "Music"
        case .Album:
            return "Album"
        case .Artist:
            return "Artist"
        case .Music:
            return "Music"
        case .ForYou:
            return "For You"
        }
    }
    
    var item: UITabBarItem {
        switch self {
        case .Home:
            return UITabBarItem(title: self.title, image: UIImage(named: "playlist")?.withRenderingMode(.alwaysTemplate), selectedImage: UIImage(named: "playlist")?.withRenderingMode(.alwaysTemplate))
        case .Album:
            return UITabBarItem(title: self.title, image: UIImage(named: "music-library")?.withRenderingMode(.alwaysTemplate), selectedImage: UIImage(named: "music-library")?.withRenderingMode(.alwaysTemplate))
        case .Artist:
            return UITabBarItem(title: self.title, image: UIImage(named: "micro")?.withRenderingMode(.alwaysTemplate), selectedImage: UIImage(named: "micro")?.withRenderingMode(.alwaysTemplate))
        case .Music:
            return UITabBarItem(title: self.title, image: UIImage(named: "playlist")?.withRenderingMode(.alwaysTemplate), selectedImage: UIImage(named: "playlist")?.withRenderingMode(.alwaysTemplate))
        case .ForYou:
            return UITabBarItem(title: self.title, image: UIImage(named: "user")?.withRenderingMode(.alwaysTemplate), selectedImage: UIImage(named: "user")?.withRenderingMode(.alwaysTemplate))
        }
    }
    
    var viewController: UIViewController {
        switch self {
        case .Home:
            let vc = HomeViewController()
            vc.tabBarItem = self.item
            let navi = UINavigationController(rootViewController: vc)
            return navi
        case .Album:
            let vc = BaseCollectionView()
            vc.tabBarItem = self.item
            let navi = UINavigationController(rootViewController: vc)
            return navi
        case .Artist:
            let vc = ArtistViewController()
            vc.tabBarItem = self.item
            let navi = UINavigationController(rootViewController: vc)
            return navi
        case .Music:
            let vc = UIViewController()
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
