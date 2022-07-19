//
//  LoginViewController.swift
//  AppMusic
//
//  Created by Nguyen Thi Oanh on 09/07/2022.
//

import UIKit

class LoginViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: - Actions
    @IBAction func touchLoginButton(_ sender: Any) {
        let sdt = "123456789"
        let pass = "123"
        if phoneNumberTextField.text == sdt, passwordTextField.text == pass {
            UserDefaults.standard.set(true, forKey: "LOGGED_IN")
            App.shared.swipeLoginToMain()
            
        } else {
            let alert = UIAlertController(title: "Logged failed!", message: "Enter your information, please!", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Cancel", style: .destructive) { action in
                print("Logined failed")
            }
            alert.addAction(cancel)
            present(alert, animated: true)
        }
        phoneNumberTextField.text = nil
        passwordTextField.text = nil
    }
    
}
