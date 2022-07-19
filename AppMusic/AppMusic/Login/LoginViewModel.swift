//
//  LoginViewModel.swift
//  AppMusic
//
//  Created by Nguyen Thi Oanh on 12/07/2022.
//

import UIKit

final class App {
    
    static var shared = App()
    
    var window: UIWindow!
    var mainNavigationController = TabBarController()
    var loginViewController = LoginViewController()
    
    func startInterface() {
        if UserDefaults.standard.bool(forKey: "LOGGED_IN") { ///check whether user logged or not
            window.rootViewController = mainNavigationController
        } else {
            window.rootViewController = loginViewController
        }
        window.makeKeyAndVisible()
    }
    
    func swipeBackToLogin() {
        let snapShot = window.snapshotView(afterScreenUpdates: true)
        if let snapShot = snapShot {
            loginViewController.view.addSubview(snapShot)
        }
        window.rootViewController = loginViewController
        
        UIView.animate(withDuration: 0.3, animations: {
            snapShot?.layer.opacity = 0
            snapShot?.layer.transform = CATransform3DMakeScale(1, 1, 1)
        }) { finished in
            snapShot?.removeFromSuperview()
        }
    }
    
    func swipeLoginToMain() {
        let snapShot = window.snapshotView(afterScreenUpdates: true)
        if let snapShot = snapShot {
            mainNavigationController.view.addSubview(snapShot)
        }
        window.rootViewController = mainNavigationController

        UIView.animate(withDuration: 0.3, animations: {
            snapShot?.layer.opacity = 0
            snapShot?.layer.transform = CATransform3DMakeScale(1, 1, 1)
        }) { finished in
            snapShot?.removeFromSuperview()
        }
    }

    
}
