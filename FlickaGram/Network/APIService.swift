//
//  APIService.swift
//  FlickaGram
//
//  Created by Anoop Kharsu on 23/11/22.
//

import Foundation

class APIService {
    static let shared = APIService()
    
    func request<T> (request: URLRequest, callback: @escaping (T) -> Void) where T: Codable  {
        
        URLSession.shared.dataTask(with:  request) { data, res, err in
            if let err = err {
                print(err)
                // error callback
                return
            }
            do {
                if let data = data {
//                    print(try JSONDecoder().decode(String.self, from: data))
                    let encodedData = try JSONDecoder().decode(T.self, from: data)
                    DispatchQueue.main.async {
                        callback(encodedData)
                    }
                }
            }catch {
                print(error)
            }
        }.resume()
    }
    
}

