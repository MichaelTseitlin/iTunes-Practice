//
//  Extension+UIImageView.swift
//  iTunes Practice
//
//  Created by Michael Tseitlin on 7/2/19.
//  Copyright © 2019 Michael Tseitlin. All rights reserved.
//

import UIKit
import AVFoundation

extension UIImageView {

    // MARK: - Animating
    
    func animateBy(scale: CGAffineTransform) {
        UIView.animate(withDuration: 0.5) {
            self.transform = scale
        }
    }
    
    func animateBy(scale: CGAffineTransform, transform: CGAffineTransform?) {
        
        let upAndRedusctionTransform = scale.concatenating(transform ??
            CGAffineTransform(translationX: self.frame.width, y: self.frame.height))
        
        UIView.animate(withDuration: 0.5) {
            self.transform = upAndRedusctionTransform
        }
        
    }
    
    func animateSize(dependingOn player: AVPlayer) {
        
        if player.isPlaying {
            UIView.animate(withDuration: 0.5) {
                self.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
        } else {
            UIView.animate(withDuration: 0.5) {
                self.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
            }
        }
    }
    
    
}
