//
//  HomeViewController.swift
//  AppMusic
//
//  Created by Nguyen Thi Oanh on 09/07/2022.
//

import UIKit
import Alamofire
import Kingfisher

class HomeViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var homeCollectionView: UICollectionView!
    
    //MARK: - Variables
    var playList: [PlayListItem]?
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Music"
        
        ///setup CollectionView
        homeCollectionView.dataSource = self
        homeCollectionView.delegate = self
        homeCollectionView.register(UINib(nibName: "HomeCollectionCell", bundle: nil), forCellWithReuseIdentifier: "HomeCollectionCell")
        let screenWidth = UIScreen.main.bounds.width
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: (screenWidth/2)-25, height: (screenWidth/2)-25)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        homeCollectionView!.collectionViewLayout = layout
        
        getMusicList(query: "o")
    }
    
    func getMusicList(query: String) {
        let url = API.urlAPI
        let headers: HTTPHeaders = [HTTPHeader(name: "X-RapidAPI-Key", value: API.valueKey),
                                    HTTPHeader(name: "X-RapidAPI-Host", value: API.valueHost)]
        let params: Parameters = ["q": query,
                                  "type": "playlists",
                                  "offset": 0,
                                  "limit": 40,
                                  "numberOfTopResults": 5]
        AF.request(url, parameters: params, headers: headers).validate()
            .responseDecodable(of: SearchAlbumsResponse.self) { response in
                guard let playlist = response.value else { return }
                print(playlist)
                self.playList = playlist.playlists?.items
                self.homeCollectionView.reloadData()
            }
    }
    
    func getTrackListID(_ uri: String) -> String? {
        if uri.contains("spotify:playlist:") {
            let id = uri.replacingOccurrences(of: "spotify:playlist:", with: "")
            return id
        } else {
            return nil
        }
    }
    
}

//MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return playList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = homeCollectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionCell", for: indexPath) as! HomeCollectionCell
        if let playList = self.playList?[indexPath.item] {
            if let url = URL(string: playList.data?.images?.items?.first?.sources?.first?.url ?? "") {
                cell.musicImageView.kf.setImage(with: url)
            }
            cell.nameMusicLabel.text = playList.data?.name
            cell.singMusicLabel.text = playList.data?.owner?.name
        }
        return cell
    }
    
}

//MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let uri = self.playList?[indexPath.row].data?.uri else { return }
        let url = URL(string: uri)!
        if UIApplication.shared.canOpenURL(url) {
            // opens spotify app and start playing song
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            // navigate user to app store spotify page if user doesnt have spotify app installed
            let alert = UIAlertController(title: "Mở AppStore", message: "Cài đặt Spotify để tiếp tục!", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .destructive, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true)
        }
    }
}
