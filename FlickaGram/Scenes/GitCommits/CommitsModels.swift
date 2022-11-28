//
//  CommitsModels.swift
//  FlickaGram
//
//  Created by Anoop Kharsu on 28/11/22.
//

import Foundation

struct CommitsModels {
    //    struct Request {
    //        let userName: String
    //        let repo: String
    //    }
    //    we going to have different file(in Network group) which will provide url from above struct (right now using direct function)
    
    static func getRequest() -> URLRequest {
        let url = URL(string:"https://api.github.com/repos/anoopkharsu/FlickaGram/commits")!
        let request = URLRequest(url: url )
        return request
    }
    
    struct Commit: Codable {
        let commit: CommitDetails
    }
    
    struct CommitDetails: Codable {
        let author: User
        let committer: User
        let message: String
    }
    
    struct User: Codable {
        let name: String
        let email: String
        let date: String
        
        var fromattedDate: Date? {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZ"
            return dateFormatter.date(from: date)
        }
    }
    
}
