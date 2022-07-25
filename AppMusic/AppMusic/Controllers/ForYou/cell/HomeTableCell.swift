//
//  HomeTableCell.swift
//  AppMusic
//
//  Created by Nguyen Thi Oanh on 11/07/2022.
//

import UIKit

class HomeTableCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    //MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
