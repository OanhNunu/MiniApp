//
//  MusicCell.swift
//  AppMusic
//
//  Created by Nguyen Thi Oanh on 09/07/2022.
//

import UIKit

class MusicCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var musicImageView: UIImageView!
    @IBOutlet weak var nameMusicLabel: UILabel!
    @IBOutlet weak var singerMusicLabel: UILabel!
    
    //MARK: - Variables
//    var album: Album? {
//        didSet {
//            if let album = album {
//                musicImageView.image = UIImage(named: album.image)
//                nameMusicLabel.text = album.name
//                singerMusicLabel.text = "\(album.songs.count) Songs"
//            }
//        }
//    }
    
    //MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUpImageView()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setUpImageView() {
        musicImageView.layer.cornerRadius = musicImageView.frame.width/4
        musicImageView.clipsToBounds = true
        musicImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
        musicImageView.contentMode = .scaleAspectFill
    }
    
}
