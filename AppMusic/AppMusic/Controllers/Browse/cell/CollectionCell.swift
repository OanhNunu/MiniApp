//
//  HomeCollectionCell.swift
//  AppMusic
//
//  Created by Nguyen Thi Oanh on 11/07/2022.
//

import UIKit
import Kingfisher

class CollectionCell: UICollectionViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    
    //MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.cornerRadius = imageView.frame.height/9
        imageView.clipsToBounds = true
    }
    
    func configurePlayListsCell(with model: PlayListItem) {
        let list = model.data
        if let url = URL(string: list?.images?.items?.first?.sources?.first?.url ?? "") {
            imageView.kf.setImage(with: url)
        }
        nameLabel.text = list?.name
        artistLabel.text = list?.owner?.name
    }
    
    func configureAlbumsCell(with model: AlbumsItem) {
        if let album = model.data {
            if let url = URL(string: album.coverArt?.sources?.first?.url ?? "") {
                self.imageView.kf.setImage(with: url)
            }
            self.nameLabel.text = album.name
            self.artistLabel.text = album.artists?.items?.first?.data?.profile?.name
        }
    }
    
    func configureArtistsCell(with model: ArtistData) {
        if let url = URL(string: model.data?.visuals?.avatarImage?.sources?.first?.url ?? "") {
            imageView.kf.setImage(with: url)
        }
        nameLabel.text = model.data?.profile?.name
        artistLabel.isHidden = true
    }
    
}
