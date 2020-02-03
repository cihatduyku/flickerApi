//
//  GetRecentPhotos.swift
//  FlickrApi
//
//  Created by Cihat Duyku on 27.01.2020.
//  Copyright © 2020 Cihat Duyku. All rights reserved.
//

import Foundation

class APIClient {

    private let flickrKey = "16b4377d08408be8e10d9c0e8159ac8e"
    private let baseURL = "https://www.flickr.com/"
    
    func getURL(methodName: String, queryItems: String) -> URL
    {
        let url = URL(string: "\(baseURL)services/rest/?method=\(methodName)&api_key=\(flickrKey)&\(queryItems)")!
        return url
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func getRecentPhotos(pageNumber: Int = 1,completion: @escaping (Photos) -> Void) {
        let methodName = "flickr.photos.getRecent"
        let queryItems = "per_page=20&page=\(pageNumber)&format=json&nojsoncallback=1"
        let url = getURL(methodName: methodName, queryItems: queryItems)
        
          getData(from: url) { data, response, error in
            guard let data = data else { return }
        
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode(Photos.self, from:
                    data)
                
                completion(model)
                
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
    }
}

