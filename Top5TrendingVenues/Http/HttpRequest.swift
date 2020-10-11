//
//  HttpRequest.swift
//  Top5TrendingVenues
//
//  Created by Georgi on 9.10.20.
//

import Foundation

protocol HttpRequest: AnyObject {
    func decode(_ data: Data)
}

extension HttpRequest {
    func execRequest(request: URLRequest) {
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
        
        let task = session.dataTask(with: request, completionHandler: { [weak self] (data: Data?, response: URLResponse?, error: Error?) -> Void in
            guard let data = data else {
                return
            }
            
            self?.decode(data)
        })
        
        task.resume()
    }
}
