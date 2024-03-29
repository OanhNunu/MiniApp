//
//  BaseCollectionView.swift
//  AppMusic
//
//  Created by Nguyen Thi Oanh on 12/07/2022.
//

import UIKit
import Alamofire
import Kingfisher

class AlbumsCollectionView: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var albumSearchBar: UISearchBar!
    
    //MARK: - Variables
    var album: [AlbumsItem]?
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Album"
        albumSearchBar.delegate = self
        albumSearchBar.placeholder = "Tìm tên album hoặc tên ca sĩ"
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "CollectionCell", bundle: nil), forCellWithReuseIdentifier: "CollectionCell")
        let screenWidth = UIScreen.main.bounds.width
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: (screenWidth/2)-25, height: (screenWidth/2)-25)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        collectionView.collectionViewLayout = layout
        getAlbumList(query: "o")
    }
    
    func getAlbumList(query: String) {
        let url = API.urlAPI
        let headers: HTTPHeaders = [HTTPHeader(name: "X-RapidAPI-Key", value: API.valueKey),
                                    HTTPHeader(name: "X-RapidAPI-Host", value: API.valueHost)]
        let params: Parameters = ["q": query,
                                  "type": "albums",
                                  "offset": 0,
                                  "limit": 30,
                                  "numberOfTopResults": 10]
        AF.request(url, parameters: params, headers: headers).validate()
            .responseDecodable(of: SearchAlbumsResponse.self) { response in
                guard let album = response.value else { return }
                print(album)
                self.album = album.albums?.items
                self.collectionView.reloadData()
            }
    }
    
    func getTrackListID(_ uri: String) -> String? {
        if uri.contains("spotify:album:") {
            let id = uri.replacingOccurrences(of: "spotify:album:", with: "")
            return id
        } else {
            return nil
        }
    }
    
}

//MARK: - UICollectionViewDataSource
extension AlbumsCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return album?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionCell
        if let album = self.album?[indexPath.row] {
            cell.configureAlbumsCell(with: album)
        }
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension AlbumsCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let uri = self.album?[indexPath.row].data?.uri,
              let id = self.getTrackListID(uri) else { return }
        let vc = PlayMusicViewController()
        vc.tractListID = id
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - UISearchBarDelegate
extension AlbumsCollectionView: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let album = searchBar.text else { return }
        getAlbumList(query: album)
        collectionView.reloadData()
        searchBar.resignFirstResponder()
        
    }
}
