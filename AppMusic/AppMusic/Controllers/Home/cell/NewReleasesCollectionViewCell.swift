//
//  NewReleasesCollectionViewCell.swift
//  AppMusic
//
//  Created by Nguyen Thi Oanh on 27/07/2022.
//

import UIKit
import Kingfisher

class NewReleasesCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Variables
    static let identifier = "NewReleaseCollectionViewCell"
    
    private let albumCoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let albumNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .thin)
        return label
    }()
    
    private let numberOfTracksLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .light)
        return label
    }()
    
    //MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(albumCoverImageView)
        contentView.addSubview(albumNameLabel)
        contentView.addSubview(artistNameLabel)
        contentView.addSubview(numberOfTracksLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        artistNameLabel.sizeToFit()
        numberOfTracksLabel.sizeToFit()
        
        let imageSize: CGFloat = contentView.frame.height - 10
        albumCoverImageView.frame = CGRect(x: 5, y: 5, width: imageSize, height: imageSize)
        
        let albumLabelSize = albumNameLabel.sizeThatFits(
            CGSize(width: contentView.frame.width - imageSize - 10,
                   height: contentView.frame.height - 10)
        )
        let albumLabelHeight = min(60, albumLabelSize.height)
        albumNameLabel.frame = CGRect(x: albumCoverImageView.frame.width + 10,
                                      y: 5,
                                      width: albumLabelSize.width,
                                      height: albumLabelHeight)
        
        artistNameLabel.frame = CGRect(x: albumCoverImageView.frame.width + 10,
                                       y: albumNameLabel.frame.height,
                                       width: contentView.frame.width - albumCoverImageView.frame.width - 10,
                                       height: 30)
        
        numberOfTracksLabel.frame = CGRect(x: albumCoverImageView.frame.width + 10,
                                           y: albumCoverImageView.frame.height - 44,
                                           width: numberOfTracksLabel.frame.width,
                                           height: 44)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        albumCoverImageView.image = nil
        albumNameLabel.text = nil
        artistNameLabel.text = nil
        numberOfTracksLabel.text = nil
    }
    
    func configure(with viewModel: PlayList) {
        guard let model = viewModel.items?.first?.data else { return }
        if let url = URL(string: model.images?.items?.first?.sources?.first?.url ?? "") {
            albumCoverImageView.kf.setImage(with: url)
        }
        albumNameLabel.text = model.name
        artistNameLabel.text = model.owner?.name
        numberOfTracksLabel.text = "Tracks: \(String(describing: viewModel.totalCount))"
    }
    
}
