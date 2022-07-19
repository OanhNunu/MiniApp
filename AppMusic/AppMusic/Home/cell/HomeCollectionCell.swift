//
//  HomeCollectionCell.swift
//  AppMusic
//
//  Created by Nguyen Thi Oanh on 11/07/2022.
//

import UIKit

class HomeCollectionCell: UICollectionViewCell {

    //MARK: - Outlets
    @IBOutlet weak var musicImageView: UIImageView!
    @IBOutlet weak var nameMusicLabel: UILabel!
    @IBOutlet weak var singMusicLabel: UILabel!
    
    //MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        musicImageView.layer.cornerRadius = musicImageView.frame.height/9
        musicImageView.clipsToBounds = true
    }

}
