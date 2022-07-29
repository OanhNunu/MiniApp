//
//  SceneDelegate.swift
//  AppMusic
//
//  Created by Nguyen Thi Oanh on 09/07/2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowscene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowscene)
        self.window = window
        
        App.shared.window = window
        App.shared.startInterface()
        
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
    }
    
}
