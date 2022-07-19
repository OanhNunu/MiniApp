//
//  MusicViewController.swift
//  AppMusic
//
//  Created by Nguyen Thi Oanh on 11/07/2022.
//

import UIKit
import Alamofire
import Kingfisher

class MusicViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var nameSearchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Variables
    //var music: PlayList?
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Danh sách bài hát"
        
        nameSearchBar.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MusicCell", bundle: nil), forCellReuseIdentifier: "MusicCell")
        
        searchNameMusic()
    }
    
    func searchNameMusic() {
//        let url = "https://spotify23.p.rapidapi.com/playlist/"
//        let param: Parameters = ["id": "37i9dQZF1DX4Wsb4d7NKfP"]
//        AF.request(url, parameters: param)
//            .validate()
//            .responseDecodable(of: PlayList.self) { response in
//                // 4
//                guard let music = response.value else { return }
//                self.music = music
//                self.tableView.reloadData()
//            }
    }
    
}

//MARK: - UITableViewDataSource
extension MusicViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MusicCell", for: indexPath) as! MusicCell
//        if let url = URL(string: music?.images?.first?.url ?? "") {
//            cell.musicImageView.kf.setImage(with: url)
//        }
//        cell.nameMusicLabel.text = music?.name
//        cell.singerMusicLabel.text = music?.owner?.id
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = PlayMusicViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - UITableViewDelegate
extension MusicViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

//MARK: - UISearchBarDelegate
extension MusicViewController: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        guard let nameMusic = searchBar.text else { return }
        searchNameMusic()
        
        searchBar.text = nil
        searchBar.resignFirstResponder()
        
        tableView.reloadData()
    }
}
