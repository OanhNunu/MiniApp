//
//  SongTableViewCell.swift
//  AppMusic
//
//  Created by Nguyen Thi Oanh on 18/07/2022.
//

import UIKit

class SongTableViewCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var trackLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    
    //MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setupCell(model: AlbumModel) {
        self.trackLabel.text = model.name
        self.artistLabel.text = model.artists?.first?.name
    }
    
}
