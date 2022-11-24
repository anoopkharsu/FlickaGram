//
//  FlickrImageListModels.swift
//  FlickaGram
//
//  Created by Anoop Kharsu on 23/11/22.
//

import Foundation

struct FlickrImageListModels {
    
//    struct Request {
//        let text: String
//        let page: Int
//    }
//    we going to have different file(in Network group) which will provide url from above struct (right now using direct function)
    
    static func getRequest(_ page: Int, text: String = "cars") -> URLRequest {
        let url = URL(string: "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(Constants.api_key)&text=\(text)&per_page=25&page=\(page)&format=json&nojsoncallback=1")!
        
        let request = URLRequest(url: url )
        
        return request
    }
    
    
    struct Response: Codable {
        let photos : Photos
        let stat: String
    }
    
    struct Photos: Codable {
        let page: Int
        let pages: Int
        let perpage: Int
        let total: Int
        var photo: [Photo]
        
    }
    
    
    struct Photo: Codable {
        let title: String
        let id: String
        var secret: String
        let farm: Int
        let server: String
        
        var url: URL? {
            URL(string: "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret).jpg")
        }
    }
    
    
    
}
