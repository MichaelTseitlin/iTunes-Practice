//
//  ItunesMusic.swift
//  iTunes Practice
//
//  Created by Michael Tseitlin on 6/29/19.
//  Copyright © 2019 Michael Tseitlin. All rights reserved.
//

import Foundation

struct ItunesMusic: Codable {

    let results: [Music]?
}

struct Music: Codable {
    let artistName: String?
    let collectionName: String?
    let trackName: String?
    let previewUrl: String?
    let artworkUrl100: String?
}
