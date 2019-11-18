//
//  NetworkManager.swift
//  decibel
//
//  Created by Eldhose Lomy on 17/11/19.
//  Copyright © 2019 hacker.earth. All rights reserved.
//

import Foundation

enum Services: String{
    
    case songs = "studio"

    private var url: URL{
        return URL(string: Constants.baseURL +  self.rawValue)!
    }
    
    func get(result: @escaping (Result<Library, Error>) -> Void){
        URLSession.shared.dataWithTask(with: self.url, result: result).resume()
    }
}


extension URLSession {
    
    @discardableResult
    func dataWithTask<T>(with url: URL, result: @escaping (Result<T, Error>) -> Void) -> URLSessionDataTask where T: Codable{
        return dataTask(with: url) { (data, response, error) in
            if let error = error {
                result(.failure(error))
                return
            }
            guard let data = data else {
                let error = NSError(domain: "error", code: 0, userInfo: nil)
                result(.failure(error))
                return
            }
            do{
                let decodedData: T = try JSONDecoder().decode(T.self, from: data)
                result(.success(decodedData))
            }catch {
                result(.failure(error))
            }
        }
    }
}
