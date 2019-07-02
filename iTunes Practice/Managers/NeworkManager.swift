//
//  NeworkManager.swift
//  iTunes Practice
//
//  Created by Michael Tseitlin on 6/29/19.
//  Copyright © 2019 Michael Tseitlin. All rights reserved.
//

import UIKit

class NetworkManager {
    
    static func fetchRequest(url: String, completion: @escaping (ItunesMusic?) -> ()) {
        
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else { return }
            
            do {
                let itunesMusic = try JSONDecoder().decode(ItunesMusic.self, from: data)
                completion(itunesMusic)
            } catch {
                print(error.localizedDescription)
                completion(nil)
            }
            
            }.resume()
    }
    
    static func fetchImage(imageUrl: String, completion: @escaping (UIImage) -> ()) {
        
        guard let url = URL(string: imageUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data, let image = UIImage(data: data) else { return }
            completion(image)
            
            }.resume()
    }
}
