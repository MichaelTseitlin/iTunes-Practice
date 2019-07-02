//
//  TableViewCell.swift
//  iTunes Practice
//
//  Created by Michael Tseitlin on 6/29/19.
//  Copyright © 2019 Michael Tseitlin. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet var trackNameLabel: UILabel!
    @IBOutlet var artistNameLabel: UILabel!
    @IBOutlet var collectionNameLabel: UILabel!
    @IBOutlet var artWorkImageView: UIImageView! {
        didSet {
            artWorkImageView.layer.cornerRadius = 5
            artWorkImageView.layer.masksToBounds = true
        }
    }
    
    func config(imageUrl: String, music: Music) {
        
        self.trackNameLabel.text = music.trackName
        self.artistNameLabel.text = music.artistName
        self.collectionNameLabel.text = music.collectionName
        
        NetworkManager.fetchImage(imageUrl: imageUrl) { image in
            DispatchQueue.main.async {
                self.artWorkImageView.image = image
            }
        }
    }
}
