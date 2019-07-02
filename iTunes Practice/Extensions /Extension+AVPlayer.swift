//
//  Extension+AVPlayer.swift
//  iTunes Practice
//
//  Created by Michael Tseitlin on 6/29/19.
//  Copyright © 2019 Michael Tseitlin. All rights reserved.
//

import AVFoundation
import UIKit

extension AVPlayer {
    
    var isPlaying: Bool {
        return rate != 0 && error == nil
    }
}


