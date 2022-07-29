//
//  ArtistViewController.swift
//  AppMusic
//
//  Created by Nguyen Thi Oanh on 18/07/2022.
//

import UIKit
import Alamofire
import Kingfisher

class ArtistViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var artistCollView: UICollectionView!
    
    //MARK: - Variables
    var artist: [ArtistData]?
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Nghệ sĩ"
        
        artistCollView.dataSource = self
        artistCollView.register(UINib(nibName: "CollectionCell", bundle: nil), forCellWithReuseIdentifier: "CollectionCell")
        
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let screenWidth = UIScreen.main.bounds.width
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        flowLayout.itemSize = CGSize(width: (screenWidth/3)-25, height: (screenWidth/3)-25)
        flowLayout.minimumInteritemSpacing = 5
        flowLayout.minimumLineSpacing = 5
        artistCollView.collectionViewLayout = flowLayout
        
        getArtistList(query: "linh")
    }
    
    func getArtistList(query: String) {
        let url = API.urlAPI
        let headers: HTTPHeaders = [HTTPHeader(name: "X-RapidAPI-Key", value: API.valueKey),
                                    HTTPHeader(name: "X-RapidAPI-Host", value: API.valueHost)]
        let params: Parameters = ["q": query,
                                  "type": "artists",
                                  "offset": 0,
                                  "limit": 50,
                                  "numberOfTopResults": 5]
        AF.request(url, parameters: params, headers: headers).validate()
            .responseDecodable(of: SearchAlbumsResponse.self) { response in
                guard let artist = response.value else { return }
                print(artist)
                self.artist = artist.artists?.items
                self.artistCollView.reloadData()
            }
    }
}

extension ArtistViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return artist?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = artistCollView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionCell
        if let artists = self.artist?[indexPath.row] {
            cell.configureArtistsCell(with: artists)
        }
        return cell
    }
}
