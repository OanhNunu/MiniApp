//
//  SettingsViewController.swift
//  AppMusic
//
//  Created by Nguyen Thi Oanh on 28/07/2022.
//

import UIKit

class SettingsViewController: UIViewController {

    //MARK: - Variables
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private var sections = [Section]()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Settings"
        self.configureModels()
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func configureModels() {
        sections.append(Section(title: "Profile",
                                options: [Option(title: "My Profile",
                                                 handler: { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.viewProfile()
            }
        })]))
        
        sections.append(Section(title: "Account",
                                options: [Option(title: "Sign Out",
                                                 handler: { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.signOutTapped()
            }
        })]))
    }
    
    private func signOutTapped() {
        UserDefaults.standard.set(false, forKey: "LOGGED_IN")
        App.shared.swipeBackToLogin()
    }
    
    private func viewProfile() {
        let vc = ForYouViewController()
        vc.title = "Profile"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }

}

//MARK: - UITableViewDataSource
extension SettingsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = sections[indexPath.section].options[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = model.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let model = sections[section]
        return model.title
    }
}

//MARK: - UITableViewDelegate
extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = sections[indexPath.section].options[indexPath.row]
        model.handler()
    }
}

