//
//  CommitsInteractor.swift
//  FlickaGram
//
//  Created by Anoop Kharsu on 28/11/22.
//

import Foundation
class CommitsInteractor {
    
    weak var delegate: CommitsInteractorDelegate?
    
    
    func getCommits() {
        let req = CommitsModels.getRequest()
        APIService.shared.request(request: req, callback: callback)
    }
    
    private func callback(res: [CommitsModels.Commit]) {
        delegate?.reloadList(res)
    }
}


protocol CommitsInteractorDelegate: AnyObject {
    func reloadList(_ commits: [CommitsModels.Commit])
}
