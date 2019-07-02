//
//  DetailViewController.swift
//  iTunes Practice
//
//  Created by Michael Tseitlin on 6/29/19.
//  Copyright © 2019 Michael Tseitlin. All rights reserved.
//

import UIKit
import AVFoundation

class DetailViewController: UIViewController {
    
    // MARK: - Properties
    
    var music: Music!
    private var player: AVPlayer!
    private var timer: Timer?
    
    // MARK: - @IBOutlet
    
    @IBOutlet var artWorkImageView: UIImageView!
    
    @IBOutlet var trackNameLabel: UILabel!
    @IBOutlet var collectionNameLabel: UILabel!
    
    @IBOutlet var slider: UISlider!
    
    @IBOutlet var leftTimeLabel: UILabel!
    @IBOutlet var rightTimeLabel: UILabel!
    
    @IBOutlet var playPauseButton: UIButton!
    
    // MARK: - UIMethods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        trackNameLabel.text = music.trackName
        collectionNameLabel.text = music.collectionName
        
        NetworkManager.fetchImage(imageUrl: music.artworkUrl100!) { image in
            DispatchQueue.main.async {
                self.artWorkImageView.image = image
            }
        }
        
        navigationController?.navigationBar.tintColor = .white
        slider.setThumbImage(UIImage(named: "thumb"), for: .normal)
        
        prepareStreaming()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.async {
            guard let player = self.player else { return }
            guard let duration = player.currentItem?.asset.duration else { return }
            
            self.slider.maximumValue = Float(duration.seconds)
            player.play()
            
            self.timer = Timer.scheduledTimer(timeInterval: 0.0001, target: self, selector: #selector(self.updateSlider), userInfo: nil, repeats: true)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        player.pause()
    }
    
    // MARK: - @IBActions
    
    @IBAction func playPausePressed(_ sender: UIButton) {
       
        sender.animateButton()
       
        if player.isPlaying {
            player.pause()
            playPauseButton.setImage(dependingOn: player)
            artWorkImageView.animateSize(dependingOn: player)
        } else {
            player.play()
            playPauseButton.setImage(dependingOn: player)
            artWorkImageView.animateSize(dependingOn: player)
        }
    }
    
    @IBAction func rewindBackward(_ sender: UIButton) {
        
        sender.animateButton()
        
        slider.value -= 5.0
        sliderValueChanged(slider)
        
        if player.isPlaying {
            player.play()
            playPauseButton.setImage(dependingOn: player)
        } else {
            player.pause()
            playPauseButton.setImage(dependingOn: player)
        }
    }
    
    @IBAction func rewindForward(_ sender: UIButton) {
        
        sender.animateButton()
        
        slider.value += 5.0
        sliderValueChanged(slider)
        
        if player.isPlaying {
            player.play()
            playPauseButton.setImage(dependingOn: player)
        } else {
            player.pause()
            playPauseButton.setImage(dependingOn: player)
        }
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        
        guard let player = player else { return }
        
        let seconds = Int64(sender.value)
        let targetTime = CMTimeMake(value: seconds, timescale: 1)
        
        if sender.isTracking && player.isPlaying {
            
            artWorkImageView.animateBy(scale: CGAffineTransform(scaleX: 0.85, y: 0.85))
            
        } else if sender.isTracking && !player.isPlaying {
            
            artWorkImageView.animateSize(dependingOn: player)
            artWorkImageView.animateBy(scale: CGAffineTransform(scaleX: 0.75, y: 0.75),
                                     transform: CGAffineTransform(translationX: 0, y: 0 - (artWorkImageView.frame.height / 6)))
            
        } else {
            artWorkImageView.animateSize(dependingOn: player)
        }
        
        player.seek(to: targetTime)
    }
    
    // MARK: - Custom Methods
    
    private func prepareStreaming() {
        
        guard let previewUrl = music.previewUrl else { return }
        guard let url = URL(string: previewUrl) else { return }
        
        let playerItem: AVPlayerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
    }
    
    @objc func updateSlider() {
        
        guard let player = player else { return }
        
        let currentTime = player.currentTime().seconds
        slider.value = Float(currentTime)
        
        let totalTime = player.currentItem?.asset.duration.seconds ?? 0.0
        let remainingTimeInSeconds = currentTime - totalTime
        
        leftTimeLabel.text = player.currentTime().seconds.getFormattedTime()
        rightTimeLabel.text = remainingTimeInSeconds.getFormattedTime()
        
        if remainingTimeInSeconds == 0.0 {
            
            player.pause()
            
            playPauseButton.setImage(dependingOn: player)
            artWorkImageView.animateBy(scale: CGAffineTransform(scaleX: 0.75, y: 0.75))
        }
    }
}
