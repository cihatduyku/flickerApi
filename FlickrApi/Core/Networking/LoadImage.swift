//
//  LoadImage.swift
//  FlickrApi
//
//  Created by Cihat Duyku on 1.02.2020.
//  Copyright © 2020 Cihat Duyku. All rights reserved.
//

import Foundation
import UIKit

class LoadImage {
    
    //Cash yapısı sayesinde indirilmiş dosyaları tekrar indirilmiyor.
    internal var cache = NSCache<NSURL, UIImage>()
    
    func load(from link: String, completion: @escaping (_ image: UIImage) -> Void) {
        let url = URL(string: link)
        
        if let image = self.cache.object(forKey: url! as NSURL) {
            completion(image)
            return
        }
        
        getData(from: url!) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url!.lastPathComponent)
            
            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.cache.setObject(image, forKey: url! as NSURL)
                    completion(image)
                }
            } else {
                print("Image Decode Edilemedi")
            }
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
}
