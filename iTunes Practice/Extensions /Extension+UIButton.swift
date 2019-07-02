//
//  Extension+UIButton.swift
//  iTunes Practice
//
//  Created by Michael Tseitlin on 7/2/19.
//  Copyright © 2019 Michael Tseitlin. All rights reserved.
//

import UIKit
import AVFoundation

extension UIButton {
    
    func animateButton() {
        UIView.animate(withDuration: 0.1, animations: {
            self.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }) { _ in
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
    
    func setImage(dependingOn player: AVPlayer) {
        if player.isPlaying {
            self.setImage(UIImage(named: "pause"), for: .normal)
        } else {
            self.setImage(UIImage(named: "play"), for: .normal)
        }
    }
}
