//
//  Photos.swift
//  FlickrApi
//
//  Created by Cihat Duyku on 27.01.2020.
//  Copyright © 2020 Cihat Duyku. All rights reserved.
//

import Foundation

struct Photos: Codable {
    let photos: PhotosClass
    let stat: String
}

struct PhotosClass: Codable {
    let page, pages, total, perpage: Int
    let photo: [Photo]
}

struct Photo: Codable, PhotoURL {
    let id, owner, secret, server: String
    let farm: Int
    let title: String
    let ispublic, isfriend, isfamily: Int
}

protocol PhotoURL {}

extension PhotoURL where Self == Photo{
    
    func getImagePath() -> String?{
        let path = "https://farm\(self.farm).static.flickr.com/\(self.server)/\(self.id)_\(self.secret).jpg"
        return path
    }
    
}
