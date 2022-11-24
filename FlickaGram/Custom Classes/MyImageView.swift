//
//  MyImageView.swift
//  FlickaGram
//
//  Created by Anoop Kharsu on 23/11/22.
//

import UIKit

class MyImageView: UIImageView {
    var url: URL?
    let imageCache = URLCache()
    
    func setImage(with url: URL) {
        self.image = nil
        self.url = url
        
        if let data = imageCache.cachedResponse(for: URLRequest(url: url))?.data {
            self.image = UIImage(data: data)
        } else {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) , self.url == url{ // some cache not working(reset) can be improved with urlsession
                    DispatchQueue.main.async {
                        self.image = UIImage(data: data)
                    }
                }
            }
        }
    }
}

