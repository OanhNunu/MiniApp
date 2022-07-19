//
//  PlayMusicViewController.swift
//  AppMusic
//
//  Created by Nguyen Thi Oanh on 09/07/2022.
//

import UIKit
import AVFoundation
import Alamofire

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
    
    var trackList = [AlbumModel]()
    var tractListID: String?
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Phát nhạc"
        ///self.playerInit()
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
        
//        volumeSlider.value = Float(player?.currentTime())
//        endLabel.text = getFormattedTime(timeInterval: player?.currentTime())
//        let remainingTime = player?.currentItem?.duration - player?.currentTime()
//        endLabel.text = getFormattedTime(timeInterval: remainingTime)
    }
    
    func getTrackList() {
        guard let id = self.tractListID, !id.isEmpty else { return }
        let url = "https://spotify23.p.rapidapi.com/albums/"
        let headers: HTTPHeaders = [HTTPHeader(name: "X-RapidAPI-Key", value: "544fa9d5e2msh875bb82680b4fd0p1977ecjsn1b74cd6c2652"),
                                    HTTPHeader(name: "X-RapidAPI-Host", value:"spotify23.p.rapidapi.com")]
        let params: Parameters = ["ids": id]
        AF.request(url, parameters: params, headers: headers).validate()
            .responseDecodable(of: AlbumsResponse.self) { response in
                guard let album = response.value else { return }
                print(album)
                self.trackList = album.albums ?? []
                self.tableView.reloadData()
            }
    }
    
    /*private func getFormattedTime(timeInterval: TimeInterval) -> String {
        let mins = timeInterval / 60
        let secs = timeInterval.truncatingRemainder(dividingBy: 60)
        let timeFormatter = NumberFormatter()
        timeFormatter.minimumIntegerDigits = 2
        timeFormatter.minimumFractionDigits = 0
        timeFormatter.roundingMode = .down
        
        guard let minsSting = timeFormatter.string(from: NSNumber(value: mins)), let secString = timeFormatter.string(from: NSNumber(value: secs)) else {
            return "00:00"
        }
        return "\(minsSting):\(secString)"
    }*/
    
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
    
//    func play() {
//        volumeSlider.value = 0.0
//        volumeSlider.maximumValue = Float(player?.currentItem?.duration)
//        player?.play()
//        touchPlayPauseButton(player.isSelected)
//    }
//
//    func stop() {
//        player?.pause()
//        timer?.invalidate()
//        timer = nil
//    }
    
    @IBAction func touchBackwardButton(_ sender: Any) {
//        playingIndex -= 1
//        if playingIndex < 0 {
//            playingIndex = album.songs.count - 1
//        }
//        playerInit(song: album.songs[playingIndex])
//        play()
//        touchPlayPauseButton(player.isSelected)
    }
    
    @IBAction func touchForwardButton(_ sender: Any) {
//        playingIndex += 1
//        if playingIndex > album.songs.count {
//            playingIndex = 0
//        }
//        playerInit(song: album.songs[playingIndex])
//        play()
//        touchPlayPauseButton(player.isSelected)
    }
    
    @IBAction func changeVolumeSlider(_ sender: Any) {
        if player != nil {
            player?.pause()
            player?.volume = musicSlider.value
            player?.play()
        }
    }
}



extension PlayMusicViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}


extension PlayMusicViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.trackList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongTableViewCell", for: indexPath) as! SongTableViewCell
        let track = self.trackList[indexPath.row]
        cell.setupCell(model: track)
        
        return cell
    }
}
