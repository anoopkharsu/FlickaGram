//
//  FlickrImageListInteractor.swift
//  FlickaGram
//
//  Created by Anoop Kharsu on 23/11/22.
//

import Foundation

class FlickrImageListInteractor {
    typealias Model = FlickrImageListModels
    
    private var images = [Model.Photo]()
    private var page = 1
    private var totalPages = -1
    private var fetching = false
    
    weak var delegate: FlickrImageListDelegate?
    
    func getNextImages() {
        if fetching {return}
        fetching = true
        
        if totalPages == -1 || page <= totalPages {
            APIService.shared.request(request: Model.getRequest(page), callback: callback)
        }
    }
    
    private func callback(_ res: Model.Response) {
        fetching = false
        if res.stat == "ok" {
            images.append(contentsOf: res.photos.photo)
            self.page = res.photos.page+1
        }
        
        delegate?.reloadList(images)
    }
}

protocol FlickrImageListDelegate: AnyObject {
    func reloadList(_ images: [FlickrImageListModels.Photo])
}
