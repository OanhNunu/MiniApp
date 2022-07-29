//
//  PlayMusicViewController.swift
//  AppMusic
//
//  Created by Nguyen Thi Oanh on 09/07/2022.
//

import UIKit
import AVFoundation
import Alamofire
import Kingfisher

class PlayMusicViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var musicImage: UIImageView!
    @IBOutlet weak var musicSlider: UISlider!
    @IBOutlet weak var elapsedTimeLabel: UILabel!
    @IBOutlet weak var remainingTimeLabel: UILabel!
    @IBOutlet weak var nameMusicLabel: UILabel!
    @IBOutlet weak var singerMusicLabel: UILabel!
    @IBOutlet weak var volumeSlider: UISlider!
    
    @IBOutlet weak var playPauseButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Variables
    var player: AVPlayer?
    var timer: Timer?
    var playingIndex = 0
    
    var trackList = [PlayListItem]()
    var tractListID: String?
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Phát nhạc"
        volumeSlider.minimumValue = 0
        self.setupTableView()
        self.getTrackList()
    }
    
    func setupTableView() {
        self.tableView.register(UINib(nibName: "SongTableViewCell", bundle: nil), forCellReuseIdentifier: "SongTableViewCell")
        self.tableView.estimatedRowHeight = 60
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func playerInit() {
        let url = URL(string: "")
        if timer == nil {
            Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateVolumeSlider), userInfo: nil, repeats: true)
        }
        player = AVPlayer(url: url!)
        player?.play()
        guard let duration = player?.currentItem?.asset.duration else {
            return
        }
        let durationBySecond = CMTimeGetSeconds(duration)
        let min = Int(durationBySecond) / 60
        let second = Int(durationBySecond) % 60
        self.remainingTimeLabel.text = "\(min):\(second)"
        self.musicSlider.maximumValue = Float(durationBySecond)
    }
    
    @objc func updateVolumeSlider() {
        if let player = player {
            let currentTimeBySecond = CMTimeGetSeconds(player.currentTime())
            musicSlider.value = Float(currentTimeBySecond)
        }
    }
    
    func getTrackList() {
        guard let id = self.tractListID, !id.isEmpty else { return }
        let url = API.urlAPIAlbum
        let headers: HTTPHeaders = [HTTPHeader(name: "X-RapidAPI-Key", value: API.valueKey),
                                    HTTPHeader(name: "X-RapidAPI-Host", value: API.valueHost)]
        let params: Parameters = ["ids": id]
        AF.request(url, parameters: params, headers: headers).validate()
            .responseDecodable(of: SearchAlbumsResponse.self) { response in
                guard let album = response.value else { return }
                print(album)
                self.tableView.reloadData()
            }
    }
    
    func redirectToSpotify(uri: String) {
        let url = URL(string: uri)!
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            let alert = UIAlertController(title: "Mở AppStore", message: "Cài đặt Spotify để tiếp tục!", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .destructive, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true)
        }
    }
    
    //MARK: - Actions
    @IBAction func touchPlayPauseButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        if player != nil {
            if sender.isSelected == true {
                playPauseButton.imageView?.image = UIImage(named: "play")
                player?.pause()
            } else {
                playPauseButton.imageView?.image = UIImage(named: "pause")
                player?.play()
            }
        }
        
    }
    
    @IBAction func touchBackwardButton(_ sender: Any) {
    }
    
    @IBAction func touchForwardButton(_ sender: Any) {
    }
    
    @IBAction func changeVolumeSlider(_ sender: Any) {
        if player != nil {
            player?.pause()
            player?.volume = musicSlider.value
            player?.play()
        }
    }
}

//MARK: - UITableViewDelegate
extension PlayMusicViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.trackList[indexPath.row]
        if let uri = model.data?.uri {
            self.redirectToSpotify(uri: uri)
        }
        
    }
}

//MARK: - UITableViewDataSource
extension PlayMusicViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.trackList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongTableViewCell", for: indexPath) as! SongTableViewCell
        let track = self.trackList[indexPath.row]
        cell.configureDataCell(model: track)
        return cell
    }
}
